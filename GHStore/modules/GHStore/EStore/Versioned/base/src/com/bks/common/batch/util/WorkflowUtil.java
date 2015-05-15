package com.bks.common.batch.util;

import javax.ejb.CreateException;
import javax.ejb.EJBException;

import atg.dtm.TransactionDemarcation;
import atg.dtm.TransactionDemarcationException;
import atg.epub.project.Process;
import atg.epub.project.ProcessHome;
import atg.epub.project.ProjectConstants;
import atg.nucleus.GenericService;
import atg.process.action.ActionConstants;
import atg.process.action.ActionException;
import atg.repository.RepositoryItem;
import atg.security.Persona;
import atg.security.ThreadSecurityManager;
import atg.security.User;
import atg.service.perfmonitor.PerformanceMonitor;
import atg.userdirectory.UserDirectoryUserAuthority;
import atg.versionmanager.VersionManager;
import atg.versionmanager.WorkingContext;
import atg.versionmanager.Workspace;
import atg.versionmanager.exceptions.VersionException;
import atg.workflow.ActorAccessException;
import atg.workflow.MissingWorkflowDescriptionException;
import atg.workflow.WorkflowConstants;
import atg.workflow.WorkflowException;
import atg.workflow.WorkflowManager;
import atg.workflow.WorkflowView;

/**
 * This class contains utility methods to create Process workflow and for
 * managing the workflow.
 * @author REV_BelindaQuick
 * @version 1.0
 * @created 02-Mar-2011 2:12:05 PM
 */
public class WorkflowUtil extends GenericService {

	/**
	 * className :class name.
	 */
	private final String className = this.getClass().getName();

	/**
	 * versionManager : versionManager.
	 */
	private VersionManager versionManager;
	/** The fileNameDateFormat. */
	private String mFileNameDateFormat;
	/**
	 * mWorkflowManager : workflowManager.
	 */
	private WorkflowManager mWorkflowManager;
	/**
	 * mPersonaPrefix : persona prefix.
	 */
	private String mPersonaPrefix;
	/**
	 * userName : username for creating publishing workflow.
	 */
	private String userName;
	/**
	 * taskOutcomeId : taskoutcomeId for Manual publishing project.
	 */
	private String taskOutcomeId;
	/**
	 * mProcessNamePropertyName : processName property name.
	 */
	private String mProcessNamePropertyName;
	/**
	 * userAuthority : user authority.
	 */
	private UserDirectoryUserAuthority userAuthority;

	/**
	 * rerurns WorkflowManager.
	 * @return workflowManager pWorkflowManager.
	 */
	public WorkflowManager getWorkflowManager() {
		return mWorkflowManager;
	}

	/**
	 * set workflow Manager.
	 * @param pWorkflowManager
	 *            WorkflowManager
	 */
	public void setWorkflowManager(WorkflowManager pWorkflowManager) {
		this.mWorkflowManager = pWorkflowManager;
	}

	/**
	 * returns version manager.
	 * @return versionManager
	 */
	public VersionManager getVersionManager() {
		return versionManager;
	}

	/**
	 * set version manager.
	 * @param pVersionManager
	 *            version manager
	 */
	public void setVersionManager(VersionManager pVersionManager) {
		this.versionManager = pVersionManager;
	}

	/**
	 * advances given workflow process for auto deployment.
	 * @param pProcess
	 *            workflow process
	 * @param transactionDemarcation
	 *            transactionDemarcation object for the workflow
	 * @throws MissingWorkflowDescriptionException
	 *             MissingWorkflowDescriptionException
	 * @throws ActorAccessException
	 *             ActorAccessException
	 */
	public void advanceWorkflow(Process pProcess,
			TransactionDemarcation transactionDemarcation)
			throws MissingWorkflowDescriptionException, ActorAccessException,
			UnsupportedOperationException, ActionException, Exception {
		PerformanceMonitor.startOperation(className + "advanceWorkflow");
		if (pProcess == null) {
			if (isLoggingError()) {
				logError("Process Object is Null... Please Fix this before Upload...");
			}
		} else {
			// reteives the workflow for the project
			RepositoryItem processWorkflow = pProcess.getProject()
					.getWorkflow();
			if (processWorkflow == null) {
				if (isLoggingError()) {
					logError("ProcessWorkflow Object is Null... Please Fix this before Upload...");
				}
			} else {
				String workflowProcessName = processWorkflow.getPropertyValue(
						getProcessNamePropertyName()).toString();
				String processId = pProcess.getId();
				if (getWorkflowManager() == null) {
					if (isLoggingError()) {
						logError("WorkflowManager object is Null... Please Fix this before Upload...");
					}
				} else {
					WorkflowView workflowView = getWorkflowManager()
							.getWorkflowView(
									ThreadSecurityManager.currentUser());
					if (workflowView == null) {
						if (isLoggingError()) {
							logError("WorkflowView object is Null... Please Fix this before Upload...");
						}
					} else {
						try {
							workflowView.fireTaskOutcome(workflowProcessName,
									WorkflowConstants.DEFAULT_WORKFLOW_SEGMENT,
									processId, taskOutcomeId,
									ActionConstants.ERROR_RESPONSE_DEFAULT);
						} catch (MissingWorkflowDescriptionException e) {
							if (isLoggingError()) {
								logError("MissingWorkflowDescriptionException Exception : "
										+ e.getMessage());
							}
							throw e;
						} catch (ActorAccessException e) {
							if (isLoggingError()) {
								logError("ActorAccessException Exception : "
										+ e.getMessage());
							}
							throw e;
						} catch (UnsupportedOperationException e) {
							if (isLoggingError()) {
								logError("UnsupportedOperationException Exception : "
										+ e.getMessage());
							}
							throw e;
						} catch (ActionException e) {
							if (isLoggingError()) {
								logError("ActionException Exception : "
										+ e.getMessage());
							}
							throw e;
						} catch (Exception e) {
							if (isLoggingError()) {
								logError("Exception : " + e.getMessage());
							}
							throw e;
						} finally {
							PerformanceMonitor.endOperation(className
									+ "advanceWorkflow");
						}
					}
				}
			}
		}
	}

