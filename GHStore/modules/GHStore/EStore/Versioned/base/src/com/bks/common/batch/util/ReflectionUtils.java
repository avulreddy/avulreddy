/**
 * 
 * Nov 10, 2010, ReflectionUtils.java
 * @author REV 
 */
package com.bks.common.batch.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import atg.core.util.StringUtils;
import atg.service.perfmonitor.PerformanceMonitor;

/**
 * A java class to use reflection apis.
 * @author REV
 */
public class ReflectionUtils {
	/* Class name */
	public final static String CLASS_NAME = "ReflectionUtils";

	/**
	 * Returns value of the property on passed in object by using reflection
	 * apis.
	 * @param object
	 * @param propertyName
	 * @param prefix
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public static Object getValue(Object object, String propertyName,
			String prefix) throws IllegalArgumentException,
			IllegalAccessException, InvocationTargetException {
		PerformanceMonitor.startOperation(CLASS_NAME + "getValue");

		Object o = null;
		Class cls = object.getClass();
		// getFields() returns all the declared fields of the class.
		Field flds[] = cls.getDeclaredFields();
		for (Field fld : flds) {
			if (fld.getName().equalsIgnoreCase(propertyName)) {
				Method m = getMethod(propertyName, cls, prefix);
				Object arg[] = new Object[0];
				o = m.invoke(object, arg);
			}
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "getFile");
		return o;
	}

	/**
	 * Returns declared method object for property name and prefix.
	 * @param propertyName
	 * @param cls
	 * @param prefix
	 * @return
	 */
	public static Method getMethod(String propertyName, Class cls, String prefix) {
		PerformanceMonitor.startOperation(CLASS_NAME + "getMethod");

		Method m = null;
		Method[] methods = getMethods(cls, prefix);
		if (methods != null && !StringUtils.isBlank(propertyName)) {
			for (Method mm : methods) {
				if (mm.getName().toLowerCase().equalsIgnoreCase(
						prefix.toLowerCase() + propertyName.toLowerCase())) {
					m = mm;
					break;
				}
			}
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "getMethod");
		return m;
	}

	/**
	 * Returns array of declared methods for passed in class based on prefix. If
	 * prefix is null, returns all declared methods else returns methods
	 * starting with prefix.
	 * @param cls
	 * @param prefix
	 * @return
	 */
	public static Method[] getMethods(Class cls, String prefix) {
		PerformanceMonitor.startOperation(CLASS_NAME + "getMethods");

		Method[] ms = null;
		if (cls == null) {
			return ms;
		}
		ms = cls.getDeclaredMethods();
		if (StringUtils.isBlank(prefix)) {
			return ms;
		} else {
			List<Method> mList = new ArrayList<Method>();
			for (Method m : ms) {
				if (m.getName().startsWith(prefix)) {
					mList.add(m);
				}
			}
			ms = mList.toArray((new Method[mList.size()]));
		}
		PerformanceMonitor.endOperation(CLASS_NAME + "getMethods");
		return ms;
	}
}
