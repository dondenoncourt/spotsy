<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="payment" />
    <title>Edit Payment</title>
  </head>
  <body>
    <div style="text-align:right;">
    | <a href="${createLink(controller:'payment', action:'viewcart')}">Shopping Cart</a> &nbsp;
    </div>
    <h3>Online Payments and Purchases</h3>
    <g:if test="${flash.message}">
         <div class="errors">${flash.message}</div>
    </g:if>

<% def total = 0 %> <%-- may not need as there is no looping (yet) through cart items --%>
    <table style="width:100%;" border="0">
      <form action="view" method="post">
        <g:each var="line" in="${pay?.lines}">
          <% 
          	total += line?.amount	
          	def bal = Balance.findByBalanceNum(line.balanceNum)
          %>
          <tr>
            <td style="width:60%;" colspan="2">
              <b>${BillType.get(line?.billTypeId).name}</b>
            </td>
            <td style="width:20%;">
          <g:formatNumber number="${line?.amount}" format="\$###,##0.00" />
        </td>
        <td style="width:20%;">
          <a href="<g:createLink action="removeitem" id="${line.id}" />">Remove Item</a>
        </td>
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
  <tr>
    <td style="width:20%;">&nbsp;</td>
    <td style="width:80%;" colspan="3"></td>
  </tr>
  <tr>
    <td style="width:100%;" colspan="4">
      <hr />
    </td>
  </tr>
  <tr>
    <td style="width:60%;" colspan="2">
      THE AMOUNT SHOWN IS THE TOTAL OF YOUR TRANSACTIONS. YOUR BANK STATEMENT WILL SHOW SEPARATE WITHDRAWALS FOR EACH ACCOUNT THAT YOU PAID.
    </td>
    <td style="width:20%;">
      <b>Total:</b>
  <g:formatNumber number="${total}" format="\$###,##0.00" />
</td>
<td style="width:20%;">
</td>
</tr>
</form>
<tr>
  <td style="width:100%;text-align:center;" colspan="4">
    <hr />
    <a href="<g:createLink action="payments" />">Make Additional Payments</a>
    <br />
<g:if test="${total}">
  <a href="<g:createLink action="checkout" />">Proceed to Checkout</a>
</g:if>
</td>
</tr>
</table>
<br /><br />

</body>
</html>
