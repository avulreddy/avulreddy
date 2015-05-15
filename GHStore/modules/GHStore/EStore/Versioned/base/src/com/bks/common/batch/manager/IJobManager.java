package com.bks.common.batch.manager;

import java.io.File;
import java.io.FileNotFoundException;

import com.bks.common.batch.vo.ImportData;

/**
 * This interface to be implemented by all batch job managers.
 * @author REV_BelindaQuick
 * @version 1.0
 * @created 02-Mar-2011 2:12:03 PM
 */
public interface IJobManager {

	/**
	 * Parse the given file for valid records. Returns ImportData object with
	 * valid records for processing
	 * @param file :
	 *            file to be parsed by the implementation class. this method
	 *            will parse the given file and populate ImportData object with
	 *            list of auto deploy-able items ( if any) - list of Manually
	 *            deploy-able items ( if any) - total number of records in the
	 *            file
	 * @return ImportData importData object populated with parsed file contents
	 * @throws FileNotFoundException
	 *             FileNotFoundException
	 */
	public ImportData parseFile(File file) throws FileNotFoundException;

	/**
	 * This method processes ImportData object for auto deployment & stores them
	 * to db and returns no of successfully processed records.
	 * @param importData :
	 *            ImportData object populated by parse file method
	 * @return int returns number of successfully processed records for auto
	 *         deployment
	 */
	public int processAutoImportData(ImportData importData);

	/**
	 * This method processes ImportData object for auto deployment & stores them
	 * to db and returns no of successfully processed records.
	 * @param importData :
	 *            ImportData object populated by parse file method
	 * @return int returns number of successfully processed records for manual
	 *         deployment
	 */
	public int processManualImportData(ImportData importData);

}