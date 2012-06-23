<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta Name="layout" content="payment" />
    <title>Edit Payment</title>
</head>
<body>

<h3 align="left">Online Payments and Purchases - Preview</h3>
      <g:if test="${flash.message}">
      <div class="errors">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${cmd}">
      <div class="errors">
      <g:renderErrors bean="${cmd}" as="list" />
      </div>
      </g:hasErrors>
<p>
  Please review the information below for accuracy, when you are done you may submit the information by using the payment button below. <b>Please note that your payment has not been submitted yet. We ask that you review your information before submitting it to us to assure timely processing of your payment.</b>
</p>
<table border="0" cellspacing="0" cellpadding="0" style="width:100%">
  <tr>
    <td style="width:50%;text-align:right;" valign="top">
      <b>Name : &nbsp</b>
    </td>
    <td style="width:50%;text-align:left;" valign="top">
        ${cmd.firstName} ${cmd.middleName} ${cmd.lastName}
    </td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top">
      <b>Address : &nbsp</b>
    </td>
    <td style="width:50%;text-align:left;" valign="top">
        ${cmd.address1} <br />
        <g:if test="${cmd.address2}">
          ${cmd.address2} <br />
        </g:if>
        ${cmd.city}, ${cmd.state} ${cmd.zip}<br />
        ${cmd.country}
    </td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top"><b>Home Phone Number : &nbsp</b></td>
    <td style="width:50%;text-align:left;" valign="top"> ${cmd.homePhone} </td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top"><b>Daytime Phone Number : &nbsp</b></td>
    <td style="width:50%;text-align:left;" valign="top"> ${cmd.workPhone} </td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top"><b>E-mail : &nbsp</b></td>
    <td style="width:50%;text-align:left;" valign="top"> ${cmd.email} </td>
