<dsp:page>
	<dsp:importbean bean="/com/myv/common/cq/MYVLabelConfiguration" />
	<dsp:getvalueof var="MYVLabelConfiguration"
		bean="MYVLabelConfiguration" />
	<dsp:getvalueof var="MYVLabelConfiguration"
		bean="MYVLabelConfiguration"
		vartype="com.myv.common.cq.MVMLabelConfiguration" />
	<dsp:importbean bean="/com/myv/common/cq/MYVHtmlConfiguration" />
	<dsp:getvalueof var="MYVHtmlConfiguration" bean="MYVHtmlConfiguration"
		vartype="com.myv.common.cq.MYVHtmlConfiguration" />

	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.myPlanlabelkey}"
		labelVar="labelObject" />
	<c:set var="myPlanlabelkey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.colorLegendLabelKey}"
		labelVar="labelObject" />
	<c:set var="colorLegendLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.viewUsageLabelKey}"
		labelVar="labelObject" />
	<c:set var="viewUsageLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.increaseLabelKey}"
		labelVar="labelObject" />
	<c:set var="increaseLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.upgradeLabelKey}"
		labelVar="labelObject" />
	<c:set var="upgradeLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.usedLabelKey}"
		labelVar="labelObject" />
	<c:set var="usedLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.availableLabelKey}"
		labelVar="labelObject" />
	<c:set var="availableLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.usageEstimatedMsgLabelKey}"
		labelVar="labelObject" />
	<c:set var="usageEstimatedMsgLabelKey"
		value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.hotspotLabelKey}"
		labelVar="labelObject" />
	<c:set var="hotspotLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.planManagementLabelKey}"
		labelVar="labelObject" />
	<c:set var="planManagementLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.manageDataLabelKey}"
		labelVar="labelObject" />
	<c:set var="manageDataLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.managePlansLabelKey}"
		labelVar="labelObject" />
	<c:set var="managePlansLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.daysLeftinUsageLabelKey}"
		labelVar="labelObject" />
	<c:set var="daysLeftinUsageLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.manageProductsLabelKey}"
		labelVar="labelObject" />
	<c:set var="manageProductsLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.usageLabelKey}"
		labelVar="labelObject" />
	<c:set var="usageLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.allUsageEstimatedHtml}"
		labelVar="labelObject" />
	<c:set var="allUsageEstimatedHtml" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.colorLegendToolTipHtml}"
		labelVar="labelObject" />
	<c:set var="colorLegendToolTipHtml" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.sharedlabelKey}"
		labelVar="labelObject" />
	<c:set var="sharedlabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.bonusDatalabelKey}"
		labelVar="labelObject" />
	<c:set var="bonusDatalabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.oflabelKey}"
		labelVar="labelObject" />
	<c:set var="oflabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.usedLabelKey}"
		labelVar="labelObject" />
	<c:set var="usedLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.internationalplanlabelKey}"
		labelVar="labelObject" />
	<c:set var="internationalplanlabelKey"
		value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.chooselinelabelKey}"
		labelVar="labelObject" />
	<c:set var="chooselinelabelKey" value="${labelObject.labelValue}" />
	<dsp:getvalueof bean="/atg/userprofiling/Profile.vzwRole"
		var="userRole" />
	<dsp:droplet
		name="/com/myv/myusage/droplet/MYVRetrieveUsageInfoDroplet">
		<dsp:param name="contentItem" value="${contentItem}" />
		<dsp:oparam name="empty">
		</dsp:oparam>
		<dsp:oparam name="output">
			<dsp:getvalueof var="myvUsageInfoBean" param="usageInfo"
				vartype="com.myv.myusage.vo.MYVUsageInfo" />
			<dsp:getvalueof var="mdn" param="mdn" />
			<dsp:getvalueof var="CampaignResponse" param="campaignList" />
			<dsp:getvalueof var="mtnToUUIDMap" param="mtnToUUIDMap" />
			<dsp:getvalueof var="paramSecurityKillSwitch"
				param="paramSecurityKillSwitch" />
		</dsp:oparam>
	</dsp:droplet>
	<c:set var="requiredplanInfo" value="${myvUsageInfoBean.planUsageInfo}"
		scope="page" />
	<c:set var="mdnusageAPIFailed"
		value="${myvUsageInfoBean.mdnusageAPIFailed}" scope="page" />
	<c:set var="retrievePlanUsageInfoAPIFalied"
		value="${requiredplanInfo.retrievePlanUsageInfoAPIFalied}"
		scope="page" />
	<c:set var="billCycleInfo" value="${myvUsageInfoBean.billCycleInfo}"
		scope="page" />
	<c:set var="hotspotUsageInfo" value="${requiredplanInfo.hotspotUsage}"
		scope="page" />
		
	<json:object name="MyPlanUsage">
		<json:property name="objectName">MyPlanUsage</json:property>
		<c:if
			test="${!requiredplanInfo.hideMTNList && userRole ne 'nonRegister' && userRole ne 'mobileSecure' && (fn:length(requiredplanInfo.mtnListMap)>1)}">
			<json:property name="mtnValue">${requiredplanInfo.mtnListMap[mdn]}</json:property>
			<json:array name="usageSelector">
				<select>
					<c:forEach var="entry" items="${requiredplanInfo.mtnListMap}">
						<json:property name="${entry.key}">${entry.value}</json:property>
					</c:forEach>
				</select>
			</json:array>
		</c:if>
		<c:if test="${not mdnusageAPIFailed}">
			<json:object name="MyPlan">
				<json:property name="MyPlanLabel">MyPlan</json:property>
				<json:property name="MyPlanLabelKey">${myPlanlabelkey}</json:property>
				<c:if test="${not empty requiredplanInfo.planName}">
					<json:property name="${myvUsageInfoBean.planNameURL}">${requiredplanInfo.planName}</json:property>
				</c:if>
				<c:set var="showused" value="true" />
				<json:object name="usageDetail">
					<c:if test="${not empty billCycleInfo.daysRemainingInNextCycle}">
						<json:property name="message">${billCycleInfo.daysRemainingInNextCycle}${daysLeftinUsageLabelKey} </json:property>
						<json:property name="displayText">
							<verizon:html contentCategory="HTML"
								contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}" />
						</json:property>
					</c:if>
					<json:property name="colorLazandKey">${colorLegendLabelKey} </json:property>
					<json:property name="colorLazandValue">${colorLegendToolTipHtml} </json:property>
					<json:property name="usageDetailsURL">${myvUsageInfoBean.viewUsageDetailsURL}</json:property>
					<json:property name="usageDetailsKey">${viewUsageLabelKey}</json:property>
					<json:array name="usageMap">
						<c:forEach items="${requiredplanInfo.usageMap}" var="entry"
							varStatus="count">
							<c:set var="bar" value="${requiredplanInfo.usageMap[entry.key]}" />
							<c:if test="${bar.hideUsageBar}">
								<c:set var="status" value="${status + 1}" />
							</c:if>
							<c:set var="barType" value="${bar.barType}" />
							<c:if test="${not bar.hideUsageBar}">
								<c:choose>
									<c:when test="${bar.displayBar}">
										<json:object>
											<json:property name="usageMeterText">${bar.barType}- ${bar.totalAllowed}${bar.unitOfMeasure}</json:property>
											<c:if test="${bar.shared}">
								 ${sharedLabel}
								 <c:if test="${ bar.hasBonus}">
													<c:if
														test="${not empty bar.totalBonusAllowed and not empty bar.unitOfMeasure}">
														<json:property name="greenHighlight">+ ${bar.totalBonusAllowed}</json:property>
														<json:property name="gigabytes">${bar.unitOfMeasure}${bonusDatalabelKey}</json:property>
													</c:if>
													<c:if test="${ bar.hasOverage}">
														<c:if
															test="${not empty bar.overAgequantity and not empty bar.overAgeUnit}">
							                        + ${bar.totalUsed - bar.totalAllowed} 
							                     <json:property name="gigabytes">${bar.overAgeUnit}${overageAlertLabel}</json:property>
															<json:property name="questionTooltip">${overageAlertToolTipHtml}</json:property>
														</c:if>

													</c:if>
													<json:property name="guageDataUsed">${bar.totalUsed}</json:property>
													<json:property name="dataAvailable">${bar.totalAllowed}</json:property>
													<json:property name="dataMeasure">${bar.unitOfMeasure}</json:property>
													<json:property name="dataBarType">${barType}</json:property>
													<c:if test="${ bar.showUpgeadeLink}">
														<json:property name="usageUpgradeURL">${myvUsageInfoBean.oneClickUpgradeURL}</json:property>
														<c:choose>
															<c:when
																test="${fn:containsIgnoreCase(barType, 'data')  }">
																<json:property name="increaseLabelKey">${increaseLabelKey}</json:property>

															</c:when>
															<c:otherwise>
																<json:property name="upgradeLabelKey">${upgradeLabelKey}</json:property>

															</c:otherwise>
														</c:choose>
														<json:property name="barType">${barType}</json:property>
													</c:if>
													<c:if test="${showused}">
														<c:set var="showused" value="false" />
														<json:property name="objectName">UsageMeterToggles</json:property>
														<json:property name="usedLabelKey">${usedLabelKey}</json:property>
														<json:property name="availableLabelKey">${availableLabelKey}</json:property>
													</c:if>
									</c:when>
									<c:otherwise>
										<json:property name="objectName">UsageDataMeter</json:property>
										<json:property name="usageDataMeterText">${barType} -${bar.allowanceType} </json:property>
										<json:property name="usageDataMeterNumber">${bar.totalUsed} ${bar.unitOfMeasure} ${usedLabelKey}</json:property>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
						<json:property name="objectName">hotspotUsageInfo</json:property>
						<c:if test="${not hotspotUsageInfo.hideHotSpotUsage}">
							<c:choose>
								<c:when test="${not hotspotUsageInfo.hasOverage }">
									<json:property name="hotspotLabelKey">${hotspotLabelKey} </json:property>
									<json:property name="usageLabelKey">${usageLabelKey} </json:property>
									<c:if
										test="${ not empty hotspotUsageInfo.unitOfMeasure and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
										<json:property name="objectName">UsageDetails</json:property>
										<json:property name="totalUsed">${hotspotUsageInfo.totalUsed} </json:property>
										<json:property name="unitOfMeasure">${hotspotUsageInfo.unitOfMeasure} ${oflabelKey} </json:property>
										<json:property name="totalAllowed">${hotspotUsageInfo.totalAllowed} </json:property>
										<json:property name="usedLabelKey">${hotspotUsageInfo.unitOfMeasure} ${usedLabelKey} <verizon:html
												contentCategory="HTML"
												contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}" />
										</json:property>
									</c:if>
								</c:when>
								<c:otherwise>
									<json:property name="hotspotLabelKey">${hotspotLabelKey} </json:property>
									<json:property name="usageLabelKey">${usageLabelKey} </json:property>
									<c:if
										test="${ not empty hotspotUsageInfo.overAgeUnit and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
										<json:property name="objectName">hotspotDetails</json:property>
										<json:property name="totalUsed">${hotspotUsageInfo.totalUsed} </json:property>
										<json:property name="unitOfMeasure">${hotspotUsageInfo.overAgeUnit} ${oflabelKey} </json:property>
										<json:property name="totalAllowed">${hotspotUsageInfo.totalAllowed} </json:property>
										<json:property name="usedLabelKey">
								${hotspotUsageInfo.overAgeUnit} ${usedLabelKey} <verizon:html
												contentCategory="HTML"
												contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}" />
										</json:property>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:if>
						<json:property name="usageMeterNote">${usageEstimatedMsgLabelKey} </json:property>
						<json:property name="objectName">planManage</json:property>
						<json:property name="planlinkURL">${myvUsageInfoBean.planManagementURL} </json:property>
						<json:property name="PlanManagement">${planManagementLabelKey} </json:property>
						<c:if test="${ userRole ne 'mobileSecure' }">
							<c:choose>
								<c:when test="${requiredplanInfo.alpAndMe}">
									<json:property name="changePlanURL">${manageDataLabelKey} </json:property>

								</c:when>
								<c:otherwise>
									<json:property name="changePlanURL">${manageDataLabelKey} </json:property>

								</c:otherwise>
							</c:choose>
						</c:if>
						<c:if
							test="${userRole ne 'nonRegister' && userRole ne 'mobileSecure'}">
							<json:property name="myProductsandAppsURL">${myvUsageInfoBean.myProductsandAppsURL} </json:property>
							<json:property name="title">${manageProductsLabelKey} </json:property>
						</c:if>
						<json:property name="objectName">FooterlinkDetails</json:property>
						<c:if test="${requiredplanInfo.hasGlobalUsage}">
							<json:property name="caretLink">${myvUsageInfoBean.manageglobalandinternationalplanlinkURL} </json:property>
							<json:property name="internationalPlans">${managePlansLabelKey} </json:property>
						</c:if>

						<c:if test="${CampaignResponse.size()>0}">
							<c:if test="${(CampaignResponse['PlanCarousel'] ne null)}">
								<json:array>
									<c:forEach items="${CampaignResponse['PlanCarousel']}"
										var="campaignList">
										<json:property name="htmlContent">${campaignList.htmlContent} </json:property>
									</c:forEach>
								</json:array>
							</c:if>
						</c:if>
		
		</json:object>
		</json:object>
	</c:if>
	</json:object>
</dsp:page>
