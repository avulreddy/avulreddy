<%@ page import="java.io.*,java.util.*" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jstl/fmt"  %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<%@ taglib prefix="dsp"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

		<script type="text/javascript">
			function viewImage(image, id, colors, name) {
				//alert(image.src);
				url = "/smbcc/merch/property/string/viewProduct.jsp?img=" + image.src + "&id=" + id + "&colors=" + colors + "&name=" + name;
				//alert(url);
				window.open(url,'richFXImage','width=505,height=740');
			}
		</script>
		
<dspel:page>

<table border="0" style="border-spacing:5px">
    <dspel:setvalue bean="/com/at/commerce/catalog/servlet/ProductImages.productID"  beanvalue="/atg/commerce/web/assetmanager/ProdSkuPriceListFormHandler.value.repositoryId"/>          
    <dsp:droplet name="/atg/targeting/RepositoryLookup">
        <dsp:param name="id" bean="/com/at/commerce/catalog/servlet/ProductImages.productID"/>
        <dsp:param name="itemDescriptor" value="product"/>
        <dsp:param bean="/atg/commerce/catalog/ProductCatalog" name="repository"/>
        <dsp:oparam name="output">
                <dsp:droplet name="/com/at/commerce/catalog/servlet/ProductImages">
                    <dsp:param name="productID" bean="/com/at/commerce/catalog/servlet/ProductImages.productID"/>
                    <dsp:param name="skus" param="element.childSKUs"/>
                    <dsp:param name="siteId" param="element.siteId"/>
                    <dsp:param name="defaultColor" param="element.defaultColor"/>
                    <dsp:oparam name="new_row_start">
                        <tr>
                    </dsp:oparam>
                    <dsp:oparam name="output">
                        <td>
		                    	<img border="0"  
									src='<dsp:valueof param="productURL"/>'
									onclick="javascript:viewImage(this, '<dsp:valueof param="productID"/>', '<dsp:valueof param="productColors"/>', '<dsp:valueof param="element.displayName"/>');"												
									id="productImage" alt='<dsp:valueof param="colorName"/>'>                                                       
                        </td>
                    </dsp:oparam>
                    <dsp:oparam name="new_row_end">
                        </tr>
                    </dsp:oparam>
                </dsp:droplet>
       </dsp:oparam>
    </dsp:droplet>
</table>       
</dspel:page>
