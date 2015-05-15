<%--
  Default property editor for timestamp values.

  The following DSP parameters are supported:

  @param  resourcePrefix  Prefix of display string in resource file
  @param  omitTime        If set, only the date will be editable

  The following request-scoped variables are expected to be set:

  @param  mpv          A MappedPropertyView item for this view
  @param  formHandler  The form handler for the form that displays this view

  @version $Id: //product/AssetUI/version/9.1/src/web-apps/AssetManager/assetEditor/property/timestampEditor.jsp#2 $$Change: 534451 $
  @updated $DateTime: 2009/05/04 17:19:52 $$Author: rbarbier $
  --%>

<%@ taglib prefix="c"     uri="http://java.sun.com/jstl/core"                    %>
<%@ taglib prefix="dspel" uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<%@ taglib prefix="fmt"   uri="http://java.sun.com/jstl/fmt"                     %>

<dspel:page>

  <%-- Unpack DSP parameters --%>
  <dspel:getvalueof var="pResourcePrefix" param="resourcePrefix"/>
  <dspel:getvalueof var="pOmitTime"       param="omitTime"/>

  <%-- Unpack request-scoped parameters into page parameters --%>
  <c:set var="propertyView" value="${requestScope.mpv}"/>
  <c:set var="formHandler"  value="${requestScope.formHandler}"/>

  <dspel:importbean var="config"
                    bean="/atg/web/assetmanager/ConfigurationInfo"/>
  <fmt:setBundle basename="${config.resourceBundle}"/>

  <%-- Use the default resource prefix if necessary --%>
  <c:if test="${empty pResourcePrefix}">
    <c:set var="pResourcePrefix" value="timestampEditor"/>
  </c:if>

  <%-- This property is a timestamp unless the omitTime parameter is present --%>
  <c:set var="isTimestamp" value="${empty pOmitTime}"/>

  <%-- Determine the style for the input field.  An error style is used if
       there is an exception for the property. --%>
  <c:set var="inputClass" value="formTextField dateField"/>
  <c:if test="${not empty formHandler.propertyExceptions[propertyView.propertyName]}">
    <c:set var="inputClass" value="${inputClass} error"/>
  </c:if>

  <%-- Derive IDs for page elements --%>
  <c:set var="idSuffix" value="${requestScope.uniqueAssetID}${propertyView.uniqueId}"/>
  <c:set var="inputId"  value="propertyValue_${idSuffix}"/>
  <c:set var="iconId"   value="calendarIcon_${idSuffix}"/>

  <%-- Allow the input field size to be specified using an attribute. --%>
  <c:set var="inputSize" value=""/>
  <c:if test="${not empty propertyView.attributes.inputFieldSize}">
    <c:set var="inputSize" value="${propertyView.attributes.inputFieldSize}"/>
  </c:if>

  <%-- Get the date format for the request locale. --%>
  <fmt:message var="dateFormat" key="${pResourcePrefix}.dateFormat"/>

  <%-- Display an icon for popping up the calendar widget --%>
  <fmt:message var="imgAlt" key="${pResourcePrefix}.calendarIconText"/>
  <dspel:img id="${iconId}"
             page="${config.imageRoot}/calendar/calendar2_off.gif"
             alt="${imgAlt}" iclass="calIcon" border="0"/>

  <%-- Display the property value in a text input --%>
  <dspel:input type="text"
               id="${inputId}"
               iclass="${inputClass}"
               converter="date"
               nullable="true"
               date="${dateFormat}"
               size="${inputSize}"
               onpropertychange="formFieldModified()"
               oninput="markAssetModified()"
               bean="${propertyView.formHandlerProperty}"/>

  <script type="text/javascript">

    <%-- Configure the dynarch.com calendar widget so that it is displayed when
         the calendar icon is clicked. --%>
    Calendar.setup({
      button:      "<c:out value='${iconId}'/>",
      inputField:  "<c:out value='${inputId}'/>",
      ifFormat:    convertToDynarchDateFormat("<c:out value='${dateFormat}'/>"),
      firstDay:    <fmt:message key="timestampEditor.firstDay"/>,
      weekNumbers: false,
      onUpdate:    markAssetModified,
      step:        1,
      showsTime:   <c:out value="${isTimestamp}"/>,
      timeFormat:  "12",
      cache:       true
    });

    <%-- Indicate that the focus should be assigned to the text input when the
         editor is activated --%>
    registerOnActivate("<c:out value='${propertyView.uniqueId}'/>", function(){
      var elem = document.getElementById("<c:out value='${inputId}'/>");
      if (elem)
        elem.focus();
    });

  </script>

</dspel:page>
<%-- @version $Id: //product/AssetUI/version/9.1/src/web-apps/AssetManager/assetEditor/property/timestampEditor.jsp#2 $$Change: 534451 $--%>
