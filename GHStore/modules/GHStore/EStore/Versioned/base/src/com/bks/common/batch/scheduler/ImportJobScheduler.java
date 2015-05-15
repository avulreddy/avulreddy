package com.bks.common.batch.scheduler;

import atg.service.scheduler.Schedule;
import atg.service.scheduler.ScheduledJob;
import atg.service.scheduler.Scheduler;
import atg.service.scheduler.SingletonSchedulableService;

import com.bks.common.batch.service.IJobProcessor;

/**
 * Scheduler class for import jobs. This scheduler needs to be configured with
 * job processor component to be invoked.
 * @author REV
 * @version 1.0
 * @created 02-Mar-2011 2:12:04 PM
 */
public class ImportJobScheduler extends SingletonSchedulableService {

	/**
	 * jobId : Id of the batch.
	 */
	private int jobId;
	/**
	 * jobName : Batch job name.
	 */
	private String jobName;
	/**
	 * jobProcessor :JobProcessor component which needs to be invoked.
	 */
	private IJobProcessor jobProcessor;
	/**
	 * schedule : schedule of the job.
	 */
	private Schedule schedule;
	/**
	 * scheduler : Scheduler to schedule the job.
	 */
	private Scheduler scheduler;

	/**
	 * constructor.
	 */
	public ImportJobScheduler() {

		super();
	}

	/**
	 * Invokes the configured JobProcessor Component.
	 * @param paramScheduledJob :
	 *            scheduled job
	 * @param paramScheduler :
	 *            scheduler
	 */
	@Override
	public void doScheduledTask(Scheduler paramScheduler,
			ScheduledJob paramScheduledJob) {

		getJobProcessor().executeImportProcess();

	}

	/**
	 * returns jobName.
	 * @return return job name
	 */
	@Override
	public String getJobName() {
		return jobName;
	}

	/**
	 * returns JobProcessor object.
	 * @return jobProcessor jobProcessor object
	 */
	public IJobProcessor getJobProcessor() {
		return jobProcessor;
	}

	/**
	 * set job name.
	 * @param pJobName
	 *            job name
	 */
	@Override
	public void setJobName(String pJobName) {
		jobName = pJobName;
	}

	/**
	 * sets JobProcessor.
	 * @param pJobProcessor
	 *            JobProcessor Object
	 */
	public void setJobProcessor(IJobProcessor pJobProcessor) {
		jobProcessor = pJobProcessor;
	}

	/**
	 * returns Job Id.
	 * @return jobId
	 */
	@Override
	public int getJobId() {
		return jobId;
	}

	/**
	 * Sets job ID.
	 * @param pJobId
	 *            Job Id
	 */
	public void setJobId(int pJobId) {
		this.jobId = pJobId;
	}

	/**
	 * returns Schedule object.
	 * @return schedule
	 */
	@Override
	public Schedule getSchedule() {
		return schedule;
	}

	/**
	 * sets Schedule object.
	 * @param pSchedule
	 *            Schedule object
	 */
	@Override
	public void setSchedule(Schedule pSchedule) {
		this.schedule = pSchedule;
	}

	/**
	 * returns Scheduler object.
	 * @return scheduler
	 */
	@Override
	public Scheduler getScheduler() {
		return scheduler;
	}

	/**
	 * sets Scheduler object.
	 * @param pScheduler
	 *            scheduler object
	 */
	@Override
	public void setScheduler(Scheduler pScheduler) {
		this.scheduler = pScheduler;
	}

}