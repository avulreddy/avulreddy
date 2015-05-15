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
                <dsp:droplet name="/com/at/commerce/catalog/droplet/ATColorRGBDroplet">
					<dsp:param name="rgb" param="element.rgb"/>
					<dsp:oparam name="output">
					<dsp:getvalueof id="swatchId" param="element.colorCode" idtype="java.lang.String">
						<div class="" style="background-color:rgb(<dsp:valueof param="red"/>, <dsp:valueof param="green"/>, <dsp:valueof param="blue"/>); width:17px">
							&nbsp;
						</div>
					</dsp:getvalueof>

					</dsp:oparam>
                </dsp:droplet>
       </dsp:oparam>
    </dsp:droplet>
</table>       
</dspel:page>
