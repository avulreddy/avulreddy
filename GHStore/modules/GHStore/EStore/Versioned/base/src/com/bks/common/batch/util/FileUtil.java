package com.bks.common.batch.util;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

import atg.core.util.StringUtils;
import atg.nucleus.GenericService;
import atg.service.perfmonitor.PerformanceMonitor;

/**
 * This class contains File utilities required by integretion feed jobs.
 * @author REV
 * @version 1.0
 * @created 02-Mar-2011 2:12:03 PM
 */
public class FileUtil extends GenericService {

	/* Class name */
	public final String CLASS_NAME = this.getClass().getName();

	/**
	 * copies contents of a file to another file
	 * @param fromFile
	 * @param toFile
	 */
	public boolean copyFile(String fromFile, String toFile) {
		return false;
	}

	/**
	 * This mathod is used to copy a content of source to destination(archive)
	 * @param srcFile
	 *            The source file path
	 * @param destFile
	 *            the Destination file path
	 * @return the boolean value
	 */
	private boolean copyFile(File srcFile, File destFile) {
		PerformanceMonitor.startOperation(CLASS_NAME + "copyFile");

		boolean ret = false;
		FileReader fileReader = null;
		FileWriter out = null;
		try {
			fileReader = new FileReader(srcFile);
			out = new FileWriter(destFile);
			int lBuffferSize;
			while ((lBuffferSize = fileReader.read()) != -1) {
				out.write(lBuffferSize);
			}
			ret = true;
		} catch (IOException e) {
			if (isLoggingError()) {
				logError("IOException Exception 1 : " + e.getMessage());
			}
		} finally {
			try {
				if (fileReader != null) {
					fileReader.close();
				}
				if (out != null) {
					out.close();
				}
			} catch (IOException e) {
				if (isLoggingError()) {
					logError("IOException Exception 2 : " + e.getMessage());
				}
			}
			PerformanceMonitor.endOperation(CLASS_NAME + "copyFile");
		}
		return ret;
	}

	/**
	 * This method will move the file to the specified destination
	 * @param srcFile
	 * @param pName
	 * @param pFilePath
	 * @return
	 */
	private boolean moveFileToPath(File srcFile, String pName, String pFilePath) {
		PerformanceMonitor.startOperation(CLASS_NAME + "moveFileToPath");

		boolean success = false;
		File destFile = new File(pFilePath + srcFile.getName());
		success = copyFile(srcFile, destFile);
		this.delay(BatchJobConstants.TEN);
		if (success) {
			srcFile.delete();
			this.delay(BatchJobConstants.TEN);
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "moveFileToPath");
		return success;
	}

	/**
	 * This method is used to delay time for some seconds.
	 * @param milSec
	 *            takes the time in milliSeconds
	 */
	protected void delay(long milSec) {
		PerformanceMonitor.startOperation(CLASS_NAME + "delay");

		try {
			Thread.sleep(BatchJobConstants.TEN);
		} catch (InterruptedException e) {
			if (isLoggingError()) {
				logError("InterruptedException Exception : " + e.getMessage());
			}
		} finally {
			PerformanceMonitor.endOperation(CLASS_NAME + "delay");
		}

	}

	/**
	 * This method is used to get multiple input files from the given file path
	 * @param filePath
	 *            This is the File Path
	 * @return File[] returns list of files in given path
	 */
	public synchronized File[] getFiles(String filePath) {
		PerformanceMonitor.startOperation(CLASS_NAME + "getFiles");

		File[] inputFiles = null;
		File[] fileArr = null;
		ArrayList list = new ArrayList();
		if (!StringUtils.isBlank(filePath)) {
			File directory = new File(filePath);
			inputFiles = directory.listFiles();
			for (File file : inputFiles) {
				if (!file.isDirectory()) {
					list.add(file);
				}
			}
			fileArr = new File[list.size()];
			for (int i = 0; i < list.size(); i++) {
				fileArr[i] = (File) list.get(i);
			}

		} else {
			logInfo("dataFile Path is null.");
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "getFiles");
		return fileArr;
	}

}