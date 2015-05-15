<%@ taglib uri="/WEB-INF/tld/verizon.tld" prefix="verizon"%>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="application/json;charset=UTF-8"%>
<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/myv/common/user/MYVUserInfo" />
	<dsp:importbean var="MYVLabelConfiguration"
		bean="/com/myv/common/cq/MYVLabelConfiguration" />
	<dsp:importbean bean="/com/myv/common/cq/MYVHTMLConfiguration"
		var="MYVHTMLConfiguration" />

	<dsp:getvalueof var="contentItem"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="myvUserInfoBean" bean="MYVUserInfo" />

	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.accountNumberLabelKey}"
		labelVar="labelObject" />
	<c:set var="accountNumberLabelKey" value="${labelObject.labelValue}" />
	<verizon:label contentCategory="labels"
		contentKey="${MYVLabelConfiguration.accountOwnerLabelKey}"
		labelVar="labelObject" />
	<c:set var="accountOwnerLabelKey" value="${labelObject.labelValue}" />

	<json:object name="account" prettyPrint="true">
		<json:property name="objectName">Account</json:property>
		<json:property name="accountLabelKey">${accountNumberLabelKey}</json:property>
		<json:property name="accountLabelValue">286186548-00001</json:property>
		<json:property name="accountOwnerLabelKey">${accountOwnerLabelKey}</json:property>
		<json:property name="accountOwnerLabelValue">
			<verizon:html contentCategory="HTML"
				contentKey="${MYVHTMLConfiguration.accountInfotooltipKey}" />
		</json:property>
		<json:object name="myreward">
			<json:array name="myRewards">
				<c:forEach items="${contentItem.MVMTabletMyRewards}"
					var="smartRewards" varStatus="counter">
					<dsp:renderContentItem contentItem="${smartRewards}" />
				</c:forEach>
			</json:array>
		</json:object>
	</json:object>

</dsp:page>
