<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta Name="layout" content="payment" />
    <title>Bill Payment Confirmation</title>
  </head>
  <body>

    <h3 align="left">Online Payments and Purchases - Confirmation</h3>
    <p>
      Your check payment has been submitted. Your bank account will be debited within 1-5 business days. This transaction will appear as "Spotsylvania CouECHECKS" on your bank statement.<br />
      <br />
      <b>Please print this page and keep it for your records.<br />
        <br />
        Do not hit refresh while on this page as it will result in your payment being submitted twice.
      </b>
      <br /><br />
      If you have any questions regarding your payment, please <a href="http://www.spotsylvania.va.us/contactus/feedback.cfm?deptnum=46">contact the Treasurer's Office via the web</a> or Phone at (540) 507-7058 .
    </p>
    <p>Information Submitted:</p>
    <table border="0" style="width:100%">
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Confirmation Number :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> ${payment.confirmationNum} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Date :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"><g:formatDate format="MM/dd/yyyy" date="${new Date()}"/></td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Name :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> ${cmd.firstName} ${cmd.middleName} ${cmd.lastName} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Address :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top">
            ${cmd.address1} <br />
            <g:if test="${cmd.address2}">
              ${cmd.address2} <br />
            </g:if>
            ${cmd.city}, ${cmd.state} ${cmd.zip}<br />
            ${(g.country(code:cmd.country))}
        </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Home Phone Number :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> ${cmd.homePhone} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Daytime Phone Number :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> ${cmd.workPhone} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>E-mail :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> ${cmd.email} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Routing Number :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> Last Four digits ${cmd.routingNum[(cmd.routingNum.size()-4)..(cmd.routingNum.size()-1)]} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Financial Account Number :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top"> Last Four digits ${cmd.accountNum[(cmd.accountNum.size()-4)..(cmd.accountNum.size()-1)]} </td>
      </tr>
      <tr>
        <td style="width:50%;text-align:right;" valign="top"><b>Account Type :&nbsp;</b></td>
        <td style="width:50%;text-align:left;" valign="top">${PaymentController.actTypList[cmd.accountType]} </td>
      </tr>
      <tr>
        <td style="width:100%;" colspan="2" valign="top">
          <h4>Payments :</h4><br />
          <!---------------------------------------------------------------------------------------------------->
	        <table style="width:100%;" border="0">
	        <% def total=0 %>
	        <g:each var="line" in="${payment?.lines}">
	          <% 
	          	total += line.amount	
	          	def bal = Balance.findByBalanceNum(line.balanceNum)
	          %>
	          <tr>
	            <td style="width:60%;" colspan="2"><b>${BillType.get(line?.billTypeId).name}</b></td>
	            <td style="width:20%;"> <g:formatNumber number="${line.amount}" format="\$###,##0.00" /></td>
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
       <tr>
            <td style="width:100%;text-align:center;" colspan="2" valign="top">
                <b>The above information has been submited</b><br />
                    <b><a href="http://www.spotsylvania.va.us/">You may return to our home page</a></b>
                </form>
            </td>
        </tr>

     </table>
</body>
</html>

