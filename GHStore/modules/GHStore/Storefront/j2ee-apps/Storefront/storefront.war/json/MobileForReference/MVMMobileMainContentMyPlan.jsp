<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" prefix="dsp"%>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %>
<%@ taglib uri="/WEB-INF/tld/verizon.tld" prefix="verizon" %>
<%@page language="java" pageEncoding="UTF-8" contentType="application/json;charset=UTF-8"%>

<dsp:page>
    <dsp:importbean bean="/com/myv/myusage/droplet/MYVValidateOneClickUpgradeDroplet"/>
    <dsp:importbean var="MYVLabelConfiguration" bean="/com/myv/common/cq/MYVLabelConfiguration"/>
     
    <verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.myPlanlabelkey}" labelVar="labelObject" />
	<c:set var="myPlanlabelkey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usageCyclelabelkey}" labelVar="labelObject" />
	<c:set var="usageCyclelabelkey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.dataLimitMsgLabelKey}" labelVar="labelObject" />
	<c:set var="dataLimitMsgLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.increaseLabelKey}" labelVar="labelObject" />
	<c:set var="IncreaseLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.upgradeLabelKey}" labelVar="labelObject" />
	<c:set var="UpgradeLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.hotspotLabelKey}" labelVar="labelObject" />
	<c:set var="HotspotLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usageLabelKey}" labelVar="labelObject" />
	<c:set var="UsageLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usageEstimatedMsgLabelKey}" labelVar="labelObject" />
	<c:set var="UsageEstimatedMsgLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.colorLegendLabelKey}" labelVar="labelObject" />
	<c:set var="ColorLegendLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.viewUsageLabelKey}" labelVar="labelObject" />
	<c:set var="ViewUsageLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.planManagementLabelKey}" labelVar="labelObject" />
	<c:set var="PlanManagementLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.managePlansLabelKey}" labelVar="labelObject" />
	<c:set var="ManagePlansLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usedLabelKey}" labelVar="labelObject" />
	<c:set var="UsedLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.overageLabelKey}" labelVar="labelObject" />
	<c:set var="OverageLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.availableLabelKey}" labelVar="labelObject" />
	<c:set var="AvailableLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.manageDataLabelKey}" labelVar="labelObject" />
	<c:set var="ManageDataLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.manageFeaturesLabelKey}" labelVar="labelObject" />
	<c:set var="ManageFeaturesLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.bonusLabelKey}" labelVar="labelObject" />
	<c:set var="BonusLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.allUsageEstimatedHtml}" labelVar="labelObject" />
	<c:set var="allUsageEstimatedHtml" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.colorLegendToolTipHtml}" labelVar="labelObject" />
	<c:set var="colorLegendToolTipHtml" value="${labelObject.labelValue}"/>
    
 	<dsp:getvalueof bean="/atg/userprofiling/Profile.vzwRole" var="userRole"/>
	<dsp:droplet name="/com/myv/myusage/droplet/MYVRetrieveUsageInfoDroplet">
		<dsp:param name="contentItem" value="${contentItem}" />
		<dsp:oparam name="empty">
		</dsp:oparam>
		<dsp:oparam name="output">
			<dsp:getvalueof var="myvUsageInfoBean" param="usageInfo" vartype="com.myv.myusage.vo.MYVUsageInfo" />
			<dsp:getvalueof var="mdn" param="mdn" />
			<dsp:getvalueof var="CampaignResponse" param="campaignList" />
			<dsp:getvalueof var="mtnToUUIDMap" param="mtnToUUIDMap" />
			<dsp:getvalueof var="paramSecurityKillSwitch" param="paramSecurityKillSwitch" />
		</dsp:oparam>
	</dsp:droplet>
	

	<json:object>
		<json:property name="objectName">PlanUsage</json:property>
		<json:property name="selectedMDN">${mdn}</json:property>
	
		<json:array name="mdnToUUIDMap">
			<c:forEach items="${mtnToUUIDMap}" var="item" varStatus="loop">
			  <json:object>
				  <json:property name="UUIDMapKey">${item.key}</json:property>
				  <json:property name="UUIDMapValue">'${item.value}' ${not loop.last ? ',' : ''}</json:property>
			  </json:object>
		    </c:forEach>
		</json:array>
	
	<c:set var="requiredplanInfo" value="${myvUsageInfoBean.planUsageInfo}" scope="page" />	
	<c:set var="mdnusageAPIFailed" value="${myvUsageInfoBean.mdnusageAPIFailed}" scope="page" />
	<c:set var="retrievePlanUsageInfoAPIFalied" value="${requiredplanInfo.retrievePlanUsageInfoAPIFalied}" scope="page" />
	<c:set var="billCycleInfo" value="${myvUsageInfoBean.billCycleInfo}" scope="page" />
	<c:set var="hotspotUsageInfo" value="${requiredplanInfo.hotspotUsage}" scope="page" />
	
			
	<c:if test="${not mdnusageAPIFailed}">
	<c:if test="${!requiredplanInfo.hideMTNList && userRole ne 'nonRegister' && userRole ne 'mobileSecure' && (fn:length(requiredplanInfo.mtnListMap)>1)}">
		<json:property name="mtnValue">${requiredplanInfo.mtnListMap[mdn]}</json:property>
		<json:array name="usageSelector">					
				<c:forEach var="entry" items="${requiredplanInfo.mtnListMap}">
					<json:object>
					    <json:property name="usageSelectorKey">${entry.key}</json:property>
					    <json:property name="usageSelectorValue">${entry.value}</json:property>
					</json:object>
				</c:forEach>
		</json:array>
	 </c:if>
			
	<json:property name="myPlanLabel">${myPlanlabelkey}</json:property>
				
	<c:if test="${not empty requiredplanInfo.planName}">
		<json:property name="myPlanLabelURL">#</json:property>
		<json:property name="myPlanLabelURLText">${requiredplanInfo.planName}</json:property>
	</c:if>

	<c:set var="showused" value="true"/>
					
	<c:if test="${not empty billCycleInfo.daysRemainingInNextCycle}">
		<json:property name="billCycleInfoMessage"><strong>${billCycleInfo.daysRemainingInNextCycle}</strong>
		${usageCyclelabelkey}
		</json:property>
		<json:property name="billCycleInfoToolTipMessage">It's business controllable TBD</json:property>
	</c:if>
					
					
	 <c:set var="slider" value="0"/>
					
 	<json:array name="usageMap">
	<c:forEach items="${requiredplanInfo.usageMap}" var="entry" varStatus="count">
		<json:object>					
		<c:set var="bar" value="${requiredplanInfo.usageMap[entry.key]}" />
		<json:property name="showUsageBar">${not bar.hideUsageBar}</json:property>
		<c:if test="${not bar.hideUsageBar}">
			<c:choose>									
				<c:when test="${bar.displayBar}">
					<json:property name="barType">${bar.barType}</json:property>
					<json:property name="barLimit">${bar.totalAllowed}</json:property>
					<json:property name="barUOM">${bar.unitOfMeasure}</json:property>
						<c:if test="${ bar.hasBonus}">															
							<json:property name="hasBonus">true</json:property>
							<c:if test="${not empty bar.totalBonusAllowed and not empty bar.unitOfMeasure}">
								<json:property name="barBonusMessage">Includes ${bar.totalBonusAllowed} ${BonusLabelKey}</json:property>
							</c:if>															
						</c:if>
						<c:set var="barType" value="${bar.barType}" />
					<json:property name="barTotalAllowed">${bar.totalAllowed}</json:property>
					<json:property name="barTotalUsed">${bar.totalUsed}</json:property>
													
					<c:if test="${bar.showUpgeadeLink}">
						 <json:property name="showUpgradeLink">true</json:property>
					     <c:choose>
							<c:when test="${bar.hasOverage}">													
								<json:property name="hasUsageOverage">true</json:property>
								<c:if test="${not empty bar.overAgequantity and not empty bar.overAgeUnit}">
									<json:property name="usageOverageMessage">+${bar.totalUsed - bar.totalAllowed}&nbsp;${bar.overAgeUnit}&nbsp;${OverageLabelKey}</json:property>
								</c:if>
							</c:when>
							<c:otherwise>
								<json:property name="hasUsageOverage">false</json:property>
								<json:property name="dataLimitMessageLabel">${dataLimitMsgLabelKey}</json:property>
							</c:otherwise>
						</c:choose>
													
						<c:if test="${ bar.showUpgeadeLink}">
						    <json:property name="upgradeLinkURL">#</json:property>
							<c:choose>
								<c:when test="${fn:containsIgnoreCase(barType, 'data')  }">
								    <json:property name="upgradeLinkURLText">${IncreaseLabelKey}&nbsp;${bar.barType}</json:property>
								</c:when>
								<c:otherwise> 
								    <json:property name="upgradeLinkURLText">${UpgradeLabelKey}&nbsp;${bar.barType}</json:property>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>
					
				    <json:property name="usedLabel">${UsedLabelKey}</json:property>
					<c:choose>
						<c:when test="${ bar.hasOverage}" >
						    <json:property name="availableLabel">${OverageLabelKey}</json:property>
						</c:when>
						<c:otherwise>
						    <json:property name="availableLabel">${AvailableLabelKey}</json:property>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
									
					<c:if test="${slider == 0}">
						<c:set var="slider" value="1" />
					</c:if>
									  
					<c:set var="barType" value="${bar.barType}" />
					<json:property name="barAllowanceType">${bar.allowanceType}</json:property>
					<json:property name="barUOM">${bar.unitOfMeasure}</json:property>
					<json:property name="barTotalUsed">${bar.totalUsed}</json:property>
				    <json:property name="usedLabel">${UsedLabelKey}</json:property>
				</c:otherwise>										
			</c:choose>	
		</c:if>
		</json:object>
	</c:forEach>
	</json:array>

	<c:if test="${slider == 1}">	
	</c:if>
							
	<c:if test="${not hotspotUsageInfo.hideHotSpotUsage}">
		    <json:property name="showHotSpotUsage">true</json:property>
			<c:choose>
				<c:when test="${not hotspotUsageInfo.hasOverage }">
				    <json:property name="hasHotSpotOverage">false</json:property>
					<c:if test="${ not empty hotspotUsageInfo.unitOfMeasure and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">	
					    <json:property name="hotSpotUsageURL">#</json:property>
					    <json:property name="hotSpotUsageURLText">${HotspotLabelKey}</json:property>
					    <json:property name="hotSpotUsageLabel">${UsageLabelKey}</json:property>
					    <json:property name="hotSpotUsageTotalUsed">${hotspotUsageInfo.totalUsed}</json:property>
					    <json:property name="hotSpotUsageUOM">${hotspotUsageInfo.unitOfMeasure}</json:property>
					    <json:property name="hotSpotUsageTotalAllowed">${hotspotUsageInfo.totalAllowed}</json:property>
					</c:if>
				</c:when>
				<c:otherwise>
				    <json:property name="hasHotSpotOverage">true</json:property>
					<c:if test="${ not empty hotspotUsageInfo.overAgeUnit and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
					    <json:property name="hotSpotUsageURL">#</json:property>
					    <json:property name="hotSpotUsageURLText">${HotspotLabelKey}</json:property>
					    <json:property name="hotSpotUsageLabel">${UsageLabelKey}</json:property>
					    <json:property name="hotSpotUsageTotalUsed">${hotspotUsageInfo.totalUsed}</json:property>
					    <json:property name="hotSpotUsageUOM">${hotspotUsageInfo.overAgeUnit}</json:property>
					    <json:property name="hotSpotUsageTotalAllowed">${hotspotUsageInfo.totalAllowed}</json:property>
					</c:if>	
				</c:otherwise>
			</c:choose>
		</c:if>
	    <json:property name="usageEstimatedMessageLabel">${UsageEstimatedMsgLabelKey}</json:property>
	    <json:property name="allUsageEstimatedMessage">${allUsageEstimatedHtml}</json:property>
	    <json:property name="colorLegendLabel">${ColorLegendLabelKey}</json:property>
	    <json:property name="colorLegendToolTipLabel">${colorLegendToolTipHtml}</json:property>
	    <json:property name="viewUsageLabelURL">#</json:property>
	    <json:property name="viewUsageLabelURLText">${ViewUsageLabelKey}</json:property>
	    
	</c:if>

    <json:property name="planManagementLabel">${PlanManagementLabelKey}</json:property>
	<c:if test="${CampaignResponse.size()>0}">
		<c:if test="${(CampaignResponse['PlanCarousel'] ne null)}">
			<json:array name="campaigns">
			<c:forEach items="${CampaignResponse['PlanCarousel']}"  var="campaignList">
				<json:object>
				    <json:property name="campaignContent">${campaignList.htmlContent}</json:property>
				</json:object>		
			</c:forEach>
			</json:array>
		</c:if>
	</c:if>
				
	<c:if test="${requiredplanInfo.hasGlobalUsage}">
    	<json:property name="hasGlobalUsage">true</json:property>
    	<json:property name="managePlanURL">#</json:property>
    	<json:property name="managePlanURLText">${ManagePlansLabelKey}</json:property>
	</c:if>
	<c:choose>
		<c:when test="${requiredplanInfo.alpAndMe}">							
	    	<json:property name="isAlpAndMe">true</json:property>
	    	<json:property name="manageDataURL">#</json:property>
	    	<json:property name="manageDataURLText">${ManageDataLabelKey}</json:property>
		</c:when>
		<c:otherwise>								
	    	<json:property name="isAlpAndMe">false</json:property>
	    	<json:property name="manageDataURL">#</json:property>
	    	<json:property name="manageDataURLText">${ManageDataLabelKey}</json:property>
		</c:otherwise>
    </c:choose>	
   	<json:property name="manageFeaturesURL">#</json:property>
   	<json:property name="manageFeaturesURLText">${ManageFeaturesLabelKey}</json:property>
</json:object>
</dsp:page>