<%--
  This gadget displays form input fields to be populated when creating a new billing address.

  Required parameters:
    None.

  Optional parameters:
    None.
--%>

<dsp:page>
  <dsp:importbean bean="/atg/store/order/purchase/BillingFormHandler"/>
  <dsp:importbean bean="/atg/userprofiling/Profile"/>
  <dsp:importbean bean="/atg/store/order/purchase/BMLBillingFormHandler"/>

    <ul class="atg_store_basicForm atg_store_addNewAddress">
      <%-- Include all necessary input fields. --%>
      
	  <div class="div_creditCard ${orderPaymentGroupMethod ne 'creditCard'?'hide':''}">
	      <dsp:include page="/global/gadgets/addressAddEdit.jsp">
	        <dsp:param name="formHandlerComponent" 
	                   value="/atg/store/order/purchase/BillingFormHandler.creditCardBillingAddress"/>
	        <dsp:param name="checkForRequiredFields" value="false"/>
	        <dsp:param name="hideNameFields" value="false"/>
	        <dsp:param name="preFillValues" value="true"/>
	        <dsp:param name="restrictionDroplet" value="/atg/store/droplet/BillingRestrictionsDroplet"/>
	      </dsp:include>
	 </div>
	
	 <div class="div_billmeLater ${orderPaymentGroupMethod ne 'billmeLater'?'hide':''}">
      <dsp:include page="/global/gadgets/addressAddEdit.jsp">
        <dsp:param name="formHandlerComponent" 
                   value="/atg/store/order/purchase/BMLBillingFormHandler.creditCardBillingAddress"/>
        <dsp:param name="checkForRequiredFields" value="false"/>
        <dsp:param name="hideNameFields" value="false"/>
        <dsp:param name="preFillValues" value="true"/>
        <dsp:param name="restrictionDroplet" value="/atg/store/droplet/BillingRestrictionsDroplet"/>
      </dsp:include>
	</div>
      <%-- If the shopper is transient (a guest shopper) we don't offer to save the address --%>
      <dsp:getvalueof var="isTransient" bean="Profile.transient"/>
      
      <%-- Save this address checkbox. Hide if the profile is transient --%>
      <li class="last option" style="${isTransient ? 'display: none;' : ''}">
        <label for="atg_store_addressAddSaveAddressInput"><fmt:message key="checkout_addressAdd.saveAddress"/></label>
        <dsp:input type="checkbox" name="atg_store_addressAddSaveAddressInput" id="atg_store_addressAddSaveAddressInput"
                   checked="${!isTransient}" bean="BillingFormHandler.saveBillingAddress"/>
        
      </li>
    </ul>
</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/11.1/Storefront/j2ee/store.war/checkout/gadgets/billingAddressAdd.jsp#2 $$Change: 883241 $--%>