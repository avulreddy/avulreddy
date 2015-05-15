<dsp:page >
	<dsp:importbean bean="/atg/dynamo/droplet/Compare" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/atg/store/BMLConfiguration" />

<dsp:getvalueof id="orderTotalAmount"
					bean="ShoppingCart.current.PriceInfo.total" />
       <dsp:droplet name="ForEach">
			<dsp:param name="array" bean="ShoppingCart.current.paymentGroups" />
			<dsp:param name="elementName" value="paymentGroup" />
			<dsp:oparam name="output">
			<dsp:droplet name="Switch"> 
				 <dsp:param name="value" param="paymentGroup.paymentGroupClassType" />
				 <dsp:oparam name="billmeLater">
			     <dsp:getvalueof id="bmlPG" param="paymentGroup"></dsp:getvalueof>
			     </dsp:oparam>
			     <dsp:oparam name="default">
			      
			      </br>
			      <dsp:getvalueof id="pgAmount" param="paymentGroup.amount" />
			      <dsp:getvalueof id="orderTotalAmount"
									value="${orderTotalAmount-pgAmount}" />
			     </dsp:oparam>
			</dsp:droplet>
	</dsp:oparam>
</dsp:droplet>
<form action="" method="POST" id="postForm" name="postForm" >
<table>
	<tr>
		<td></td>
		<td>
			<dsp:getvalueof id="bmlUsertype" value="${bmlPG.referenceId}"/>
			<dsp:getvalueof id="coreUserStringValue" bean="BMLConfiguration.coreUserStringValue"></dsp:getvalueof>
			<dsp:getvalueof id="promoUserStringValue" bean="BMLConfiguration.promoUserStringValue"></dsp:getvalueof>
			
		<c:if test="${coreUserStringValue == bmlUsertype }">

			<input id="aMid" type="hidden" name="aMid" 
				value='<dsp:valueof bean="BMLConfiguration.coreMerchantId"/>' />
                </br>
			
			 
		</c:if> 
		<c:if test="${promoUserStringValue == bmlUsertype }">

			<input id="aMid" type="hidden" name="aMid" 
				value='<dsp:valueof bean="BMLConfiguration.promoMerchantId"/>' />
	
            </c:if> 
       </td>
	</tr>
	<input id="amt" type="hidden" name="amt" value='${orderTotalAmount}' />
	</td>

	<input id="bName" type="hidden" name="bName"
		value='${bmlPG.billingAddress.firstName}' />
	</td>
	<input id="bAddr1" type="hidden" name="bAddr1"
		value='${bmlPG.billingAddress.address1}' />
	</td>
	<input id="bAddr2" type="hidden" name="bAddr2"
		value='${bmlPG.billingAddress.address2}' />
	</td>
	<input id="bCity" type="hidden" name="bCity"
		value='${bmlPG.billingAddress.city}' />
	</td>
	<input id="bState" type="hidden" name="bState"
		value='${bmlPG.billingAddress.state}' />
	</td>
	<input id="bZip" type="hidden" name="bZip"
		value='${bmlPG.billingAddress.postalCode}' />
	</td>
	<input id="phone" type="hidden" name="phone"
		value='${bmlPG.billingAddress.phoneNumber}' />
	</td>
	<input id="email" type="hidden" name="email" value="bob.paycap@bml.com" />
	</td>
	<input id="iUrl" type="hidden" name="iUrl"
		value='<dsp:valueof bean="BMLConfiguration.returnUrl"/>' />
	</td>
	<input id="updUrl" type="hidden" name="updUrl"
		value='<dsp:valueof bean="BMLConfiguration.updateUrl"/>' />
	</td>
	<input id="mpUrl" type="hidden" name="mpUrl"
		value='<dsp:valueof bean="BMLConfiguration.otherPaymentUrl"/>' />
	</td>
	<input id="cssUrl" type="hidden" name="cssUrl" />
	</td>
	<input id="logoUrl" type="hidden" name="logoUrl" value="" />
	</td>
	<input id="mRefId" type="hidden" name="mRefId" value="" />
	</td>
</table>
</form>
 
<script type="text/javascript"> 
          //  alert('submitForm');
                var postForm = document.getElementById("postForm");
             
				//alert('url :'+ '<dsp:valueof bean="BMLConfiguration.postUrl"/>');
				postForm.action = '<dsp:valueof bean="BMLConfiguration.postUrl"/>';
                postForm.submit();
</script> 
</dsp:page>
