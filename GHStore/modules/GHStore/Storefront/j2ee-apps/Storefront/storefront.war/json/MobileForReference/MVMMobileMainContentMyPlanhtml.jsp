<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />	

<dsp:include page="/mobile/nda/usage/myPlanUsage.jsp">
<dsp:param name="contentItem" value="${contentItem}"/>
</dsp:include>

</dsp:page>