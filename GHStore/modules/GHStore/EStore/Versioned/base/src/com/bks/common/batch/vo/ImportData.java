package com.bks.common.batch.vo;

import java.util.ArrayList;

/**
 * @author REV_BelindaQuick
 * @version 1.0
 * @created 02-Mar-2011 2:12:04 PM
 */
public class ImportData {

	/**
	 * autoImportData : stores list of items for auto deployment
	 */
	private ArrayList autoImportData;
	/**
	 * manualImportData : contains list of items for Manual deployment
	 */
	private ArrayList manualImportData;
	/**
	 * errorRecords : contains list of error records generated while parsing
	 * feed file
	 */
	private ArrayList errorRecords;
	/**
	 * fileName : input feed file name
	 */
	private String fileName;
	/**
	 * totalAutoRecords : no of records for Auto deployment
	 */
	private int totalAutoRecords;
	/**
	 * totalManualRecords : no of records for manual deployment
	 */
	private int totalManualRecords;

	/**
	 * no of records for Auto deployment
	 * 
	 * @return totalAutoRecords
	 */
	public int getTotalAutoRecords() {
		return totalAutoRecords;
	}

	/**
	 * returns no of records for manual deployment
	 * 
	 * @return totalManualRecords
	 */
	public int getTotalManualRecords() {
		return totalManualRecords;
	}

	/**
	 * sets totalManualRecords
	 * 
	 * @param totalManualRecords
	 */
	public void setTotalManualRecords(int totalManualRecords) {
		this.totalManualRecords = totalManualRecords;
	}

	/**
	 * sets total records
	 * 
	 * @param totalRecords
	 */
	public void setTotalAutoRecords(int totalRecords) {
		this.totalAutoRecords = totalRecords;
	}

	/**
	 * returns filename
	 * 
	 * @return filename
	 */
	public String getFileName() {
		return fileName;
	}

	/**
	 * set file name
	 * 
	 * @param fileName
	 */
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	/**
	 * returns array list of items for auto deployment
	 * 
	 * @return autoImportData
	 */
	public ArrayList getAutoImportData() {
		return autoImportData;
	}

	/**
	 * set auto import array list
	 * 
	 * @param newVal
	 */
	public void setAutoImportData(ArrayList newVal) {
		autoImportData = newVal;
	}

	/**
	 * returns Arraylist of import feed file items for Manual deployment
	 * 
	 * @return manualImportData
	 */
	public ArrayList getManualImportData() {
		return manualImportData;
	}

	/**
	 * sets arrayList of items for Manual deployment
	 * 
	 * @param pManualImportData
	 */
	public void setManualImportData(ArrayList pManualImportData) {
		manualImportData = pManualImportData;
	}

	/**
	 * returns error records
	 * 
	 * @return errorRecords error records generated while parsing input file
	 */
	public ArrayList getErrorRecords() {
		return errorRecords;
	}

	/**
	 * set error records
	 * 
	 * @param errorRecords
	 */
	public void setErrorRecords(ArrayList errorRecords) {
		this.errorRecords = errorRecords;
	}

}