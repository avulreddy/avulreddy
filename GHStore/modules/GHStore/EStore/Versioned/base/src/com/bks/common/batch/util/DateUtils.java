package com.bks.common.batch.util;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import atg.service.perfmonitor.PerformanceMonitor;

/**
 * An utility class for Date object
 * @author REV
 */
public class DateUtils {
	/* Class name */
	public final static String CLASS_NAME = "DateUtils";

	/**
	 * Returns Date in the passed in formatted string format.
	 * @param format
	 * @return
	 */
	public static String getDateString(Date date, String format) {
		PerformanceMonitor.startOperation(CLASS_NAME + "getDateString");

		String dateString = null;
		date = date == null ? new Date() : date;
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		dateString = dateFormat.format(date);
		PerformanceMonitor.endOperation(CLASS_NAME + "getDateString");
		return dateString;
	}

	/**
	 * This method compares the passed in start and end dates.
	 * @param startDate
	 * @param endDate
	 * @param checkDate
	 * @return true (if checkDate falls between startDate and endDate) | false
	 *         (if checkDate falls outside of startDate and endDate)
	 */
	public static boolean compareDateForBetween(Date startDate, Date endDate,
			Date checkDate) {
		PerformanceMonitor.startOperation(CLASS_NAME + "compareDateForBetween");

		boolean success = Boolean.FALSE.booleanValue();
		if (startDate != null && endDate != null) {
			if (checkDate.after(startDate) && checkDate.before(endDate)) {
				success = Boolean.TRUE.booleanValue();
			}
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "compareDateForBetween");
		return success;
	}

	/**
	 * This method is used to append the timestamp to a input file.
	 * @return formattedDate
	 */
	public static String getFormattedTimeStamp() {
		PerformanceMonitor.startOperation(CLASS_NAME + "getFormattedTimeStamp");

		Timestamp ts = new Timestamp(new Date().getTime());
		String time = ts.toString();
		time = time.substring(0, time.indexOf('.'));
		time = time.replace(':', '-');
		PerformanceMonitor.endOperation(CLASS_NAME + "getFormattedTimeStamp");
		return time;
	}

	/**
	 * Returns the date object by adding passed in days.
	 * @param daysToAdd
	 * @return
	 */
	public static Date getDate(int daysToAdd) {
		PerformanceMonitor.startOperation(CLASS_NAME + "getDate");

		Date date = null;
		DateFormat dateFormat = new SimpleDateFormat();
		Calendar pCalender = Calendar.getInstance();
		pCalender.add(Calendar.DATE, daysToAdd);
		String pStrDate = (dateFormat.format(pCalender.getTime()));
		try {
			date = dateFormat.parse(pStrDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "getDate");
		return date;
	}
}
