<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %>
<json:object name="MyPlanUsage">
<json:property name="objectName">MyPlanUsage</json:property>
     <dsp:importbean bean="/com/myv/myusage/droplet/MYVValidateOneClickUpgradeDroplet"/>
	<dsp:droplet name="/com/myv/myusage/droplet/MYVRetrieveUsageInfoDroplet">
		<dsp:param name="contentItem" value="${contentItem}" />
		<dsp:oparam name="empty">
		</dsp:oparam>
		<dsp:oparam name="output">
			<dsp:getvalueof var="myvUsageInfoBean" param="usageInfo" vartype="com.myv.myusage.vo.MYVUsageInfo" />
			<dsp:getvalueof var="mdn" param="mdn" />
			<dsp:getvalueof var="CampaignResponse" param="campaignList" />
		</dsp:oparam>
	</dsp:droplet>
	<c:set var="requiredplanInfo" value="${myvUsageInfoBean.planUsageInfo}" scope="page" />	
	<c:set var="mdnusageAPIFailed" value="${myvUsageInfoBean.mdnusageAPIFailed}" scope="page" />
	<c:set var="retrievePlanUsageInfoAPIFalied" value="${requiredplanInfo.retrievePlanUsageInfoAPIFalied}" scope="page" />
	<c:set var="billCycleInfo" value="${myvUsageInfoBean.billCycleInfo}" scope="page" />

			<c:if test="${!requiredplanInfo.hideMTNList}">
			<json:property name="mtnValue">${requiredplanInfo.mtnListMap[mdn]}</json:property>
			<json:array name="usage-selector">					
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

					<c:if test="${not empty requiredplanInfo.planName}">
						<json:property name="${myvUsageInfoBean.planNameURL}">${requiredplanInfo.planName}</json:property>
					</c:if>
				<c:set var="showused" value="true"/>
				<json:object name="usageDetail">
					<c:if test="${not empty billCycleInfo.daysRemainingInNextCycle}">
							<json:property name="cal-icon">${billCycleInfo.daysRemainingInNextCycle}</json:property>
							<json:property name="displayText"> in your usage cycle</json:property>
					</c:if>
					 <c:set var="slider" value="0"/>
					 
					 	<json:array name="usageMap">
							<c:forEach items="${requiredplanInfo.usageMap}" var="entry" varStatus="count">
							
								<c:set var="bar" value="${requiredplanInfo.usageMap[entry.key]}" />
								<c:if test="${not bar.hideUsageBar}">
									<c:choose>									
											<c:when test="${bar.displayBar}">
											<c:if test="${slider == 1}">	
											<c:set var="slider" value="0" />
											</c:if>
												<json:object>
																	<json:property name="barTypeAllowanceType">${bar.barType}- ${bar.allowanceType}</json:property> 	
																		<c:if test="${ bar.hasBonus}">															
																			<c:if
																				test="${not empty bar.totalBonusAllowed and not empty bar.unitOfMeasure}">
																			  <json:property name="barTotalBonusAllowed">Includes ${bar.totalBonusAllowed} Bonus</json:property>
																			</c:if>															
																		</c:if>
																<c:set var="barType" value="${bar.barType}" />
																<c:if test="${ bar.showUpgeadeLink}">
																	
																		     <c:choose>
																			<c:when test="${ bar.hasOverage}">													
																				<c:if test="${not empty bar.overAgequantity and not empty bar.overAgeUnit}">
																				  <json:property name="usage-overage-msg">+${bar.overAgequantity} ${bar.overAgeUnit} Overage</json:property>
																				</c:if>
																			</c:when>
																			<c:otherwise>
																				<json:property name="dataLimitText">Approaching Data Limit</json:property>
																			</c:otherwise>
																			</c:choose>
																			
																			<c:if test="${ bar.showUpgeadeLink}">
																					<c:choose>
																						<c:when test="${fn:containsIgnoreCase(barType, 'data')  }">
																							<c:set var="increaseOrUpgrade" value="INCREASE"/>
																						</c:when>
																						<c:otherwise> 
																							<c:set var="increaseOrUpgrade" value="UPGRADE"/>
																						</c:otherwise>
																					</c:choose>
																				<json:property name="showUpgradeLink"><c:out value="${increaseOrUpgrade}"/> ${bar.barType}</json:property>
																			</c:if>
																																				
																</c:if>
																		<json:property name="UsedButton">Used</json:property>
																	<c:choose>
																		<c:when test="${ bar.hasOverage}" >
																		<json:property name="OverageButton">Overage</json:property>
																		</c:when>
																		<c:otherwise>
																		<json:property name="AvailableButton">Available</json:property>
																		</c:otherwise>
																	</c:choose>
													
													</json:object>
													
											</c:when>
											<c:otherwise>
											  <json:object>
											   <c:if test="${slider == 0}">
												 <c:set var="slider" value="1" />
												 
											   </c:if>
												  
												   <c:set var="barType" value="${bar.barType}" />
												  
													  		<json:property name="barTypeAllowanceType">${bar.barType}- ${bar.allowanceType}</json:property> 												
															<json:property name="totalUsed">${bar.totalUsed}</json:property> 
															<json:property name="unitOfMeasure">${bar.unitOfMeasure}</json:property>
															<json:property name="usedText">Used</json:property>  
											  </json:object>									
											</c:otherwise>										
									</c:choose>	
								</c:if>
							</c:forEach>
							</json:array>
							<c:if test="${slider == 1}">	
							
							</c:if>
					</json:object> 
				
					
					<c:if test="${not hotspotUsageInfo.hideHotSpotUsage}">
							<c:choose>
								<c:when test="${not hotspotUsageInfo.hasOverage }">
									<c:if test="${ not empty hotspotUsageInfo.unitOfMeasure and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">	
											<json:property name="Hotspot">#</json:property>
											<json:property name="UsageLabel">Usage:</json:property>
											<json:property name="totalUsed">${hotspotUsageInfo.totalUsed}</json:property>
											<json:property name="unitOfMeasure">${hotspotUsageInfo.unitOfMeasure}</json:property>
											<json:property name="ofLabel">of</json:property>
											<json:property name="totalAllowed">${hotspotUsageInfo.totalAllowed}</json:property>
											<json:property name="unitOfMeasure">${hotspotUsageInfo.unitOfMeasure}</json:property>													
											<json:property name="usedLabel">used</json:property>									
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${ not empty hotspotUsageInfo.overAgeUnit and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
											<json:property name="Hotspot">#</json:property>
											<json:property name="UsageLabel">Usage:</json:property>
											<json:property name="totalUsed">${hotspotUsageInfo.totalUsed}</json:property>
											<json:property name="overAgeUnit">${hotspotUsageInfo.overAgeUnit}</json:property>
											<json:property name="ofLabel">of</json:property>
											<json:property name="totalAllowed">${hotspotUsageInfo.totalAllowed}</json:property>
											<json:property name="overAgeUnit">${hotspotUsageInfo.overAgeUnit}</json:property>													
											<json:property name="usedLabel">used</json:property>
									</c:if>	
								</c:otherwise>
							</c:choose>
						</c:if>
					
					  		<json:property name="estimatedLabel"> All usage is estimated</json:property>
					  		<json:property name="colorLegendLabel">Color Legend</json:property>
					<json:property name="ViewUsageDetailButton">#</json:property>
			</json:object>
			</c:if>
			
			<json:object name="PlanManagement">
				<json:property name="PlanManagementLabel">Plan Management</json:property>
					
					<c:if test="${CampaignResponse.size()>0}">
						<c:if test="${(CampaignResponse['PlanCarousel'] ne null)}">
							<c:forEach items="${CampaignResponse['PlanCarousel']}"  var="campaignList">			
								<json:property name="htmlContent">${campaignList.htmlContent}</json:property>
							</c:forEach>
						</c:if>
					</c:if>
				
					<c:if test="${requiredplanInfo.hasGlobalUsage}">
							<%-- <json:property name="ManageGlobal/InternationalPlans" >${myvUsageInfoBean.manageglobalandinternationalplanlink}</json:property> --%>
					</c:if>
					<c:choose>
						<c:when test="${requiredplanInfo.alpAndMe}">							
							<json:property name="ManageData" >${myvUsageInfoBean.changePlanURL}</json:property>
						</c:when>
						<c:otherwise>								
							<json:property name="ManageData" >${myvUsageInfoBean.changePlanURL}</json:property>
						</c:otherwise>
				    </c:choose>	
					<json:property name="ManageFeatures" >${myvUsageInfoBean.myProductsandAppsURL}</json:property>
					
			</json:object>
	</json:object>			
