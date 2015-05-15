<%@ page import="java.io.*,java.util.*" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt"     uri="http://java.sun.com/jstl/fmt"  %>
<%@ taglib prefix="dspel"   uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<%@ taglib prefix="dsp"   uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" %>

<dspel:page>
                                
	<style>
		.ie6png {
			behavior: url(/smbcc/css/iepngfix.htc);
		}
		</style>
		<link href="/smbcc/css/ie-all.css" rel="stylesheet" />
		<style>
		.filterTools .sortSize .jScrollPaneContainer {
			left: 0 !important;
		}
	</style>

<html>
<title><dsp:valueof param="name"/></title>
<body>	
<table cellspacing="0">
<tr>
<td>
	<div class="grid g-2col">
	<div class="gu gu-first">
	<div class="hero" id="MainProductImage">
    	<img height="600"
			border="0" width="488" 
			src='<dsp:valueof param="img"/>'
			name="productImage" id="productImage"
			class="RICHFX:imageOverlayCC(<dsp:valueof param="id"/>,,theViews,<dsp:valueof param="colors"/>,,,,1,,,,1,,,,,,newColorText_0,updateSwatchText_0) RICHFX:imageZoom(,,visible,10,)">
			<span id="RICHFXViewerLoadingAnimation" class="RICHFXViewerLoadingAnimation" style="display: block;"></span>
	</div>    
	</div>    
	</div>    
</td>
</tr>
<tr>
<td height="50">				
    <fieldset class="fs-color">
        <div class="legend"><h4 class="text-replace">Select your color</h4></div>
        
            
            <div id="246133" class="rfxswatch"></div>
        
        
            <span class="label js-multiSelectLabel"
                  data-bindTo="#SelectColor"><div id="newColorText_0">
            </div></span> 
    </fieldset>
								                                                    
</td>
</tr>
</table>

<script src="http://anntaylor2.preview.richfx.com/project/viewers/base/rfxloader?rfx_embed=anntaylor"></script>
<script src="http://cts.channelintelligence.com/7392190_landing.js"></script>

<script>
	RICHFX_INTERFACE_LOADER = 1;
	RICHFX.mediaReload();
</script>

</body>
</html>



</dspel:page>