	/**
	 * assume user identity for creating workflow project.
	 * @return boolean.
	 */
	public boolean assumeUserIdentity() {
		PerformanceMonitor.startOperation(className + "assumeUserIdentity");

		boolean ret = Boolean.FALSE.booleanValue();
		if (userAuthority != null) {
			User newUser = new User();
			// get the user for the project
			Persona persona = userAuthority.getPersona(getPersonaPrefix()
					+ userName);
			if (persona != null) {
				newUser.addPersona(persona);
				ThreadSecurityManager.setThreadUser(newUser);
				ret = Boolean.TRUE.booleanValue();
			}
		}
		PerformanceMonitor.endOperation(className + "assumeUserIdentity");
		return ret;
	}

	/**
	 * creates new workflow project using given file name and given workflow.
	 * @param fileName
	 *            input feed filename
	 * @param workflowName
	 *            workflow name for the project
	 * @return workflow project process
	 * @throws WorkflowException
	 *             WorkflowException
	 * @throws VersionException
	 *             VersionException
	 * @throws TransactionDemarcationException
	 *             TransactionDemarcationException
	 */
	public Process createProcessForDevelopment(String fileName,
			String workflowName) throws WorkflowException, VersionException,
			TransactionDemarcationException {
		PerformanceMonitor.startOperation(className
				+ "createProcessForDevelopment");

		Process lProcess = null;

		try {
			// verifies the user identity
			assumeUserIdentity();
			logDebug("WorkflowUtil :: createProcessForDevelopment : Started creating Project :");
			// creates the process home
			ProcessHome lProcessHome = ProjectConstants.getPersistentHomes()
					.getProcessHome();

			lProcess = lProcessHome.createProcessForImport(
					getProjectName(fileName), workflowName);
			String lWorkSpace = lProcess.getProject().getWorkspace();
			// creates the workspace
			Workspace lWorkspace = getVersionManager().getWorkspaceByName(
					lWorkSpace);
			WorkingContext.pushDevelopmentLine(lWorkspace);
		} catch (VersionException e) {
			if (isLoggingError()) {
				logError("VersionException Exception : " + e.getMessage());
			}
			throw e;
		} catch (WorkflowException e) {
			if (isLoggingError()) {
				logError("WorkflowException Exception : " + e.getMessage());
			}
			throw e;
		} catch (TransactionDemarcationException e) {
			if (isLoggingError()) {
				logError("TransactionDemarcationException Exception : "
						+ e.getMessage());
			}
			throw e;
		} catch (EJBException e) {
			if (isLoggingError()) {
				logError("EJBException Exception : " + e.getMessage());
			}
		} catch (ActionException e) {
			if (isLoggingError()) {
				logError("ActionException Exception : " + e.getMessage());
			}
		} catch (CreateException e) {
			if (isLoggingError()) {
				logError("CreateException Exception : " + e.getMessage());
			}
		} finally {
			PerformanceMonitor.endOperation(className
					+ "createProcessForDevelopment");
		}

		return lProcess;
	}

	/**
	 * pop development.
	 */
	public void popDevelopmentLine() {

		WorkingContext.popDevelopmentLine();
	}

	/**
	 * released user identity.
	 */
	public void releaseUserIdentity() {
		ThreadSecurityManager.setThreadUser(null);
	}

