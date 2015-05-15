<%--
  This gadget renders payment info from a payment group. Payment group passed should be a credit card.

  Required parameters:
    paymentGroup
      Payment group to be displayed.

  Optional parameters:
    isCurrent
      Flags, if payment group specified belongs to current shopping cart, or not.
    isExpressCheckout
      Flags, if this gadget is a part of express checkout Confirmation page.
--%>

<dsp:page>
  <dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler"/>

  <dsp:getvalueof var="contextroot" bean="/OriginatingRequest.contextPath"/>
  <dsp:getvalueof var="isCurrent" param="isCurrent"/>
  <dsp:getvalueof var="isExpressCheckout" param="isExpressCheckout"/>

  <dl class="atg_store_groupBillingAddress">
    <dt>
     
    </dt>
    <dd>	
    </dd>
    </dl>
    <dl class="atg_store_groupPayment">
        
          
          <c:if test="${isCurrent}">
          <dt>
	     Gift Card <fmt:message key="checkout_confirmPaymentOptions.payment"/><fmt:message key="common.labelSeparator"/>
	     <dsp:valueof  param="paymentGroup.giftCardNumber" />
          </dt>
            <dsp:a page="/checkout/billing.jsp" title="">
              <span><fmt:message key="common.button.editText" /></span>
            </dsp:a>
          </c:if>
    
    </dd>
  </dl>
 
</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/11.1/Storefront/j2ee/store.war/checkout/gadgets/paymentGroupRenderer.jsp#1 $$Change: 875535 $--%>