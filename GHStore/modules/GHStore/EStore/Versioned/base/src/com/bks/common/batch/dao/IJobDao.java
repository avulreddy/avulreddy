package com.bks.common.batch.dao;

import atg.repository.RepositoryItem;

/**
 * Interface to be implemented by DAO components. Methods in this interface
 * needs to be implemented by the implementation classes.
 * @author REV
 * @version 1.0
 * @created 02-Mar-2011 2:12:03 PM
 */
public interface IJobDao {

	/**
	 * find repository item.
	 * @param id :
	 *            repository Id to search in the given repository
	 * @return RepositoryItem
	 */
	public RepositoryItem findItem(String id);

}
