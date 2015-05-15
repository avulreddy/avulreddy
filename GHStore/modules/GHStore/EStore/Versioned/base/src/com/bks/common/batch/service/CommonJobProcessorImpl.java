package com.bks.common.batch.service;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintStream;

import javax.transaction.TransactionManager;

import atg.core.io.FileUtils;
import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.epub.project.Process;
import atg.nucleus.GenericService;
import atg.process.action.ActionException;
import atg.service.perfmonitor.PerformanceMonitor;
import atg.versionmanager.exceptions.VersionException;
import atg.workflow.WorkflowException;

import com.bks.common.batch.manager.IJobManager;
import com.bks.common.batch.util.BatchJobConstants;
import com.bks.common.batch.util.DateUtils;
import com.bks.common.batch.util.FileUtil;
import com.bks.common.batch.util.JobLogger;
import com.bks.common.batch.util.WorkflowUtil;
import com.bks.common.batch.vo.ImportData;

/**
 * This class implements JobProcessor. Provides common functionality for the
 * feed jobs such as reading input feed files, parsing each file using Manager
 * component, processing each file content and Auto/Manual depeloying each file
 * records by creating a workflow project for each file.
 * @author REV
 * @version 1.0
 * @created 02-Mar-2011 2:12:03 PM
 */

