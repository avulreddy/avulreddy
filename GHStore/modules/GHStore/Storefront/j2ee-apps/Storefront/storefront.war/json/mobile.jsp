<%@ taglib uri="/WEB-INF/tld/verizon.tld" prefix="verizon"%>
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" prefix="dsp"%>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %>
<%@page language="java" pageEncoding="UTF-8" contentType="application/json;charset=UTF-8"%>

<dsp:page>
<dsp:importbean bean="/com/myv/common/cq/MYVLabelConfiguration"/>
<dsp:getvalueof var="MYVLabelConfiguration" bean="MYVLabelConfiguration" vartype="com.myv.common.cq.MVMLabelConfiguration"/>
<dsp:importbean bean="/com/myv/common/cq/MYVHtmlConfiguration"/>
<dsp:importbean bean="/com/myv/common/user/MYVUserInfo"/>
<dsp:getvalueof var="myvUserInfoBean" bean="MYVUserInfo" />
<dsp:getvalueof var="MYVHtmlConfiguration" bean="MYVHtmlConfiguration" />

	<dsp:droplet name="/com/myv/mybill/droplet/MYVRetrieveBillingInfoDroplet">
		<dsp:oparam name="empty">
		</dsp:oparam>
		<dsp:oparam name="output">
		<dsp:getvalueof var="myvBillSummaryInfoBean"  param="billSummaryInfo" />
		<dsp:getvalueof var="placeHolderMap"  param="placeHolderMap" />				
		</dsp:oparam>
	</dsp:droplet>
	<dsp:droplet name="/com/myv/myusage/droplet/MYVReceviableControlDroplet">
	    <dsp:oparam name="output">
	        <dsp:getvalueof param="receivablesControlAccountFlag" var="receivablesControlAccountFlag" />
	        <dsp:getvalueof param="currentCharges" var="currentCharges" />
	    </dsp:oparam>
	</dsp:droplet>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.myBillHeaderLabelKey}" labelVar="labelObject" />
	<c:set var="myBillHeaderLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.enrollInAutoPayLabelKey}" labelVar="labelObject" />
	<c:set var="enrollInAutoPayLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.enrollInPaperlessBillingLabelKey}" labelVar="labelObject" />
	<c:set var="enrollInPaperlessBillingLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.dueFromLastBillLabelKey}" labelVar="labelObject" />
	<c:set var="dueFromLastBillLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.recentPaymentColumnLabelKey}" labelVar="labelObject" />
	<c:set var="recentPaymentColumnLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.paymentHistoryLabelKey}" labelVar="labelObject" />
	<c:set var="paymentHistoryLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.otherCreditsColumnLabelKey}" labelVar="labelObject" />
	<c:set var="otherCreditsColumnLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.otherCreditsTooltipLabelKey}" labelVar="labelObject" />
	<c:set var="otherCreditsTooltipLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.totalDueColumnLabelKey}" labelVar="labelObject" />
	<c:set var="totalDueColumnLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.viewCurrentBillLabelKey}" labelVar="labelObject" />
	<c:set var="viewCurrentBillLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.autoPayTextIndicatorLabelKey}" labelVar="labelObject" />
	<c:set var="autoPayTextIndicatorLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.manageAutoPayLabelKey}" labelVar="labelObject" />
	<c:set var="manageAutoPayLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.dueDateColumnLabelKey}" labelVar="labelObject" />
	<c:set var="dueDateColumnLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.payBillLabelKey}" labelVar="labelObject" />
	<c:set var="payBillLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.paidInFullLabelKey}" labelVar="labelObject" />
	<c:set var="paidInFullLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.nextAutoPayScheduledLabelKey}" labelVar="labelObject" />
	<c:set var="nextAutoPayScheduledLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.scheduledLabelKey}" labelVar="labelObject" />
	<c:set var="scheduledLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.otherChargesTooltipLabelKey}" labelVar="labelObject" />
	<c:set var="otherChargesTooltipLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.currentBalanceColumnLabelKey}" labelVar="labelObject" />
	<c:set var="currentBalanceColumnLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.billLabelKey}" labelVar="labelObject" />
	<c:set var="billLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.viewLableKey}" labelVar="labelObject" />
	<c:set var="viewLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.dueLableKey}" labelVar="labelObject" />
	<c:set var="dueLabel" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.pastdueLableKey}" labelVar="labelObject" />
	<c:set var="pastdueLableKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.noteLableKey}" labelVar="labelObject" />
	<c:set var="noteLableKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.youLableKey}" labelVar="labelObject" />
	<c:set var="youLableKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.offLableKey}" labelVar="labelObject" />
	<c:set var="offLableKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.employeeLableKey}" labelVar="labelObject" />
	<c:set var="employeeLableKey" value="${labelObject.labelValue}"/>	
	<c:set var="tilesCount" value="2" />
	
	<dsp:getvalueof bean="/atg/userprofiling/Profile.vzwRole" var="userRole"/>
	
	<c:if test="${not myvUserInfoBean.userCLEU}">
	<c:choose>
	<c:when test="${not myvBillSummaryInfoBean.centuryLinkUser && not myvBillSummaryInfoBean.questCustomer &&  not myvBillSummaryInfoBean.newUser &&  not myvBillSummaryInfoBean.accountDisconnected}">
	    <json:object>
	             <json:property name="objectName">${myBillHeaderLabel}</json:property>
				 <json:property name="myBillURL">${myvBillSummaryInfoBean.myBillURL}</json:property>
				 <json:property name="isCenturyLinkUser">false</json:property>
				 <json:property name="isQuestCustomer">false</json:property>
				 <json:property name="isNewUser">false</json:property>
				 <json:property name="isAccountDisconnected">false</json:property>
				 
			<c:if test="${myvBillSummaryInfoBean.boxAmountsMatched}">
				  <json:property name="hasDue">true</json:property>
				  <json:property name="dueLabel">${dueLabel}</json:property>
				  <json:property name="billDueDate"><dsp:valueof value="${myvBillSummaryInfoBean.billDueDate}"  converter="date" date="MM/dd/yy"/></json:property>
			<c:if test="${not empty myvBillSummaryInfoBean.amountDueFromLastBill}">
				<c:choose>
					<c:when test="${myvBillSummaryInfoBean.amountDueFromLastBill < 0}">
				     <json:property name="amountDueFromLastBill">					 
					 $-<dsp:valueof value="${-1*myvBillSummaryInfoBean.amountDueFromLastBill}" locale="en_US" />
					 </json:property>
					</c:when>
					<c:otherwise>
					 <json:property name="amountDueFromLastBill">		
					   <dsp:valueof value="${myvBillSummaryInfoBean.amountDueFromLastBill}" locale="en_US" converter="currency"/>
					 </json:property>											
					</c:otherwise>
				</c:choose>
			</c:if>
			</c:if>			
			<json:property name="recentPaymentColumnLabel">${recentPaymentColumnLabel}</json:property>
			<c:if test="${not empty myvBillSummaryInfoBean.recentPaymentAmount}">
				<json:property name="recentPaymentAmount">
					<dsp:valueof value="${myvBillSummaryInfoBean.recentPaymentAmount}" locale="en_US" converter="currency"/>
				</json:property>				
			</c:if>
			<c:if test="${not myvBillSummaryInfoBean.oneBillUser}">
				<json:property name="isOneBillUser">false</json:property>
				<json:property name="paymentHistoryLabel">${paymentHistoryLabel}</json:property>
				<json:property name="paymentHistoryURL">${myvBillSummaryInfoBean.paymentHistoryURL}</json:property>
			</c:if>
			<json:property name="currentBalanceColumnLabel">${currentBalanceColumnLabel}</json:property>
			<c:if test="${not empty myvBillSummaryInfoBean.totalDueAmount}">				
				<c:choose>
					<c:when test="${myvBillSummaryInfoBean.totalDueAmount < 0}">
						<json:property name="totalDueAmount">
							$-<dsp:valueof value="${-1*myvBillSummaryInfoBean.totalDueAmount}" locale="en_US" />
						</json:property>
					</c:when>
					<c:otherwise>
						<json:property name="totalDueAmount">
							<dsp:valueof value="${myvBillSummaryInfoBean.totalDueAmount}" locale="en_US" converter="currency"/>
						</json:property>
						<c:if test="${myvBillSummaryInfoBean.pastDue}">
							<json:property name="pastdueLableKey"> ${pastdueLableKey} </json:property>
						</c:if>
					</c:otherwise>
				</c:choose>	
			</c:if>
			<c:if test="${not myvBillSummaryInfoBean.autoPayEnrolled}">
				<json:property name="autoPayEnrolled">false</json:property>
			</c:if>
			<c:if test ="${userRole ne 'mobileSecure'}">
				<c:choose>
					<c:when test="${myvBillSummaryInfoBean.pastDue && myvBillSummaryInfoBean.autoPayEnrolled}">
						<json:property name="hasPastDue">true </json:property>
						<json:property name="isAutoPayEnrolled">true </json:property>
						<json:property name="pastdueLableKey"> ${pastdueLableKey} </json:property>
						<json:property name="autoPayTextIndicatorLabel"> ${autoPayTextIndicatorLabel} </json:property>
						<json:property name="nextAutoPayScheduledLabel"> ${nextAutoPayScheduledLabel} </json:property>
						<json:property name="scheduledLabel"> ${scheduledLabel} </json:property>
						<c:if test="${not empty myvBillSummaryInfoBean.nextAutoPayDate}">
							<json:property name="nextAutoPayDate"> 
								<dsp:valueof value="${myvBillSummaryInfoBean.nextAutoPayDate}"  converter="date" date="MM/dd/yy"/>
							</json:property>
						</c:if>
					</c:when>
					<c:when test="${myvBillSummaryInfoBean.pastDue && not myvBillSummaryInfoBean.autoPayEnrolled}">
						<json:property name="hasPastDue">true </json:property>
						<json:property name="autoPayEnrolled">false </json:property>
						<json:property name="pastdueLableKey"> ${pastdueLableKey} </json:property>
					</c:when>
					<c:when test="${myvBillSummaryInfoBean.autoPayEnrolled}">
						<json:property name="isAutoPayEnrolled">true </json:property>
						<json:property name="autoPayTextIndicatorLabel"> ${autoPayTextIndicatorLabel} </json:property>
						<json:property name="nextAutoPayScheduledLabel"> ${nextAutoPayScheduledLabel} </json:property>
						<json:property name="scheduledLabel"> ${scheduledLabel} </json:property>
						<c:if test="${not empty myvBillSummaryInfoBean.nextAutoPayDate}">
							<json:property name="nextAutoPayDate"> 
								<dsp:valueof value="${myvBillSummaryInfoBean.nextAutoPayDate}"  converter="date" date="MM/dd/yy"/>
							</json:property>
						</c:if>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:choose>
				<c:when test="${myvBillSummaryInfoBean.paidInFull}">
					<json:property name="isPaidInFull">true </json:property>
					<json:property name="paidInFullLabel">${paidInFullLabel} </json:property>
				</c:when>
				<c:when test="${not myvBillSummaryInfoBean.paidInFull}">
					<json:property name="isPaidInFull">false </json:property>
					<json:property name="payBillLabel">${payBillLabel} </json:property>					
				</c:when>
			</c:choose>
			<c:if test="${not myvBillSummaryInfoBean.autoPayEnrolled && userRole ne 'nonRegister' && userRole ne 'mobileSecure'}">
				<json:property name="isAutoPayEnrolled">false </json:property>
				<json:property name="isNonRegister">false </json:property>
				<json:property name="isMobileSecure">false </json:property>
				<json:property name="title">Enroll in auto pay </json:property>
				<json:property name="enrollInAutoPayLabel">${enrollInAutoPayLabel} </json:property>
				<json:property name="enrollAutoPayURL">${myvBillSummaryInfoBean.enrollAutoPayURL}</json:property>
			</c:if>
			<c:if test="${userRole ne 'mobileSecure' && myvBillSummaryInfoBean.autoPayEnrolled && userRole ne 'nonRegister'}">
				<json:property name="isAutoPayEnrolled">true </json:property>
				<json:property name="isNonRegister">false </json:property>
				<json:property name="isMobileSecure">false </json:property>
				<json:property name="autoPayTextIndicatorLabel">${autoPayTextIndicatorLabel} </json:property>
				<json:property name="manageAutoPayLabel">${manageAutoPayLabel} </json:property>
				<json:property name="managerAutopayURL">${myvBillSummaryInfoBean.managerAutopayURL}</json:property>
			</c:if>
			<c:if test="${userRole ne 'mobileSecure' && not myvBillSummaryInfoBean.paperlessBillEnrolled}">
				<json:property name="isMobileSecure">false </json:property>
				<json:property name="isPaperlessBillEnrolled">false </json:property>
				<json:property name="enrollInPaperlessBillingLabel">${enrollInPaperlessBillingLabel} </json:property>
				<json:property name="enrollPaperlessBillURL">${myvBillSummaryInfoBean.enrollPaperlessBillURL} </json:property>				
			</c:if>
			<c:if test="${userRole ne 'mobileSecure'}">
				<json:property name="isMobileSecure">false </json:property>
				<json:property name="viewLabel">${viewLabel} </json:property>
				<json:property name="viewCurrentBillURL">${myvBillSummaryInfoBean.viewCurrentBillURL} </json:property>
				<json:property name="billDueDate">
					<dsp:valueof value="${myvBillSummaryInfoBean.billDueDate}"  converter="date" date="MM/dd/yy"/>
				</json:property>
				<json:property name="billLabel">${billLabel} </json:property>				
			</c:if>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${ myvBillSummaryInfoBean.accountDisconnected}">
			<json:property name="isAccountDisconnected">true </json:property>
			<json:property name="disconnectedAccountHeaderTextKey">${MYVHtmlConfiguration.disconnectedAccountHeaderTextKey} </json:property>
			<json:property name="disconnectedAccountMessageTextKey">${MYVHtmlConfiguration.disconnectedAccountMessageTextKey} </json:property>
		</c:when>
		<c:when test="${myvBillSummaryInfoBean.firstTimeUser}">
			<json:property name="isFirstTimeUser">true </json:property>
			<json:property name="firstTimeUserHeaderTextKey">${MYVHtmlConfiguration.firstTimeUserHeaderTextKey} </json:property>
			<json:property name="firstTimeUserMessageTextKey">${MYVHtmlConfiguration.firstTimeUserMessageTextKey} </json:property>
			<json:property name="placeHolderMap">${placeHolderMap} </json:property>
		</c:when>
		<c:when test="${myvBillSummaryInfoBean.oneBillUser}">
			<json:property name="isOneBillUser">true </json:property>
			<json:property name="oneBillUserHeaderTextKey">${MYVHtmlConfiguration.oneBillUserHeaderTextKey} </json:property>
			<json:property name="oneBillUserMessageTextKey">${MYVHtmlConfiguration.oneBillUserMessageTextKey} </json:property>
			<json:property name="placeHolderMap">${placeHolderMap} </json:property>
		</c:when>
		<c:when test="${receivablesControlAccountFlag}">
			<json:property name="isReceivablesControlAccountFlag">true </json:property>
			<json:property name="receivableControlFlagNote">${MYVHtmlConfiguration.receivableControlFlagNote} </json:property>
			<json:property name="receivableControlFlagMessage1">${MYVHtmlConfiguration.receivableControlFlagMessage1} </json:property>
			<json:property name="totalDueAmount">$${myvBillSummaryInfoBean.totalDueAmount} </json:property>
			<json:property name="receivableControlFlagMessage2">${MYVHtmlConfiguration.receivableControlFlagMessage2} </json:property>
			<json:property name="currentCharges">$${currentCharges} </json:property>
			<json:property name="receivableControlFlagMessage3">${MYVHtmlConfiguration.receivableControlFlagMessage3} </json:property>
		 </c:when>
		<c:when  test="${myvBillSummaryInfoBean.showEcpdDiscount}">
			<json:property name="isShowEcpdDiscount">true </json:property>
			<json:property name="noteLableKey">${noteLableKey} </json:property>
			<json:property name="youLableKey">${youLableKey} </json:property>
			<json:property name="ecpdDiscountPercent">${myvBillSummaryInfoBean.ecpdDiscountPercent}% </json:property>
			<json:property name="offLableKey">${offLableKey} </json:property>
			<json:property name="ecpdCompanyName">${myvBillSummaryInfoBean.ecpdCompanyName} </json:property>
			<json:property name="employeeLableKey">${employeeLableKey} </json:property>
		 </c:when>
		<c:when test="${myvBillSummaryInfoBean.centuryLinkUser or myvBillSummaryInfoBean.questCustomer}">
			<json:property name="isCenturyLinkUser">true </json:property>
			<json:property name="isQuestCustomer">true </json:property>
			<json:property name="myBillHeaderLabel">${myBillHeaderLabel} </json:property>
			<json:property name="myBillURL">${myvBillSummaryInfoBean.myBillURL} </json:property>
			<json:property name="centuryLinkUserHeaderTextKey">${MYVHtmlConfiguration.centuryLinkUserHeaderTextKey} </json:property>
			<json:property name="centuryLinkUserMessageTextKey">${MYVHtmlConfiguration.centuryLinkUserMessageTextKey} </json:property>
			<json:property name="placeHolderMap">${placeHolderMap} </json:property>
		</c:when>
		<c:when test="${myvBillSummaryInfoBean.newUser}">
			<json:property name="isNewUser">true </json:property>
			<json:property name="myBillHeaderLabel">${myBillHeaderLabel} </json:property>
			<json:property name="myBillURL">${myvBillSummaryInfoBean.myBillURL} </json:property>
			<c:if test="${not myvBillSummaryInfoBean.autoPayEnrolled}">
				<json:property name="isAutoPayEnrolled">true </json:property>
				<json:property name="enrollInAutoPayLabel">${enrollInAutoPayLabel} </json:property>
				<json:property name="enrollAutoPayURL">${myvBillSummaryInfoBean.enrollAutoPayURL} </json:property>
			</c:if>
			<c:if test="${not myvBillSummaryInfoBean.paperlessBillEnrolled}">
				<json:property name="isPaperlessBillEnrolled">true </json:property>
				<json:property name="enrollInPaperlessBillingLabel">${enrollInPaperlessBillingLabel} </json:property>
				<json:property name="enrollPaperlessBillURL">${myvBillSummaryInfoBean.enrollPaperlessBillURL} </json:property>
			</c:if>
			<json:property name="newUserNoteTextKey">${MYVHtmlConfiguration.newUserNoteTextKey} </json:property>
			<json:property name="placeHolderMap">${placeHolderMap} </json:property>
			<json:property name="newUserHeaderTextKey">${MYVHtmlConfiguration.newUserHeaderTextKey} </json:property>
			<json:property name="newUserMessageTextKey">${MYVHtmlConfiguration.newUserMessageTextKey} </json:property>
			<json:property name="placeHolderMap">${placeHolderMap} </json:property>
		</json:object>
	</c:when>
</c:choose>	
</c:if>
</dsp:page>  
	  
	
	          