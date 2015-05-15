package com.bks.common.batch.service;

import java.io.File;

import atg.dtm.TransactionDemarcationException;
import atg.versionmanager.exceptions.VersionException;
import atg.workflow.WorkflowException;
import atg.process.action.ActionException;

import com.bks.common.batch.vo.ImportData;

/**
 * interface to be implemented by Job processor components.
 * @author REV_BelindaQuick
 * @version 1.0
 * @created 02-Mar-2011 2:12:04 PM
 */
public interface IJobProcessor {

	/**
	 * This method moves the given input file to archive folder or error folder
	 * based on the job status.
	 * @param inputFile
	 *            input feed file
	 * @param archivePath
	 *            archive path
	 * @param errorPath
	 *            error files path
	 * @param status
	 *            file processing status
	 */
	public void archiveFile(File inputFile, String archivePath,
			String errorPath, int status);

	/**
	 * creates new work-flow. processes auto deploy-able records in the
	 * ImportData object and advances the newly created workflow for auto
	 * deployment
	 * @param imporData
	 *            importdata object for processing.
	 * @return int Count of succcessfulle processed records
	 * @throws TransactionDemarcationException
	 *             TransactionDemarcationException
	 * @throws WorkflowException
	 *             WorkflowException
	 * @throws VersionException
	 *             VersionException
	 */
	public int executeAutoDeploy(ImportData imporData) throws VersionException,
			TransactionDemarcationException, WorkflowException, ActionException;

	/**
	 * this method 1. gets list of input files 2. processes each file for
	 * auto/manual deployment 3. moves the file to archive location based on
	 * status
	 */
	public void executeImportProcess();

	/**
	 * creates new work-flow. processes auto deploy-able records in the
	 * ImportData object and advances the newly created workflow for manual
	 * deployment
	 * @param importData :
	 *            importData object
	 * @return int returns count of manually deployed records.
	 * @throws TransactionDemarcationException
	 *             TransactionDemarcationException
	 * @throws WorkflowException
	 *             WorkflowException
	 * @throws VersionException
	 *             VersionException
	 */
	public int executeManualDeploy(ImportData importData)
			throws VersionException, TransactionDemarcationException,
			WorkflowException;;

	/**
	 * Gets list of input files from given location.
	 * @param path
	 *            feed path
	 * @return File[] list of files from feed path
	 */
	public File[] getInputFiles(String path);

	/**
	 * Processes records for AUto deployment.
	 * @param importData
	 *            import data for processing.
	 * @return int number of processed records
	 */
	public int processAutoImportData(ImportData importData);

	/**
	 * returns ImportData instance loaded with parsed import file contents.
	 * @param file
	 *            input feed file
	 * @return Importdata ImportData object populated with feed records.
	 */
	public ImportData processFile(File file);

	/**
	 * Processes Importdata object for manual deployment.
	 * @param importData
	 *            ImportData object to be processed
	 * @return int Number of records processed.
	 */
	public int processManualImportData(ImportData importData);

	/**
	 * returns file processing status based on no of records in file &
	 * successfully processed records.
	 * @param fileRecords
	 *            records in input feed
	 * @param processedRecords
	 *            processed record count
	 * @return status file processing status
	 */
	public int getFileProcessStatus(int fileRecords, int processedRecords);

}