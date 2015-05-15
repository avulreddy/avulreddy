<div id="plansUsage">
     <%@ taglib uri="/WEB-INF/tld/verizon.tld" prefix="verizon" %>
     <dsp:importbean bean="/com/myv/myusage/droplet/MYVValidateOneClickUpgradeDroplet"/>
    <dsp:importbean var="MYVLabelConfiguration" bean="/com/myv/common/cq/MYVLabelConfiguration"/>
    <dsp:importbean bean="/com/myv/common/cq/MYVHtmlConfiguration"/>
	<dsp:getvalueof var="MYVHtmlConfiguration" bean="MYVHtmlConfiguration" vartype="com.myv.common.cq.MYVHtmlConfiguration"/>
     
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
	<%-- <verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.sharedlabelKey}" labelVar="labelObject" />
	<c:set var="sharedlabelKey" value="${labelObject.sharedlabelKey}"/> --%>
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
	
	<input type="hidden" name="mdn" value="${mdn}" id="mdn">
	<input type="hidden" name="uuidMap" value="${mtnToUUIDMap}" id="uuidMap">
	<script>
	var mdnObj= {
			<c:forEach items="${mtnToUUIDMap}" var="item" varStatus="loop">
		      '${item.key}' : '${item.value}' ${not loop.last ? ',' : ''}
		    </c:forEach>			
	}
	</script>
	<input type="hidden" name="paramSecurityKillSwitch" value="${paramSecurityKillSwitch}" id="paramSecurityKillSwitch">
	
	<c:set var="requiredplanInfo" value="${myvUsageInfoBean.planUsageInfo}" scope="page" />	
	<c:set var="mdnusageAPIFailed" value="${myvUsageInfoBean.mdnusageAPIFailed}" scope="page" />
	<c:set var="retrievePlanUsageInfoAPIFalied" value="${requiredplanInfo.retrievePlanUsageInfoAPIFalied}" scope="page" />
	<c:set var="billCycleInfo" value="${myvUsageInfoBean.billCycleInfo}" scope="page" />
		<c:set var="hotspotUsageInfo" value="${requiredplanInfo.hotspotUsage}" scope="page" />
	
		<!--	<div class="o-usage-selector">
				<select class="o-usage-selector-select o-select">
					<option>Lorem ipsum</option>
					<option>Lorem ipsum</option>
					<option>Lorem ipsum</option>
				</select>
			</div> -->
			
			<c:if test="${not mdnusageAPIFailed}">
			<c:if test="${!requiredplanInfo.hideMTNList && userRole ne 'nonRegister' && userRole ne 'mobileSecure' && (fn:length(requiredplanInfo.mtnListMap)>1)}">
				<div class="o-usage-selector">
					<input type="hidden" name="mtnValue" value="${requiredplanInfo.mtnListMap[mdn]}" id="mtnValue">
					<select class="o-usage-selector-select o-select">
						<c:forEach var="entry" items="${requiredplanInfo.mtnListMap}">
							<option value="${entry.key}">
								<c:out value="${entry.value}" />
							</option>
						</c:forEach>
					</select>
				</div>
			 </c:if>
			<!--<h2>
				My Plan:
				<span>6 GB MORE Everything</span>
			</h2> -->
		
			
				<h2>
				
					${myPlanlabelkey}
				
					<c:if test="${not empty requiredplanInfo.planName}">
						<a href="#"> 
							<span class="int-link" data-screenid="chgplan"> ${requiredplanInfo.planName} </span>
						</a>
					</c:if>
				</h2>
				<c:set var="showused" value="true"/>
			  <!--  <c:set var="status" value="2"/>-->
				<div class="o-usage-detail">
					
						<div class="o-cal-icon">
							<c:if test="${not empty billCycleInfo.daysRemainingInNextCycle}">
								<strong>${billCycleInfo.daysRemainingInNextCycle}</strong>
								${usageCyclelabelkey}
							</c:if>
							<verizon:html contentCategory="HTML" contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}"/>							
						</div>					
					
					
					 <c:set var="slider" value="0"/>
					
					<!-- BONUS DATA -->
					
					<div class="o-swiper-container o-usage-detail-data o-swiper-container-0">
					  <div class="swiper-wrapper"> 
					 
							<c:forEach items="${requiredplanInfo.usageMap}" var="entry" varStatus="count">
							
								<c:set var="bar" value="${requiredplanInfo.usageMap[entry.key]}" />
								<!--<c:if test="${bar.hideUsageBar}">
									<c:set var="status" value="${status + 1}"/>
								</c:if>-->
								<c:if test="${not bar.hideUsageBar}">
									<c:choose>									
											<c:when test="${bar.displayBar}">
											<c:if test="${slider == 1}">	
												</div>	
											<c:set var="slider" value="0" />
											</c:if>
												<div class="swiper-slide o-usage-data-breakdown">
														<h3 class="o-usage-header-fixed">
														<c:choose>
														<c:when
																test="${fn:containsIgnoreCase(bar.barType,'MINUTES')}">
														Shared ${bar.barType}
														</c:when>
														<c:otherwise>
														${bar.barType}
														</c:otherwise>
														</c:choose>
															<span>- ${bar.totalAllowed}&nbsp;${bar.unitOfMeasure}</span>
																<c:if test="${ bar.hasBonus}">															
																	<c:if
																		test="${not empty bar.totalBonusAllowed and not empty bar.unitOfMeasure}">
																	  <span class="o-greenHighlight">Includes ${bar.totalBonusAllowed} ${BonusLabelKey}</span>
																	</c:if>															
																</c:if>
														</h3>
														<c:set var="barType" value="${bar.barType}" />
														<div class="o-gauge" data-used="${bar.totalUsed}" 
														data-available="${bar.totalAllowed}" data-measure="${bar.unitOfMeasure}">
														</div>
														
														<!-- <div class="o-gauge" data-used="3" data-available="8" data-measure="GB"></div>-->
														<!--<div class="o-usage-warn">
															<p>Approaching Data Limit</p>
															<a href="#" class="o-upgrade-data" title="Upgrade Data">Upgrade Data</a>
														</div>-->
											<c:if test="${ bar.showUpgeadeLink}">
												<div class="o-usage-warn">
													     <c:choose>
														<c:when test="${ bar.hasOverage}">													
															<c:if test="${not empty bar.overAgequantity and not empty bar.overAgeUnit}">
															  <p class="o-usage-overage-msg">+${bar.totalUsed - bar.totalAllowed}&nbsp;${bar.overAgeUnit}&nbsp;${OverageLabelKey}</p>
															</c:if>
														</c:when>
														<c:otherwise>
															<p>${dataLimitMsgLabelKey}</p>
														</c:otherwise>
														</c:choose>
														
														<c:if test="${ bar.showUpgeadeLink}">
															<a href="#" class="o-upgrade-data int-link" title="Upgrade Data" data-screenid="one-click-upgrade">
																<c:choose>
																	<c:when test="${fn:containsIgnoreCase(barType, 'data')  }">
																			 ${IncreaseLabelKey}
																	</c:when>
																	<c:otherwise>${UpgradeLabelKey} 
																	</c:otherwise>
																</c:choose>&nbsp;${bar.barType}
																
															</a>
																
														</c:if>
												</div>
											</c:if>
														<div class="o-usage-meters-toggles clr">
																<button class="o-usage-toggle-used active-toggle">${UsedLabelKey}</button>
															<c:choose>
																<c:when test="${ bar.hasOverage}" >
																<button class="o-usage-toggle-avail">${OverageLabelKey}</button>
																</c:when>
																<c:otherwise>
																<button class="o-usage-toggle-avail">${AvailableLabelKey}</button>
																</c:otherwise>
															</c:choose>
															</div>
														<!--<c:if test="${showused}"> 
															<c:set var="showused" value="false" />
															<div class="o-usage-meters-toggles clr">
																<button class="o-usage-toggle-used active-toggle">Used</button>
																<button class="o-usage-toggle-avail">Available</button>
															</div>
														</c:if>-->
													
													</div>
													
											</c:when>
											<c:otherwise>
										
											   <c:if test="${slider == 0}">
												<div class="swiper-slide">	
												 <c:set var="slider" value="1" />
												 
											   </c:if>
												  
												   <c:set var="barType" value="${bar.barType}" />
												  
													  <c:choose>
														<c:when test="${fn:containsIgnoreCase(barType, 'data')  }">
														<div class="o-usage-data o-usage-breakdown">
														</c:when>
														<c:when test="${fn:containsIgnoreCase(barType, 'minutes')  }">
														<div class="o-usage-minutes o-usage-breakdown">
														</c:when>
														<c:otherwise>
														<div class="o-usage-text o-usage-breakdown">
														</c:otherwise>
													  </c:choose> 												
															<h3>
																${bar.barType}
																<span>- ${bar.allowanceType}</span>
															</h3>
															<p>${bar.totalUsed} ${bar.unitOfMeasure}&nbsp;${UsedLabelKey}</p>
														</div>												
											</c:otherwise>										
									</c:choose>	
								</c:if>
							</c:forEach>
							<c:if test="${slider == 1}">	
							
							  </div>													
							</c:if>
							
						</div>
					</div>
					
					<div class="o-pagination-wrapper">
						<div class="o-usage-pagination pagination-0"></div>
					</div>
					<c:if test="${not hotspotUsageInfo.hideHotSpotUsage}">
							<c:choose>
								<c:when test="${not hotspotUsageInfo.hasOverage }">
									<c:if test="${ not empty hotspotUsageInfo.unitOfMeasure and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">	
										<div class="o-usage-hotspot">
											<a href="#" class="int-link" data-screenid="HotSpot Details">${HotspotLabelKey}</a>
											${UsageLabelKey}										
													${hotspotUsageInfo.totalUsed}
													${hotspotUsageInfo.unitOfMeasure} of
													${hotspotUsageInfo.totalAllowed}
													${hotspotUsageInfo.unitOfMeasure} used											
											
										</div>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${ not empty hotspotUsageInfo.overAgeUnit and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
										<div class="o-usage-hotspot o-usage-hotpsot-over">
											<a href="#" class="int-link" data-screenid="HotSpot Details">${HotspotLabelKey}</a>
											${UsageLabelKey} ${hotspotUsageInfo.totalUsed}
												${hotspotUsageInfo.overAgeUnit} of
												${hotspotUsageInfo.totalAllowed}
												${hotspotUsageInfo.overAgeUnit} used 
										</div>
									</c:if>	
								</c:otherwise>
							</c:choose>
						</c:if>
					  <div class="o-usage-detail-tips clr">
					  
							<p class="o-usage-left">
								${UsageEstimatedMsgLabelKey}
								<span class="tooltip o-icon-question" data-tooltip="${allUsageEstimatedHtml}" title="${allUsageEstimatedHtml}"></span>
							</p>
						
							<p class="o-usage-right">
								${ColorLegendLabelKey}
								<span class="tooltip o-icon-question" data-tooltip="${colorLegendToolTipHtml}" title="${colorLegendToolTipHtml}"></span>
							</p>
						</div>
						<div class="is-center">
					<a href="#" class="o-button int-link" data-screenid="usage">${ViewUsageLabelKey}</a>
					</div>
				
			</div>
			</c:if>
			<div class="o-usage-plan clr">
				<h3>${PlanManagementLabelKey}</h3>		
					
					<c:if test="${CampaignResponse.size()>0}">
						<c:if test="${(CampaignResponse['PlanCarousel'] ne null)}">
							<c:forEach items="${CampaignResponse['PlanCarousel']}"  var="campaignList">			
								<!--<div class="o-plan-analysis">-->
								<div class="o-usage-plan-widget">
								${campaignList.htmlContent}		
								<!--</div>-->
								<!--<img src="http://placehold.it/300x100&text=300x100TBD" alt="TBD" /> -->
								</div>
							</c:forEach>
						</c:if>
					</c:if>
				
				<div class="o-usage-plan-widget-buttons">
					<c:if test="${requiredplanInfo.hasGlobalUsage}">
						<div class="clr">
							<a href="#" class="o-caret-link clr int-link" data-screenid="glblIntl">${ManagePlansLabelKey}</a>
						</div>						
					</c:if>
					<c:if test="${ userRole ne 'mobileSecure' }">
					<c:choose>
						<c:when test="${requiredplanInfo.alpAndMe}">							
							<a href="#" class="o-grey-button o-usage-manage-data int-link" data-screenid="chgplan" title="Manage Data">${ManageDataLabelKey}</a>
						</c:when>
						<c:otherwise>								
							<a href="#" class="o-grey-button o-usage-manage-data int-link" data-screenid="chgplan" title="Manage Data">${ManageDataLabelKey}</a>
						</c:otherwise>
				    </c:choose>	
					</c:if>
					<c:if test="${userRole ne 'nonRegister' && userRole ne 'mobileSecure'}">
					<a href="#" class="o-grey-button o-usage-manage-features int-link" data-screenid="change features" title="Manage Features">${ManageFeaturesLabelKey}</a>
					</c:if>
				</div>
			</div>			
			
			<div>
				<input type="hidden" name="upgrageConfirmation" value="Upgrade Completed" id="upgrageConfirmation">
			</div>
	</div>
