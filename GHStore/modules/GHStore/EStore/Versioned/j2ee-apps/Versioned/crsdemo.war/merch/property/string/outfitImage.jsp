<%@ page import="java.io.*,java.util.*" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jstl/fmt"  %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<%@ taglib prefix="dsp"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>
		
<dspel:page>

<table border="0" style="border-spacing:5px">          
    <dsp:droplet name="/atg/targeting/RepositoryLookup">
        <dsp:param name="id" bean="/atg/commerce/web/assetmanager/CategoryCatalogAssetFormHandler.value.repositoryId"/>
        <dsp:param name="itemDescriptor" value="outfit"/>
        <dsp:param bean="/atg/commerce/catalog/ProductCatalog" name="repository"/>
        <dsp:oparam name="output">
                <dsp:droplet name="/com/at/commerce/catalog/servlet/OutfitImage">
                    <dsp:param name="productID" bean="/atg/commerce/web/assetmanager/CategoryCatalogAssetFormHandler.value.repositoryId"/>
                    <dsp:param name="displayName" param="element.displayName"/>
                    <dsp:param name="siteId" param="element.siteId"/>
                    <dsp:oparam name="output">
                        <tr>
                        <td>
		                    	<img border="0" 
									src='<dsp:valueof param="productURL"/>'
									id="outfitImage">                                                       
                        </td>
                        </tr>
                    </dsp:oparam>
                </dsp:droplet>
       </dsp:oparam>
    </dsp:droplet>
</table>       
</dspel:page>
