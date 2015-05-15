<%@ page import="java.io.*,java.util.*" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jstl/fmt"  %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<%@ taglib prefix="dsp"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>

<table border="0" style="border-spacing:5px">          
    <dsp:droplet name="/atg/targeting/RepositoryLookup">
        <dsp:param name="id" bean="/atg/web/assetmanager/editor/AssetRepositoryFormHandler.value.repositoryId"/>
        <dsp:param name="itemDescriptor" value="color"/>
        <dsp:param bean="/atg/commerce/catalog/ProductCatalog" name="repository"/>
        <dsp:oparam name="output">
	        <dsp:oparam name="output">
				<img title='<dsp:valueof param="element.colorName"/>' id='<dsp:valueof param="element.colorCode"/>' alt='<dsp:valueof param="element.colorName"/>' src='<dsp:valueof bean="/com/at/commerce/catalog/servlet/OutfitImage.annOutfitUrl"/><dsp:valueof param="element.colorCode"/>.jpg' tooltip='<dsp:valueof param="element.colorName"/>'/>
	       </dsp:oparam>
       </dsp:oparam>
    </dsp:droplet>
</table>       
          
</dspel:page>
