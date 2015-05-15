<dsp:page>
	<dsp:droplet name="/atg/commerce/catalog/ProductLookup">
	    <dsp:param name="id"  param="ratingProductId"/>
	    <dsp:param bean="/OriginatingRequest.requestLocale.localeString" name="repositoryKey"/>
	    <dsp:setvalue param="product" paramvalue="element"/>
	    <dsp:oparam name="output">
	    	<dsp:getvalueof param="product.rating" var="ratingVal"/>
	    	<c:choose>
      			<c:when test="${not empty ratingVal}">
	   		    	<fmt:formatNumber value="${ratingVal}" type="number" pattern="#.#" var="formatedRating"/>
	    			<img src="../bazaarvoice/images/stars/rating-${fn:replace(formatedRating,'.', '_')}.gif" />
	    		</c:when>
	    	    <c:otherwise>
	    	    	<img src="../bazaarvoice/images/stars/rating-0_0.gif" />
      			</c:otherwise>
			</c:choose>
	    </dsp:oparam>
    </dsp:droplet>
</dsp:page>