</tr>

  <tr>
    <td style="width:50%;text-align:right;" valign="top"><b>Routing Number : &nbsp</b></td>
    <td style="width:50%;text-align:left;" valign="top"> Last Four digits ${cmd.routingNum[(cmd.routingNum.size()-4)..(cmd.routingNum.size()-1)]}</td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top"><b>Financial Account Number : &nbsp</b></td>
    <td style="width:50%;text-align:left;" valign="top"> Last Four digits ${cmd.accountNum[(cmd.accountNum.size()-4)..(cmd.accountNum.size()-1)]} </td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top"><b>Account Type : &nbsp</b></td>
    <td style="width:50%;text-align:left;" valign="top"> ${PaymentController.actTypList[cmd.accountType]}          </td>
  </tr>
  <tr>
    <td colspan="2" style="width:100%;text-align:center;">
      <form action="changepersonal" method="post">
        <input type="hidden" Name="lastName" id="lastName" value="${cmd.lastName}" />
        <input type="hidden" Name="firstName" id="firstName" value="${cmd.firstName}" />
        <input type="hidden" Name="middleName" id="middleName" value="${cmd.middleName}" />
        <input type="hidden" Name="homePhone" id="homePhone" value="${cmd.homePhone}" />
        <input type="hidden" Name="workPhone" id="workPhone" value="${cmd.workPhone}" />
        <input type="hidden" Name="email" id="email" value="${cmd.email}" />
        <input type="hidden" Name="address1" id="address1" value="${cmd.address1}" />
        <input type="hidden" Name="address2" id="address2" value="${cmd.address2}" />
        <input type="hidden" Name="city" id="city" value="${cmd.city}" />
        <input type="hidden" Name="state" id="state" value="${cmd.state}" />
        <input type="hidden" Name="zip" id="zip" value="${cmd.zip}" />
        <input type="hidden" Name="country" id="country" value="${cmd.country}" />
        <input type="hidden" Name="routingNum" id="routingNum" value="${cmd.routingNum}" />
        <input type="hidden" Name="routingNum2" id="routingNum2" value="${cmd.routingNum2}" />
        <input type="hidden" Name="accountNum" id="accountNum" value="${cmd.accountNum}" />
        <input type="hidden" Name="accountNum2" id="accountNum2" value="${cmd.accountNum2}" />
        <input type="hidden" Name="accountType" id="accountType" value="${cmd.accountType}" />
        <input type="hidden" Name="edit" value="true"/>
        <input type="submit" Name="submit" id="submit" class="button" value="Change/Correct Personal Information" />
      </form>
    </td>
  </tr>
  <tr>
    <td style="width:100%;" valign="top" colspan="2">
      <h4>Payments : &nbsp</h4>
      <b>Note:</b> As a security feature, if you change any items in your cart you must provide your personal and payment information again.<br /><br />
        <table style="width:100%;" border="0">
        <% def total=0 %>
        <g:each var="line" in="${session.payment?.lines}">
          <% 
          	total += line.amount	
          	def bal = Balance.findByBalanceNum(line.balanceNum)
          %>
          <tr>
            <td style="width:60%;" colspan="2"><b>${BillType.get(line?.billTypeId).name}</b></td>
            <td style="width:20%;"> <g:formatNumber number="${line.amount}" format="\$###,##0.00" /></td>
            <td style="width:20%;"><a href="<g:createLink action="removeitem" id="${line.id}" />">Remove Item</a></td>
          </tr>
	      <g:if test="${bal}">
		      <tr><td style="width:100%;" colspan="4">Item Details:<br /></td></tr>
		      <tr>
		        <td style="width:20%;">&nbsp;</td>
		        <td style="width:80%;" colspan="3"><br />
		          <table border="0" style="width:100%;">
		            <tr>
		              <td style="width:25%;text-align:right;" valign="top"><b>Account :</b></td>
		              <td style="width:75%;text-align:left;">${line.account} ${(line.billNum?:'')}</td>
		            </tr>
		            <tr>
		              <td style="width:25%;text-align:right;" valign="top"><b>Name on Account :</b></td>
		              <td style="width:75%;text-align:left;">${bal.displayName}</td>
		            </tr>
		            <tr>
		              <td style="width:25%;text-align:right;" valign="top"><b>Address :</b></td>
		              <td style="width:75%;text-align:left;">${bal.address1}<br />${bal.address2}<br />${bal.address3}</td>
		            </tr>
		            <tr>
		              <td style="width:25%;text-align:right;" valign="top"><b>Balance Due :</b></td>
		              <td style="width:75%;text-align:left;" valign="top">
		                <b>
		                  <g:if test="${bal.credit == 'CR'}">Credit to this account of &nbsp;</g:if>
		                  <g:formatNumber number="${bal.balance}" format="\$###,##0.00" />
		                </b>
		              </td>
		            </tr>
		            <tr><td/><td/></tr>
		           </table>
		        </td>
		      </tr>
	      </g:if>
	      <g:else><%-- no bal --%>
		      <tr><td>Item Details:</td><td style="width:35%;text-align:center;" valign="top">&nbsp;<b>Account :</b>${line.account} ${(line.billNum?:'')}</td><td/></tr>
	      </g:else>
        </g:each>
        </table>
      <br /><br />
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width:100%;text-align:center;">
      THE AMOUNT SHOWN IS THE TOTAL OF YOUR TRANSACTIONS. YOUR BANK STATEMENT WILL SHOW SEPARATE WITHDRAWALS FOR EACH ACCOUNT THAT YOU PAID.<br />
    </td>
  </tr>
  <tr>
    <td style="width:50%;text-align:right;" valign="top">
      <b>Total Amount :  &nbsp</b>
    </td>
    <td style="width:50%;text-align:left;" valign="top">
      <g:formatNumber number="${total}" format="\$###,##0.00" />
    </td>
  </tr>
  <tr><td colspan="2" style="width:100%;text-align:left;"><h4>Payment Agreement:</h4></td></tr>
  <tr>
    <td style="width:100%;text-align:center;" colspan="2" valign="top">
      <b><p style="color:#FF0000">
        By submitting my payment as an electronic check, I authorize the Spotsylvania County Treasurer's Office, 
        to withdraw the said amount from the financial institution account that I have provided. Furthermore, 
        I affirm and attest to the fact that the person(s) authorizing this withdrawal is/are authorized to do so. 
        I understand that a $50.00 service fee will be charged if the full amount of this payment is not available for withdrawal.
      </p></b>
      <g:form action="submitpayment" method="post" Name="finalsubmit" id="finalsubmit"  useToken="true" >
          <input type="hidden" Name="lastName" id="lastName" value="${cmd.lastName}" />
          <input type="hidden" Name="firstName" id="firstName" value="${cmd.firstName}" />
          <input type="hidden" Name="middleName" id="middleName" value="${cmd.middleName}" />
          <input type="hidden" Name="homePhone" id="homePhone" value="${cmd.homePhone}" />
          <input type="hidden" Name="workPhone" id="workPhone" value="${cmd.workPhone}" />
          <input type="hidden" Name="email" id="email" value="${cmd.email}" />
          <input type="hidden" Name="address1" id="address1" value="${cmd.address1}" />
          <input type="hidden" Name="address2" id="address2" value="${cmd.address2}" />
          <input type="hidden" Name="city" id="city" value="${cmd.city}" />
          <input type="hidden" Name="state" id="state" value="${cmd.state}" />
          <input type="hidden" Name="zip" id="zip" value="${cmd.zip}" />
          <input type="hidden" Name="country" id="country" value="${cmd.country}" />
          <input type="hidden" Name="routingNum" id="routingNum" value="${cmd.routingNum}" />
          <input type="hidden" Name="routingNum2" id="routingNum2" value="${cmd.routingNum2}" />
          <input type="hidden" Name="accountNum2" id="accountNum2" value="${cmd.accountNum2}" />
          <input type="hidden" Name="accountNum" id="accountNum" value="${cmd.accountNum}" />
          <input type="hidden" Name="accountType" id="accountType" value="${cmd.accountType}" />
          If this information is correct you may <g:submitButton name="update" value="Agree to the terms above and submit payment" class="button" onclick="hide('submit');"/>
          or use the buttons above to correct your information.<br />
          <b>Only press the Agree button once, as pressing it twice may result in a duplicate payment.</b>
      </g:form>
    </td>
  </tr>
</table>
<br /><br />

</body>
</html>

