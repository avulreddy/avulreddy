<%-- 
  This page displays all necessary elements to make proper billing for the cart the user is 
  checking out. First, this page applies all available store credits to the current order. If 
  there are no enough store credits to pay for the whole order, this page would include gadgets 
  to render a form with necessary input fields to select or create a credit card. Or it will just 
  display 'Move to Confirm' button otherwise.

  Required parameters:
    None.

  Optional parameters:
    None.
--%>

<dsp:page>
  <dsp:importbean bean="/atg/commerce/ShoppingCart" />
  <dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler" />
  <dsp:importbean bean="/atg/store/order/purchase/BillingFormHandler" />
  <dsp:importbean bean="/atg/store/order/purchase/CouponFormHandler"/>
  <dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet"/>
  <dsp:importbean bean="/atg/commerce/ShoppingCart"/>
  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
  <dsp:importbean bean="/atg/store/order/purchase/GiftCardBillingFormHandler" />
   <dsp:importbean bean="/atg/commerce/utils/droplet/FindModuleDroplet"/>
  
  <c:set var="stage" value="billing"/>
  
  <%-- Set title for submit button --%>
  <fmt:message var="submitFieldText" key="common.button.continueText"/>

  <crs:pageContainer divId="atg_store_cart" index="false" follow="false" 
                     levelNeeded="BILLING" redirectURL="../cart/cart.jsp"
                     bodyClass="atg_store_pageBilling atg_store_checkout atg_store_rightCol">
                     
    <jsp:attribute name="formErrorsRenderer">
      <%-- 
        Display error messages from Billing and Coupon form handlers 
        above the accessibility navigation  
      --%>     
      <dsp:include page="/checkout/gadgets/checkoutErrorMessages.jsp">
        <dsp:param name="formHandler" bean="BillingFormHandler"/>
        <dsp:param name="submitFieldText" value="${submitFieldText}"/>
      </dsp:include>
      <dsp:include page="/checkout/gadgets/checkoutErrorMessages.jsp">
        <dsp:param name="formHandler" bean="CouponFormHandler"/>
        <dsp:param name="submitFieldText" value="${submitFieldText}"/>
      </dsp:include>  
      <dsp:include page="/checkout/gadgets/checkoutErrorMessages.jsp">
        <dsp:param name="formHandler" bean="ProfileFormHandler"/>
      </dsp:include> 
    </jsp:attribute>
          
    <jsp:body>
   
      <%-- Apply available store credits to the order  --%>
      <%-- <dsp:setvalue bean="BillingFormHandler.applyStoreCreditsToOrder" value=""/> --%>

      <%-- Reprice the order, we should now its exact cost to render the checkout summary area. --%>
      <dsp:getvalueof var="formError" vartype="java.lang.String" bean="BillingFormHandler.formError"/>
      
      <%-- 
        If this parameter is 'true', a promotion has expired in the users cart before they have  
        placed the order. The user has then tried to place the order on the confirmation page, 
        where the promotion pipeline validation has subsequently invalidated the order. This means 
        that the order must be re-priced to refresh the cart.
      --%>
      <dsp:getvalueof var="expiredPromotion" vartype="java.lang.String" param="expiredPromotion"/> 
      
      <%-- 
        If this parameter is 'true', a coupon code has been added/edited on the
        confirmation page.
      --%>      
      <dsp:getvalueof var="couponCodeChanged" param="couponCodeChanged"/>
      
      <%-- Check, if there was an error in the component specified. --%>
      <c:if test='${(formError == "true") or (expiredPromotion == "true") 
                      or (couponCodeChanged == "true")}'>
        <%--
          This droplet executes 'repriceAndUpdateOrder' chain. It uses the current cart as input 
          order parameter for the chain in question.
    
          Output parameters:
            pipelineResult
              Result returned from the pipeline, if execution is successful.
            exception
              Exception thrown by the pipeline, if any.
    
          Open parameters:
            failure
              Rendered, if the pipeline has thrown an exception.
            successWithErrors
              Rendered, if pipeline successfully finished, but returned error.
            success
              Rendered, if pipeline successfully finished without errors returned.
              
          Input parameters:
            pricingOp
              Pricing operation to be performed on the current order.
        --%>
        <dsp:droplet name="RepriceOrderDroplet">
          <dsp:param name="pricingOp" value="ORDER_TOTAL"/>
        </dsp:droplet>
      </c:if>

      <dsp:form id="atg_store_checkoutBilling" formid="atg_store_checkoutBilling"
                action="${pageContext.request.requestURI}" method="post">
        
        <dsp:param name="skipCouponFormDeclaration" value="true"/>
        <fmt:message key="checkout_title.checkout" var="title"/>
        
        <crs:checkoutContainer currentStage="${stage}" title="${title}">
          
          <jsp:attribute name="formErrorsRenderer">
            
            <%-- Display error messages from Billing and Coupon form handlers. --%>            
            <dsp:include page="/checkout/gadgets/checkoutErrorMessages.jsp">
              <dsp:param name="formHandler" bean="BillingFormHandler"/>
              <dsp:param name="submitFieldText" value="${submitFieldText}"/>
            </dsp:include>
            <dsp:include page="/checkout/gadgets/checkoutErrorMessages.jsp">
              <dsp:param name="formHandler" bean="CouponFormHandler"/>
              <dsp:param name="submitFieldText" value="${submitFieldText}"/>
            </dsp:include>   
            <dsp:include page="/checkout/gadgets/checkoutErrorMessages.jsp">
              <dsp:param name="formHandler" bean="ProfileFormHandler"/>
            </dsp:include>        
            <dsp:include page="gadgets/checkoutErrorMessages.jsp">
              <dsp:param name="formHandler" bean="CommitOrderFormHandler"/>
            </dsp:include>
            <dsp:include page="gadgets/checkoutErrorMessages.jsp">
	          <dsp:param name="formHandler" bean="GiftCardBillingFormHandler"/>
            </dsp:include>

            <c:if test='${couponCodeChanged == "true"}'>
              <div class="errorMessage">
                <fmt:message key="checkout_billing.couponCodeChanged"/>
              </div>       
            </c:if>
            
          </jsp:attribute>
          <jsp:body>
       
       
       
       
          <dsp:getvalueof var="order" vartype="atg.commerce.Order" bean="ShoppingCart.current"/>
         	 <div id="atg_store_checkout" class="atg_store_main">
         	 	<c:set var="orderPaymentGroupMethod" value="" scope="request"/>
         	 	<c:set var="orderPaymentGroup" value="" scope="request"/>
         	 	<dsp:getvalueof var="paymentGroups" value="${order.paymentGroups}"/>
         	 	<c:forEach var="paymentGroup" items="${paymentGroups}">
         	 		<c:if test="${paymentGroup.paymentMethod ne 'giftCard'}">
         	 			<c:set var="orderPaymentGroupMethod" value="${paymentGroup.paymentMethod}" scope="request"/>
         	 			<c:set var="orderPaymentGroup" value="${paymentGroup}" scope="request"/>
         	 		</c:if>
         	 	</c:forEach>
         	 	<c:if test="${empty orderPaymentGroupMethod}">
         	 		<c:set var="orderPaymentGroupMethod" value="creditCard" scope="request"/>
         	 	</c:if>
	 			<dsp:droplet name="FindModuleDroplet">
					<dsp:param name="moduleName" value="CyberSource" />
					<dsp:oparam name="output">
						<dsp:getvalueof param="isModuleExist" var="cyberSourceExist" vartype="java.lang.boolean" />
						<c:if test="${cyberSourceExist}">
						
							<input type="radio" name="paymentType" value="creditCard"
								<c:if test="${orderPaymentGroupMethod eq 'creditCard'}">
									checked="checked"
								</c:if>
							 />
							 
							 <label for="payment_method_creditcard">Credit Card</label>
						</c:if>
					</dsp:oparam>
				</dsp:droplet>
         	 	
         	 	
         	 	<dsp:droplet name="FindModuleDroplet">
					<dsp:param name="moduleName" value="Paypal" />
					<dsp:oparam name="output">
						<dsp:getvalueof param="isModuleExist" var="paypalExist" vartype="java.lang.boolean" />
						<c:if test="${paypalExist}">
						
							<input type="radio" name="paymentType" value="payPal"
								<c:if test="${orderPaymentGroupMethod eq 'paypal'}">
									checked="checked"
								</c:if>
							 />
							 <label for="payment_method_paypal" class="paypal_label">PayPal</label>
						</c:if>
					</dsp:oparam>
				</dsp:droplet>
         	  	 
         	  	 
         	  	 <dsp:droplet name="FindModuleDroplet">
					<dsp:param name="moduleName" value="BML" />
					<dsp:oparam name="output">
						<dsp:getvalueof param="isModuleExist" var="bmlExist" vartype="java.lang.boolean" />
						<c:if test="${bmlExist}">
						
							<input type="radio" name="paymentType" value="billmeLater"
								<c:if test="${orderPaymentGroupMethod eq 'billmeLater'}">
									checked="checked"
								</c:if>
							 />
							<label for="payment_method_bml">BML</label> 
						</c:if>
					</dsp:oparam>
				</dsp:droplet>
  	   
	              <div id="creditcard" class="div_creditCard div_billmeLater ${orderPaymentGroupMethod eq 'creditCard' || orderPaymentGroupMethod eq 'billmeLater'?'':'hide'}">
		              <%-- Don't offer enter credit card's info if order's total is covered by store credits. --%>
		              <c:choose>
		                <c:when test="${order.priceInfo.total > order.storeCreditsAppliedTotal}">
		                  <%-- Store credits are not enough, render billing form. --%>
		                  <dsp:include page="gadgets/billingForm.jsp"/>
		                </c:when>
		                <c:otherwise>
		                  
		                  <%-- Order is paid by store credits, display its total and 'Continue' button. --%>
		                  <crs:messageContainer id="atg_store_zeroBalance">                     
		                    
		                    <h3>
		                      <%-- Display 'Order's total is 0' message. --%>
		                      <fmt:message key="checkout_billing.yourOrderTotal"/>
		                      <dsp:include page="/global/gadgets/formattedPrice.jsp">
		                        <dsp:param name="price" value="0"/>
		                      </dsp:include>
		                    </h3>
		                    
		                    <p><fmt:message key="checkout_billing.yourOrderTotalMessage"/></p>
		                    <dsp:input bean="BillingFormHandler.moveToConfirmSuccessURL" type="hidden" value="confirm.jsp"/>
		                    
		                    <%-- Go to Confirm button. --%>
		                    <span class="atg_store_basicButton">
		                      <fmt:message var="caption" key="common.button.continueText"/>
		                      <dsp:input bean="BillingFormHandler.billingWithStoreCredit" type="submit" value="${caption}"/>
		                    </span>                    
		                  </crs:messageContainer>     
		                </c:otherwise>
		              </c:choose>
	              </div>
	              <div id="paypal" class="div_payPal ${orderPaymentGroupMethod ne 'payPal' ? 'hide':'' }">
					  <dsp:importbean bean="/atg/commerce/utils/droplet/FindModuleDroplet"/>
					  <dsp:importbean bean="/atg/store/order/purchase/BillingFormHandler"/>
					  <dsp:importbean bean="/atg/commerce/order/purchase/PaypalBillingFormHandler"/>
					  <c:if test="${not empty paypalBillingAddress}">
						  <div class="atg_store_addressGroup">
							  <dl class="atg_store_billingAddresses atg_store_savedAddresses">
							    <dt>
			
							    </dt>
			
							    <%-- Address info --%>
							    <dd class="atg_store_addressSelect">
							       <dsp:include page="/global/util/displayAddress.jsp">
								      <dsp:param name="address" value="${paypalBillingAddress}"/>
								</dsp:include>
							    </dd>
							 </dl>
						 </div>
			      
			      		</c:if>
			      
						  <dsp:getvalueof param="paypalOrder.fromExpressPayPal" var="paypalVal"></dsp:getvalueof> 
						<span class="atg_store_basicButton" >	      
						      <dsp:input bean="BillingFormHandler.moveToConfirmSuccessURL" type="hidden" value="confirm.jsp"/>
						    </span>
			
					   <span class="atg_store_basicButton">
					   <dsp:input id="atg_store_checkout" type="submit" name="moveToPayPal"
					   bean="PaypalBillingFormHandler.normalCheckoutWithPayPal" value="PAYPAL_CHECKOUT"/>
					   <dsp:input bean="BillingFormHandler.moveToConfirmSuccessURL" type="hidden" value="confirm.jsp"/>
					 </span> 
				</div>
          </div>
          </jsp:body>
        </crs:checkoutContainer>
        
        <%-- Order Summary --%>
        <dsp:include page="/checkout/gadgets/checkoutOrderSummary.jsp">
          <dsp:param name="order" bean="ShoppingCart.current"/>
          <dsp:param name="currentStage" value="${stage}"/>
        </dsp:include>
        
      </dsp:form>
    </jsp:body>
  </crs:pageContainer>
</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/11.1/Storefront/j2ee/store.war/checkout/billing.jsp#1 $$Change: 875535 $--%>
