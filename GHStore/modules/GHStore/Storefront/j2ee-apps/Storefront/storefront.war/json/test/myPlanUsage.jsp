<%@ taglib uri="/WEB-INF/tld/verizon.tld" prefix="verizon" %>
<dsp:page>
<dsp:importbean bean="/com/myv/common/cq/MYVLabelConfiguration"/>
<dsp:getvalueof var="MYVLabelConfiguration" bean="MYVLabelConfiguration" />
 <dsp:getvalueof var="MYVLabelConfiguration" bean="MYVLabelConfiguration" vartype="com.myv.common.cq.MVMLabelConfiguration"/>
<dsp:importbean bean="/com/myv/common/cq/MYVHtmlConfiguration"/>
	<dsp:getvalueof var="MYVHtmlConfiguration" bean="MYVHtmlConfiguration" vartype="com.myv.common.cq.MYVHtmlConfiguration"/>

    <verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.myPlanlabelkey}" labelVar="labelObject" />
	<c:set var="myPlanlabelkey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.colorLegendLabelKey}" labelVar="labelObject" />
	<c:set var="colorLegendLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.viewUsageLabelKey}" labelVar="labelObject" />
	<c:set var="viewUsageLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.increaseLabelKey}" labelVar="labelObject" />
	<c:set var="increaseLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.upgradeLabelKey}" labelVar="labelObject" />
	<c:set var="upgradeLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usedLabelKey}" labelVar="labelObject" />
	<c:set var="usedLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.availableLabelKey}" labelVar="labelObject" />
	<c:set var="availableLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usageEstimatedMsgLabelKey}" labelVar="labelObject" />
	<c:set var="usageEstimatedMsgLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.hotspotLabelKey}" labelVar="labelObject" />
	<c:set var="hotspotLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.planManagementLabelKey}" labelVar="labelObject" />
	<c:set var="planManagementLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.manageDataLabelKey}" labelVar="labelObject" />
	<c:set var="manageDataLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.managePlansLabelKey}" labelVar="labelObject" />
	<c:set var="managePlansLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.daysLeftinUsageLabelKey}" labelVar="labelObject" />
	<c:set var="daysLeftinUsageLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.manageProductsLabelKey}" labelVar="labelObject" />
	<c:set var="manageProductsLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usageLabelKey}" labelVar="labelObject" />
	<c:set var="usageLabelKey" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.allUsageEstimatedHtml}" labelVar="labelObject" />
	<c:set var="allUsageEstimatedHtml" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.colorLegendToolTipHtml}" labelVar="labelObject" />
	<c:set var="colorLegendToolTipHtml" value="${labelObject.labelValue}"/>
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.sharedlabelKey}" labelVar="labelObject" />
	<c:set var="sharedlabelKey" value="${labelObject.labelValue}"/> 
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.bonusDatalabelKey}" labelVar="labelObject" />
	<c:set var="bonusDatalabelKey" value="${labelObject.labelValue}"/> 
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.oflabelKey}" labelVar="labelObject" />
	<c:set var="oflabelKey" value="${labelObject.labelValue}"/> 
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.usedLabelKey}" labelVar="labelObject" />
	<c:set var="usedLabelKey" value="${labelObject.labelValue}"/> 
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.internationalplanlabelKey}" labelVar="labelObject" />
	<c:set var="internationalplanlabelKey" value="${labelObject.labelValue}"/> 
	<verizon:label contentCategory="labels" contentKey="${MYVLabelConfiguration.chooselinelabelKey}" labelVar="labelObject" />
	<c:set var="chooselinelabelKey" value="${labelObject.labelValue}"/> 
	<dsp:getvalueof bean="/atg/userprofiling/Profile.vzwRole" var="userRole"/>