	/**
	 * resumes auto workflow.
	 * @param pProcess
	 *            workflow process object
	 * @param transactionDemarcation
	 *            transaction demarcation
	 * @param pRollback
	 *            flag to rollback workflow
	 */
	public void resumeAutoWorkflow(Process pProcess,
			TransactionDemarcation transactionDemarcation, boolean pRollback)
			throws Exception {
		PerformanceMonitor.startOperation(className + "resumeAutoWorkflow");

		boolean lRollback = pRollback;
		try {
			advanceWorkflow(pProcess, transactionDemarcation);

			// lRollback = false;
		} catch (MissingWorkflowDescriptionException e) {
			if (isLoggingError()) {
				logError("ActorAccessException : " + e.getMessage(), e
						.getCause());
			}
			lRollback = true;
			throw e;
		} catch (ActorAccessException e) {
			if (isLoggingError()) {
				logError("ActorAccessException  : " + e.getMessage(), e
						.getCause());
			}
			lRollback = true;
			throw e;
		} catch (ActionException e) {
			if (isLoggingError()) {
				logError("ActionException : " + e.getMessage(), e.getCause());
			}
			lRollback = true;
			throw e;
		} catch (UnsupportedOperationException e) {
			if (isLoggingError()) {
				logError("UnsupportedOperationException : " + e.getMessage(), e
						.getCause());
			}
			lRollback = true;
			throw e;
		} catch (Exception e) {
			if (isLoggingError()) {
				logError("Exception : " + e.getMessage(), e.getCause());
			}
			lRollback = true;
			throw e;
		} finally {
			WorkingContext.popDevelopmentLine();
			releaseUserIdentity();
			try {
				transactionDemarcation.end(lRollback);
			} catch (TransactionDemarcationException e) {
				if (isLoggingError()) {
					logError("TransactionDemarcationException Exception : "
							+ e.getMessage());
				}
			}

			PerformanceMonitor.endOperation(className + "resumeAutoWorkflow");
		}
	}

	/**
	 * resumes manual workflow for review.
	 * @param pProcess
	 *            manual workflow process
	 * @param transactionDemarcation
	 *            transactionDemarcationobject
	 * @param pRollback
	 *            rollback flag
	 */
	public void resumeManualWorkflow(Process pProcess,
			TransactionDemarcation transactionDemarcation, boolean pRollback) {
		PerformanceMonitor.startOperation(className + "resumeManualWorkflow");

		boolean lRollback = pRollback;
		try {
			popDevelopmentLine();

		} catch (Exception e) {
			e.printStackTrace();
			if (isLoggingError()) {
				logError("TransactionDemarcationException Exception : "
						+ e.getMessage());
			}
			lRollback = true;
		} finally {
			releaseUserIdentity();
			try {
				transactionDemarcation.end(lRollback);
			} catch (TransactionDemarcationException e) {
				if (isLoggingError()) {
					logError("TransactionDemarcationException Exception : "
							+ e.getMessage());
				}
			}

		}
		PerformanceMonitor.endOperation(className + "resumeManualWorkflow");
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
	 * returns filename date format.
	 * @return file name date format
	 */
	public String getFileNameDateFormat() {
		return mFileNameDateFormat;
	}

	/**
	 * sets file name date format.
	 * @param fileNameDateFormat
	 *            file name date format.
	 */
	public void setFileNameDateFormat(String fileNameDateFormat) {
		mFileNameDateFormat = fileNameDateFormat;
	}

	/**
	 * returns persona prefix.
	 * @return presona prefix
	 */
	public String getMPersonaPrefix() {
		return mPersonaPrefix;
	}

	/**
	 * returns UserAuthority object.
	 * @return userAuthority
	 */
	public UserDirectoryUserAuthority getUserAuthority() {
		return userAuthority;
	}

	/**
	 * return user name.
	 * @return user name
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * sets pPersonaPrefix.
	 * @param pPersonaPrefix
	 *            pPersonaPrefix
	 */
	public void setPersonaPrefix(String pPersonaPrefix) {
		mPersonaPrefix = pPersonaPrefix;
	}

	/**
	 * sets pTaskOutcomeId.
	 * @param pTaskOutcomeId
	 *            TaskOutcomeId
	 */
	public void setTaskOutcomeId(String pTaskOutcomeId) {
		taskOutcomeId = pTaskOutcomeId;
	}

	/**
	 * sets pUserDirectoryUserAuthority.
	 * @param pUserDirectoryUserAuthority
	 *            user Authority
	 */
	public void setUserAuthority(
			UserDirectoryUserAuthority pUserDirectoryUserAuthority) {
		userAuthority = pUserDirectoryUserAuthority;
	}

	/**
	 * return username.
	 * @param pUserName
	 *            user name
	 */
	public void setUserName(String pUserName) {
		userName = pUserName;
	}

	/**
	 * return processname property name.
	 * @return processNamePropertyName
	 */
	public String getProcessNamePropertyName() {
		return mProcessNamePropertyName;
	}

	/**
	 * set process name property name.
	 * @param pProcessNamePropertyName
	 *            ProcessNamePropertyName
	 */
	public void setProcessNamePropertyName(String pProcessNamePropertyName) {
		mProcessNamePropertyName = pProcessNamePropertyName;
	}

	/**
	 * returns personaPrefix.
	 * @return personaPrefix
	 */
	public String getPersonaPrefix() {
		return mPersonaPrefix;
	}

}