public class CommonJobProcessorImpl extends GenericService implements
		IJobProcessor {

	/**
	 * CLASS_NAME : class name.
	 */
	private final String className = this.getClass().getName();

	/**
	 * autoWorkflowName : workflow for auto deployments.
	 */
	private String autoWorkflowName;
	/**
	 * enableAutoImport : auto deployment will be done if this flag is true.
	 */
	private boolean enableAutoImport;
	/**
	 * enableManualImport : manual deployment will be done if this flag is set.
	 * to true
	 */
	private boolean enableManualImport;
	/**
	 * jobManager : Manager Component to parse & process feed file contents.
	 */
	private IJobManager jobManager;
	/**
	 * manualWorkflowName : workflow formanual deployment.
	 */
	private String manualWorkflowName;
	/**
	 * transactionManager : transactionManager.
	 */
	private TransactionManager transactionManager;
	/**
	 * workflowUtil : workflowUtil component.
	 */
	private WorkflowUtil workflowUtil;
	/**
	 * importFeedPath : input fedd file location.
	 */
	private String importFeedPath;
	/**
	 * jobLogger : Logger for Feed logging.
	 */
	private JobLogger jobLogger;
	/**
	 * archivePath : feed file archive location.
	 */
	private String archivePath;
	/**
	 * errorPath : error location for feed file.
	 */
	private String errorPath;
	/**
	 * loggerPath : feed log file path.
	 */
	private String loggerPath;
	/**
	 * mFileNameDateFormat . Date format of current date will be appended to
	 * workflow project name
	 */
	private String mFileNameDateFormat;
	/**
	 * mJobName : job name.
	 */
	private String mJobName;

	/**
	 * default constructor.
	 */
	public CommonJobProcessorImpl() {
		super();

	}

	/**
	 * returns archive path.
	 * @return archivePath archive path.
	 */
	public String getArchivePath() {
		return archivePath;
	}

	/**
	 * sets archive path.
	 * @param pArchivePath
	 *            archive path
	 */
	public void setArchivePath(String pArchivePath) {
		this.archivePath = pArchivePath;
	}

	/**
	 * returns error path.
	 * @return errorPath error path
	 */
	public String getErrorPath() {
		return errorPath;
	}

	/**
	 * sets error path.
	 * @param pErrorPath
	 *            error path
	 */
	public void setErrorPath(String pErrorPath) {
		this.errorPath = pErrorPath;
	}

	/**
	 * returns import feed path.
	 * @return importFeedPath
	 */
	public String getImportFeedPath() {
		return importFeedPath;
	}

	/**
	 * sets import feed path.
	 * @param pImportFeedPath
	 *            import feed path
	 */
	public void setImportFeedPath(String pImportFeedPath) {
		this.importFeedPath = pImportFeedPath;
	}

	/**
	 * returns workflow util component.
	 * @return workflowUtil workflowutil.
	 */
	public WorkflowUtil getWorkflowUtil() {
		return workflowUtil;
	}

	/**
	 * set workflow component.
	 * @param pWorkflowUtil
	 *            workflowutil component.
	 */
	public void setWorkflowUtil(WorkflowUtil pWorkflowUtil) {
		this.workflowUtil = pWorkflowUtil;
	}

	/**
	 * Initalizes logger component for feed logging.
	 * @return boolean returns true/false based on initialization status.
	 */
	public boolean initLogger() {

		boolean result = false;
		PerformanceMonitor.startOperation(className + "initLogger");

		if (getLoggerPath() != null && getJobName() != null) {
			getJobLogger().init(getLoggerPath() + getLogFileName());
			result = true;
		}

		PerformanceMonitor.endOperation(className + "initLogger");
		return result;
	}

	/**
	 * archives input file based on file processing status.
	 * @param pInputFile
	 *            input feed file.
	 * @param pArchivePath
	 *            archive location.
	 * @param pErrorPath
	 *            error file location.
	 * @param status
	 *            file processing status.
	 */
	public void archiveFile(File pInputFile, String pArchivePath,
			String pErrorPath, int status) {
		PerformanceMonitor.startOperation(className + "archiveFile");
		try {
			if (status == BatchJobConstants.SUCCESS) {
				FileUtils.copyFile(pInputFile.getAbsolutePath(),
						getArchivePath() + pInputFile.getName());
				getJobLogger().logDebug(
						"File moved to Archive File Path :" + getArchivePath()
								+ pInputFile.getName());
			} else {
				FileUtils.copyFile(pInputFile.getAbsolutePath(), getErrorPath()
						+ pInputFile.getName());
				getJobLogger().logError(
						"File moved to Error File Path :" + getErrorPath()
								+ pInputFile.getName());
			}
			FileUtils.deleteFile(pInputFile.getAbsolutePath());
			getJobLogger().logDebug(
					"successfullt deleted source file :"
							+ pInputFile.getAbsolutePath());
		} catch (IOException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError(
						"Exception while archiving the source file : "
								+ e.getMessage());
			}
			getJobLogger().logError(
					"File moved to Error File Path :" + getErrorPath()
							+ pInputFile.getName());
		}
		PerformanceMonitor.endOperation(className + "archiveFile");
	}

	/**
	 * This method creates new work flow project. Processes records for
	 * autoDeployment and moves work flow for auto deployment
	 * @param importData
	 *            importData object to be processed.
	 * @return successfully processed record count
	 * @throws VersionException
	 *             VersionException
	 * @throws TransactionDemarcationException
	 *             TransactionDemarcationException
	 * @throws WorkflowException
	 *             WorkflowException
	 */
	public int executeAutoDeploy(ImportData importData)
			throws VersionException, TransactionDemarcationException,
			WorkflowException, ActionException {
		PerformanceMonitor.startOperation(className + "executeAutoDeploy");

		getJobLogger().logInfo("Entered execute AutoDeploy");
		TransactionDemarcation lTransactionDemarcation = getTransactionDemarcation();
		boolean rollback = false;
		int processedRecords = 0;
		try {
			if (importData.getAutoImportData() != null
					&& importData.getAutoImportData().size() > 0) {
				lTransactionDemarcation.begin(getTransactionManager(),
						TransactionDemarcation.REQUIRED);
				Process lProcess = getWorkflowUtil()
						.createProcessForDevelopment(importData.getFileName(),
								getAutoWorkflowName());
				if (lProcess != null) {
					try {
						processedRecords = processAutoImportData(importData);
						if (processedRecords == 0) {
							rollback = true;
						}
					} catch (Exception e) {
						getJobLogger().logError(
								"Error while executing processAutoImportData"
										+ e.getMessage(), e.getCause());
						rollback = true;
					} finally {
						if (isLoggingDebug()) {
							logDebug("ending Transaction1");
						}
						try {
							lTransactionDemarcation.end(rollback);
						} catch (TransactionDemarcationException e) {
							rollback = true;
							if (isLoggingError()) {
								logError("TransactionDemarcationException Exception : "
										+ e.getMessage());
							}
						}
					}
					if (isLoggingDebug()) {
						logDebug("creating Transaction2 for resuming auto deploy");
					}
					// open new transaction
					lTransactionDemarcation = getTransactionDemarcation();

					getWorkflowUtil().resumeAutoWorkflow(lProcess,
							lTransactionDemarcation, rollback);

				} else {
					getJobLogger()
							.logError("Unable to create Workflow project");
				}

			} else {
				getJobLogger().logError(
						"There are no Items in the CSV to be created/updated hence not creating "
								+ "a project and Deploying ::::");
			}
			rollback = false;
		} catch (VersionException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError("VersionException : " + e.getMessage(),
						e.getCause());
			}
			throw e;
		} catch (TransactionDemarcationException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError(
						"TransactionDemarcationException : " + e.getMessage(),
						e.getCause());
			}
			throw e;
		} catch (WorkflowException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError(
						"WorkflowException : " + e.getMessage(), e.getCause());
			}
			throw e;
		} catch (ActionException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError("ActionException : " + e.getMessage(),
						e.getCause());
				ByteArrayOutputStream tempStream = null;
				PrintStream tempPrintStream = null;
				try {
					tempStream = new ByteArrayOutputStream();
					tempPrintStream = new PrintStream(tempStream);
					e.printStackTrace(tempPrintStream);
					tempStream.flush();
					if (tempStream != null) {
						getJobLogger().logError(
								"ActionException Cause: "
										+ tempStream.toString(), e.getCause());
					}
				} catch (IOException ex) {
					getJobLogger().logError("Exception : " + ex.getMessage(),
							ex.getCause());
				} finally {
					try {
						tempStream.close();
						tempPrintStream.close();
					} catch (Exception exception) {
						getJobLogger().logError(
								"Exception : " + exception.getMessage(),
								exception.getCause());
					}
				}
			}
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError("Exception : " + e.getMessage(),
						e.getCause());
			}
			// throw e;
		}
		getJobLogger().logInfo("execute Auto deploy ended ");
		PerformanceMonitor.endOperation(className + "executeAutoDeploy");
		return processedRecords;
	}

	/**
	 * This method gets list of import feed files from given input feed folder.
	 * processes each file and auto deploys marked records if autoDeployment is
	 * enabled. Also does manual deployment of manual- deployable records.
	 * Archives each feed file based on processing status.
	 */
	public void executeImportProcess() {
		PerformanceMonitor.startOperation(className + "executeImportProcess");

		File[] files = null;
		int fileProcessStatus = 0;
		int fileAutoProcessStatus = 0;
		int fileManualProcessStatus = 0;
		int processedAutoRecords = 0;
		int processedManualRecords = 0;
		getJobLogger().logDebug("executeImport process invoked");
		try {
			// initialize logger
			boolean logInitResult = initLogger();
			if (!logInitResult) {
				getJobLogger().logError("Error initializing Logger");
				return;
			}
			// get list of feed files
			if (getImportFeedPath() != null) {
				files = getInputFiles(getImportFeedPath());
			}
			// process each file if file list is not empty
			if (files != null && files.length > 0) {
				getJobLogger().logDebug(
						"Total Files for processing :" + files.length);
				// process each file
				for (File file : files) {
					getJobLogger().logDebug(
							"Processing File :" + file.getAbsolutePath());
					// reset status flags
					processedAutoRecords = 0;
					processedManualRecords = 0;
					fileAutoProcessStatus = BatchJobConstants.SUCCESS;
					fileManualProcessStatus = BatchJobConstants.SUCCESS;
					fileProcessStatus = BatchJobConstants.FAILED;
					// parse each file if the length of file is more than 0
					if (file.length() > 0) {
						ImportData importData = processFile(file);
						getJobLogger().logDebug(
								"processing file:" + file.getAbsolutePath());
						// auto deploy if autoDeployment enabled
						if (isEnableAutoImport() && importData != null
								&& importData.getAutoImportData() != null
								&& importData.getAutoImportData().size() > 0) {
							getJobLogger().logDebug(
									"Total Auto Records :"
											+ importData.getAutoImportData()
													.size());

							fileAutoProcessStatus = BatchJobConstants.FAILED;
							try {
								processedAutoRecords = executeAutoDeploy(importData);
							} catch (VersionException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Auto Deployment :"
												+ e.getMessage());
								throw e;
							} catch (WorkflowException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Auto Deployment :"
												+ e.getMessage(), e.getCause());
							} catch (TransactionDemarcationException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Auto Deployment :"
												+ e.getMessage(), e.getCause());
							} catch (ActionException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Auto Deployment :"
												+ e.getMessage(), e.getCause());
							}
							getJobLogger().logDebug(
									"Auto Records in File:"
											+ importData.getTotalAutoRecords());
							getJobLogger().logDebug(
									"Processed Auto Records:"
											+ processedAutoRecords);
							// calculate file processing status
							fileAutoProcessStatus = getFileProcessStatus(
									importData.getTotalAutoRecords(),
									processedAutoRecords);

							getJobLogger().logDebug(
									"File Auto Process status:"
											+ fileAutoProcessStatus);
							// getJobLogger().logDebug("File Archival
							// complete:"+file.getAbsolutePath());
						} else {
							if (isEnableAutoImport() && importData != null) {
								getJobLogger()
										.logError(
												"No records avaialble for Auto Deployment processing");
								// calculate file processing status
								fileAutoProcessStatus = getFileProcessStatus(
										importData.getTotalAutoRecords(),
										processedAutoRecords);
							}
						}
						// manual deploy if manualDeploy is enabled
						if (isEnableManualImport() && importData != null
								&& importData.getManualImportData() != null
								&& importData.getManualImportData().size() > 0) {
							getJobLogger().logDebug(
									"Total Manual Records :"
											+ importData.getManualImportData()
													.size());
							fileManualProcessStatus = BatchJobConstants.FAILED;
							try {
								processedManualRecords = executeManualDeploy(importData);
							} catch (VersionException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Manual Deployment :"
												+ e.getMessage(), e.getCause());
							} catch (WorkflowException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Manual Deployment :"
												+ e.getMessage(), e.getCause());
							} catch (TransactionDemarcationException e) {
								e.printStackTrace();
								getJobLogger().logError(
										"Error during executing Manual Deployment :"
												+ e.getMessage(), e.getCause());
							}
							getJobLogger().logDebug(
									"Manual Records in File:"
											+ importData
													.getTotalManualRecords());

							getJobLogger().logDebug(
									"Processed Manual Records:"
											+ processedManualRecords);
							// determine manual processing status
							fileManualProcessStatus = getFileProcessStatus(
									importData.getTotalManualRecords(),
									processedManualRecords);

							getJobLogger().logDebug(
									"File Manual Process status:"
											+ fileManualProcessStatus);
						} else {
							if (isEnableManualImport() && importData != null) {
								getJobLogger()
										.logError(
												"No records avaialble for manual deployment processing");

								// determine manual processing status

								fileManualProcessStatus = getFileProcessStatus(
										importData.getTotalManualRecords(),
										processedManualRecords);
							}
						}
						if ((fileAutoProcessStatus == BatchJobConstants.SUCCESS)
								&& (fileManualProcessStatus == BatchJobConstants.SUCCESS)) {
							fileProcessStatus = BatchJobConstants.SUCCESS;
						} else {
							fileProcessStatus = BatchJobConstants.FAILED;
						}
						// write error records generated while processing the
						// file
						if (importData.getErrorRecords() != null
								&& importData.getErrorRecords().size() > 0) {
							getJobLogger().writeErrorRecords(
									importData.getErrorRecords(),
									file.getAbsolutePath());
						} else {
							getJobLogger().logDebug(
									"No error records found in feed");
						}

						// archive file
						archiveFile(file, getArchivePath(), getErrorPath(),
								fileProcessStatus);

					} else {
						if (isLoggingError()) {
							// logError("Empty Input File" +
							// file.getAbsolutePath());
							getJobLogger().logError(
									"Empty input File:"
											+ file.getAbsolutePath());
						}
					} // end else file length
				}
			} // end files!=null
			else {
				getJobLogger().logError("No files to process");
			}
		} catch (VersionException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError("Exception  : " + e.getMessage(),
						e.getCause());
			}
		}
		getJobLogger().closeFileLog();
		PerformanceMonitor.endOperation(className + "executeImportProcess");

	}

	/**
	 * This method returns the File processing status.
	 * @param fileRecords
	 *            number of records in the feed file
	 * @param processedRecords
	 *            number of processed records
	 * @return int File processing status
	 */
	public int getFileProcessStatus(int fileRecords, int processedRecords) {

		return BatchJobConstants.SUCCESS;
	}

	/**
	 * This method creates new workflow project. Processes records for
	 * manualDeployment and moves workflow for manual deployment
	 * @param importData
	 *            importData object for manual deployment.
	 * @return int returns count of successfully processed records.
	 * @throws TransactionDemarcationException
	 *             TransactionDemarcationException.
	 * @throws WorkflowException
	 *             WorkflowException
	 * @throws VersionException
	 *             VersionException
	 */
	public int executeManualDeploy(ImportData importData)
			throws WorkflowException, VersionException,
			TransactionDemarcationException {
		PerformanceMonitor.startOperation(className + "executeManualDeploy");

		TransactionDemarcation lTransactionDemarcation = getTransactionDemarcation();
		boolean rollback = false;
		int processedRecords = 0;
		try {
			if (importData.getManualImportData() != null
					&& importData.getManualImportData().size() > 0) {
				lTransactionDemarcation.begin(getTransactionManager(),
						TransactionDemarcation.REQUIRED);

				Process lProcess = getWorkflowUtil()
						.createProcessForDevelopment(importData.getFileName(),
								getManualWorkflowName());
				if (lProcess != null) {
					try {
						processedRecords = processManualImportData(importData);
					} catch (Exception e) {
						e.printStackTrace();
						getJobLogger().logError(
								"Error while executing processManualImportData"
										+ e.getMessage());
						rollback = true;
					}/*
						 * finally{ try { lTransactionDemarcation.end(rollback); }
						 * catch (TransactionDemarcationException e) { if
						 * (isLoggingError()) {
						 * logError("TransactionDemarcationException Exception : " +
						 * e.getMessage()); } } } //open new transaction
						 * lTransactionDemarcation =
						 * getTransactionDemarcation();
						 */
					getWorkflowUtil().resumeManualWorkflow(lProcess,
							lTransactionDemarcation, rollback);
				} else {
					getJobLogger()
							.logError("Unable to create Workflow project");
				}

			} else {
				jobLogger
						.logError("There are no Items in the Feed CSV to be created/updated hence not creating "
								+ "a project and Deploying ::::");
			}

		} catch (TransactionDemarcationException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				logError("TransactionDemarcationException : " + e.getMessage());
			}
			throw e;
		} catch (Exception e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError("Exception : " + e.getMessage(),
						e.getCause());
			}
			// throw e;
		}

		PerformanceMonitor.endOperation(className + "executeManualDeploy");
		return processedRecords;
	}

	/**
	 * return Auto Workflow name.
	 * @return autoWorkflowName Auto Workflow name.
	 */
	public String getAutoWorkflowName() {
		return autoWorkflowName;
	}

	/**
	 * returns Job Manager.
	 * @return jobManager.
	 */
	public IJobManager getJobManager() {
		return jobManager;
	}

	/**
	 * returns Manual Workflow Name.
	 * @return manualWorkflowName
	 */
	public String getManualWorkflowName() {
		return manualWorkflowName;
	}

	/**
	 * returns Transaction Manager.
	 * @return transactionManager
	 */
	public TransactionManager getTransactionManager() {
		return transactionManager;
	}

	/**
	 * returns true if autodeployment is enabled.
	 * @return enableAutoImport returns Autodeployment flag
	 */
	public boolean isEnableAutoImport() {
		return enableAutoImport;
	}

	/**
	 * returns true if manualDeployment is enabled.
	 * @return enableManualImport
	 */
	public boolean isEnableManualImport() {
		return enableManualImport;
	}

	/**
	 * Processes auto Import records. Returns count of successfully processed
	 * @param pImportData
	 *            import data object
	 * @return returns count of successfully processed records.
	 */
	public int processAutoImportData(ImportData pImportData) {

		return 0;
	}

	/**
	 * set Auto Workflow Name.
	 * @param newVal
	 *            auto workflow name.
	 */
	public void setAutoWorkflowName(String newVal) {
		autoWorkflowName = newVal;
	}

	/**
	 * enables Auto deployment of assets.
	 * @param newVal
	 *            flag to enable/disable Auto deployments.
	 */
	public void setEnableAutoImport(boolean newVal) {
		enableAutoImport = newVal;
	}

	/**
	 * Enables Manual deployment of assets.
	 * @param newVal
	 *            flag to enable/disable Manual deployment.
	 */
	public void setEnableManualImport(boolean newVal) {
		enableManualImport = newVal;
	}

	/**
	 * set JobManager.
	 * @param newVal
	 *            jobManager component.
	 */
	public void setJobManager(IJobManager newVal) {
		jobManager = newVal;
	}

	/**
	 * set Manual work flow name.
	 * @param newVal
	 *            Manual workflow name.
	 */
	public void setManualWorkflowName(String newVal) {
		manualWorkflowName = newVal;
	}

	/**
	 * set transaction manager.
	 * @param newVal
	 *            TransactionManager.
	 */
	public void setTransactionManager(TransactionManager newVal) {
		transactionManager = newVal;
	}

	/**
	 * retrieves list of input feed files from given location.
	 * @param path
	 *            input feed path.
	 * @return returns list of feed files.
	 */
	public File[] getInputFiles(String path) {
		FileUtil fileUtil = new FileUtil();
		return fileUtil.getFiles(path);

	}

	/**
	 * returns ImportData instance loaded with parsed import file contents.
	 * @param fFile
	 *            input feed file.
	 * @return ImportData returns importData object with parsed file contents.
	 */
	public ImportData processFile(File fFile) {
		PerformanceMonitor.startOperation(className + "processFile");

		ImportData importData = null;
		try {
			importData = getJobManager().parseFile(fFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			if (isLoggingError()) {
				getJobLogger().logError(
						"Exception Exception : " + e.getMessage());
			}
		}
		PerformanceMonitor.endOperation(className + "processFile");
		return importData;

	}

	/**
	 * Processes records for Manual deployment. Returns count of successfully
	 * processed records.
	 * @param pImportData
	 *            importData object.
	 * @return int returns successfully processed records.
	 */
	public int processManualImportData(ImportData pImportData) {
		return 0;
	}

	/**
	 * Gets a new TransactionDemarcation.
	 * @beaninfo hidden: true
	 * @return The value of the property TransactionDemarcation.
	 */
	protected TransactionDemarcation getTransactionDemarcation() {
		return new TransactionDemarcation();
	}

	/**
	 * returns JobLogger.
	 * @return jobLogger job logger.
	 */
	public JobLogger getJobLogger() {
		return jobLogger;
	}

	/**
	 * sets Job Logger.
	 * @param pJobLogger
	 *            job logger.
	 */
	public void setJobLogger(JobLogger pJobLogger) {
		this.jobLogger = pJobLogger;
	}

	/**
	 * returns FileNameDateFormat for naming workflow project.
	 * @return String Date format for file name.
	 */
	public String getFileNameDateFormat() {
		return mFileNameDateFormat;
	}

	/**
	 * sets fileNameDateFormat which is appended to workflow project name.
	 * @param pFileNameDateFormat
	 *            date formant for file name.
	 */
	public void setFileNameDateFormat(String pFileNameDateFormat) {
		mFileNameDateFormat = pFileNameDateFormat;
	}

	/**
	 * Returns the project name for deployment. with the inputfile name
	 * @param fileName
	 *            input fileName
	 * @return String return the project name
	 */
	private String getProjectName(String fileName) {
		String lStrInputFile = fileName.substring(0, fileName.indexOf('.'));
		return lStrInputFile + "_"
				+ DateUtils.getDateString(null, this.getFileNameDateFormat());
	}

	/**
	 * returns log file name.
	 * @return String log file name
	 */
	private String getLogFileName() {
		// String lStrInputFile = fileName.substring(0, fileName.indexOf('.'));
		return getJobName() + "_"
				+ DateUtils.getDateString(null, this.getFileNameDateFormat())
				+ ".log";
	}

	/**
	 * returns log file path.
	 * @return String logger path
	 */
	public String getLoggerPath() {
		return loggerPath;
	}

	/**
	 * sets log file path.
	 * @param pLoggerPath
	 *            logger path
	 */
	public void setLoggerPath(String pLoggerPath) {
		this.loggerPath = pLoggerPath;
	}

	/**
	 * return feed job name.
	 * @return jobName JOB NAME
	 */
	public String getJobName() {
		return mJobName;
	}

	/**
	 * set feed job name.
	 * @param jobName
	 *            job name
	 */
	public void setJobName(String jobName) {
		mJobName = jobName;
	}

}