<section id="plansUsage" class="clr">
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
	<input type="hidden" name="paramSecurityKillSwitch" value="${paramSecurityKillSwitch}" id="paramSecurityKillSwitch">
	
	<script>
	var mdnObj= {
			<c:forEach items="${mtnToUUIDMap}" var="item" varStatus="loop">
		      '${item.key}' : '${item.value}' ${not loop.last ? ',' : ''}
		    </c:forEach>			
	}
	</script>
	
	<c:set var="requiredplanInfo" value="${myvUsageInfoBean.planUsageInfo}" scope="page" />	
	<c:set var="mdnusageAPIFailed" value="${myvUsageInfoBean.mdnusageAPIFailed}" scope="page" />
	<c:set var="retrievePlanUsageInfoAPIFalied" value="${requiredplanInfo.retrievePlanUsageInfoAPIFalied}" scope="page" />
	<c:set var="billCycleInfo" value="${myvUsageInfoBean.billCycleInfo}" scope="page" />
	<c:set var="hotspotUsageInfo" value="${requiredplanInfo.hotspotUsage}" scope="page" />
	<c:if test="${!requiredplanInfo.hideMTNList && userRole ne 'nonRegister' && userRole ne 'mobileSecure' && (fn:length(requiredplanInfo.mtnListMap)>1)}">
	<div class="o-usage-selector">
		<label>${chooselinelabelKey}</label>
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
	<div class="o-usage">
	
	<c:if test="${not mdnusageAPIFailed}">
		<h2>
			${myPlanlabelkey}
			<c:if test="${not empty requiredplanInfo.planName}">
				<a href="${myvUsageInfoBean.planNameURL}"> 
					<span> ${requiredplanInfo.planName} </span>
				</a>
			</c:if>
			</h2>					
			<c:set var="showused" value="true"/>
							
		<div class="o-usage-cycle clr">
			<c:if test="${not empty billCycleInfo.daysRemainingInNextCycle}">
				<p class="o-cycle-message">
					${billCycleInfo.daysRemainingInNextCycle}&nbsp;${daysLeftinUsageLabelKey}
					<verizon:html contentCategory="HTML" contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}"/>
				</p>					
			</c:if>
				<p class="o-color-legend">
					${colorLegendLabelKey}
					<span class="o-icon-question tooltip" data-tooltip='${colorLegendToolTipHtml}'></span>
				</p>
				<a href="${myvUsageInfoBean.viewUsageDetailsURL}" class="o-button" title="View Usage Details">${viewUsageLabelKey}</a>
		</div>
		
		<div class="o-usage-meters">
			<c:forEach items="${requiredplanInfo.usageMap}" var="entry" varStatus="count">
				<c:set var="bar" value="${requiredplanInfo.usageMap[entry.key]}" />
					<c:if test="${bar.hideUsageBar}">
						<c:set var="status" value="${status + 1}" />
					</c:if>
					<c:set var="barType" value="${bar.barType}" />
					<c:if test="${not bar.hideUsageBar}">
						<div class="o-usage-meter-block">
							<c:choose>									
							<c:when test="${bar.displayBar}">
									<div class="o-usage-meter">
										<div class="o-usage-data-meter-text">
										${bar.barType}
											<span> - ${bar.totalAllowed} <abbr title="Gigabytes">${bar.unitOfMeasure}</abbr>
											</span>
											<c:if test="${bar.shared}">
											    ${sharedLabel}
											</c:if>
										</div>
										<h4>
										<c:if test="${ bar.hasBonus}">
											
											<span class="o-break">
												<c:if test="${not empty bar.totalBonusAllowed and not empty bar.unitOfMeasure}">
												<span class="o-greenHighlight">
													+ ${bar.totalBonusAllowed}<abbr title='Gigabytes'>${bar.unitOfMeasure}</abbr> ${bonusDatalabelKey}
												</span>
												</c:if>
											</span>
										</c:if>
										<c:if test="${ bar.hasOverage}">
												<c:if test="${not empty bar.overAgequantity and not empty bar.overAgeUnit}">
							                        + ${bar.totalUsed - bar.totalAllowed} <abbr title='Gigabytes'>${bar.overAgeUnit}</abbr> ${overageAlertLabel} 
							                          <span class='o-icon-question tooltip'
																data-tooltip='${overageAlertToolTipHtml}'></span>
												</c:if>
											
										</c:if>
										</h4>
										<div class="o-gauge" data-used="${bar.totalUsed}" 
 											data-available="${bar.totalAllowed}"
											data-measure="${bar.unitOfMeasure}" data-bartype="${barType}">
										</div>
										<%--<div class="o-meter-innerText">
											${bar.totalUsed} ${bar.unitOfMeasure}
											<span>used</span>
										</div> --%>
										<c:if test="${ bar.showUpgeadeLink}">
											<div class="o-usage-upgrade">
												<%--<p class="o-usage-overage-msg">+${bar.overAgequantity} ${bar.overAgeUnit} Overage
												</p> --%>
												<a href="${myvUsageInfoBean.oneClickUpgradeURL}" class="o-upgrade-data" title="Upgrade Data">
													<c:choose>
														<c:when test="${fn:containsIgnoreCase(barType, 'data')  }">
															${increaseLabelKey}
														</c:when>
														<c:otherwise>${upgradeLabelKey}</c:otherwise>
													</c:choose>
													&nbsp;${barType}
												</a>
											</div>
										</c:if>
										<c:if test="${showused}">
											<c:set var="showused" value="false" />
												<div class="o-usage-meters-toggles clr">
													<button class="o-usage-toggle-used active-toggle">${usedLabelKey}</button>
													<button class="o-usage-toggle-avail">${availableLabelKey}</button>
												</div>
										</c:if>
										</div>
									</c:when>
									<c:otherwise>
									
										<div class="o-usage-textDetail-inner o-usage-textDetail-inner-left">
											<div class="o-usage-data-meter-text">
												${barType} <span>- ${bar.allowanceType}</span>
											</div>
											<div class="o-usage-data-meter-number">${bar.totalUsed}
												&nbsp;${bar.unitOfMeasure}&nbsp;${usedLabelKey}
											</div>
										</div>
										
									</c:otherwise>
							</c:choose>
							
							</div>
						</c:if>
			</c:forEach>
			<c:if test="${not hotspotUsageInfo.hideHotSpotUsage}">
			<c:choose>
				<c:when test="${not hotspotUsageInfo.hasOverage }">
					<div class="o-usage-hotspot">
						<span class="o-usage-hotspot-header"> <em>${hotspotLabelKey}</em>
							${usageLabelKey}
						</span>
						<c:if test="${ not empty hotspotUsageInfo.unitOfMeasure and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
							<span class="o-usage-hotspot-details">
								${hotspotUsageInfo.totalUsed}
								${hotspotUsageInfo.unitOfMeasure} ${oflabelKey}
								${hotspotUsageInfo.totalAllowed}
								${hotspotUsageInfo.unitOfMeasure} ${usedLabelKey} <verizon:html contentCategory="HTML" contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}"/>
							</span>
						</c:if>
					</div>
				</c:when>
				<c:otherwise>
					<div class="o-usage-hotspot o-usage-hotspot-overage">
						<span class="o-usage-hotspot-header"> <em>${hotspotLabelKey}</em>
							${usageLabelKey}
						</span>
						<c:if test="${ not empty hotspotUsageInfo.overAgeUnit and not empty hotspotUsageInfo.totalUsed and not empty hotspotUsageInfo.totalAllowed}">
							<span class="o-usage-hotspot-details">
								${hotspotUsageInfo.totalUsed}
								${hotspotUsageInfo.overAgeUnit} ${oflabelKey}
								${hotspotUsageInfo.totalAllowed}
								${hotspotUsageInfo.overAgeUnit} ${usedLabelKey} <verizon:html contentCategory="HTML" contentKey="${MYVHtmlConfiguration.dayremainToolTipKey}"/>
							</span>
						</c:if>
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
		</div>
		<div class="o-usage-meter-note">${usageEstimatedMsgLabelKey}</div>
					
		<div class="o-plan-manage clr">
			<div class="o-left">
			<h2>
				<a href="${myvUsageInfoBean.planManagementURL}" title="Plan Management">${planManagementLabelKey}</a>
			</h2>
			<%--<c:choose>
				<c:when test="${requiredplanInfo.alpAndMe}">
					<a class="o-grey-button" title="Manage Data" href="${myvUsageInfoBean.changePlanURL}"> Manage Data </a>
				</c:when>
				<c:otherwise>
					<a class="o-grey-button" title="Change Plan" href="${myvUsageInfoBean.changePlanURL}"> Change Plan </a>
				</c:otherwise>
			</c:choose>
				<a class="o-grey-button" title="Manage Products and Apps" href="${myvUsageInfoBean.myProductsandAppsURL}">Manage Products and Apps</a>--%>
			<c:if test="${ userRole ne 'mobileSecure' }">	
			<c:choose>
				<c:when test="${requiredplanInfo.alpAndMe}">							
					<a href="{myvUsageInfoBean.changePlanURL" class="o-grey-button o-usage-manage-data" title="Manage Data">${manageDataLabelKey}</a>
				</c:when>
				<c:otherwise>								
					<a href="{myvUsageInfoBean.changePlanURL" class="o-grey-button o-usage-manage-data" title="Manage Data">${manageDataLabelKey}</a>
				</c:otherwise>
			</c:choose>
			</c:if>	
			<c:if test="${userRole ne 'nonRegister' && userRole ne 'mobileSecure'}">
			<a href="${myvUsageInfoBean.myProductsandAppsURL}" class="o-grey-button o-usage-manage-features" title="Manage Features">${manageProductsLabelKey}</a>
			</c:if>
			<!-- ${myvUsageInfoBean.myProductsandAppsURL} -->
			</div>
		</div>			
				<div class="o-footlink-wrap clr">
					<c:if test="${requiredplanInfo.hasGlobalUsage}">
					<a class="o-caret-link"
						href="${myvUsageInfoBean.manageglobalandinternationalplanlinkURL}"
						title="Add Global and International Plans">${managePlansLabelKey}</a>
					</c:if>
				</div>			
			<c:if test="${CampaignResponse.size()>0}">
			<c:if test="${(CampaignResponse['PlanCarousel'] ne null)}">
			<c:forEach items="${CampaignResponse['PlanCarousel']}"  var="campaignList">			
			<div class="o-plan-analysis">		
				${campaignList.htmlContent}
			</div>
			</c:forEach>
			</c:if>
			</c:if>
		</c:if>
		</div>
	</div>
	
	<div>
		<input type="hidden" name="upgrageConfirmation" value="Upgrade Completed" id="upgrageConfirmation">
	</div>
	</section>
	
	
</dsp:page>
