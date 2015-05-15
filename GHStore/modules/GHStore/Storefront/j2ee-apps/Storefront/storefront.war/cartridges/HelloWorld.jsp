<dsp:page>
    <dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
    <dsp:droplet name="InvokeAssembler">
      <dsp:param name="contentCollection" value="/content/Web/Web Browse Pages/HelloWorld"/>
      <dsp:oparam name="output">
        <dsp:getvalueof var="HelloContent" 
            vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
      </dsp:oparam>
    </dsp:droplet>
  
  <c:if test="${not empty HelloContent}">
    <dsp:renderContentItem contentItem="${HelloContent}" />
  </c:if>
</dsp:page>