<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="payment" />
    <title>Edit Payment</title>
</head>
<body>
<g:javascript library="prototype" />

<div style="text-align:right;">
	<a href="${createLink(controller:'payment', action:'viewcart')}">Shopping Cart</a> &nbsp;
</div>
<h3>Online Payments and Purchases</h3>

 <g:form method="post" action="edittocart" name="editForm" useToken="true">
    <input type="hidden" id="payId" name="payId" value="${pay?.id}" />
    <input type="hidden" id="balId" name="balId" value="${(cmd?.balId?:'0')}" />
    <input type="hidden" id="billTypeId" name="billTypeId" value="${billType.id}" />
    <input type="hidden" id="doNotValidateAccount" name="doNotValidateAccount" value="${doNotValidateAccount}" />
    
    <table style="width:100%;">
      <tr>
        <td style="width:20%;text-align:center;vertical-align:top;">
            <a href="${createLinkTo(dir:'images',file:billType.imageFilename)}" target="_blank">
            <img src="${createLinkTo(dir:'images',file:billType.thumbnailFilename)}" alt="${billType.name}" border="0" /><br />
            See more detailed images
            </a>
        </td>
        <td style="width:60%;">
          <h4>${billType.name}</h4>
          <br /><br />

            <g:if test="${flash.message}">
              <div class="errors">${flash.message}</div>
            </g:if>
			<g:if test="${flash.invalidToken}">
			  Don't click the button twice!
			</g:if>            
			<g:hasErrors bean="${cmd}">
              <div class="errors">
                  <g:renderErrors bean="${cmd}" as="list" />
              </div>
            </g:hasErrors>

          
          <g:if test="${billType.specialNote}">
           <p style="text-align: center; color: rgb(255, 0, 0);">
              <b>Special Note About ${billType.name} :</b><br />
              ${billType.specialNote}
              <br />
            </p>
          </g:if>
          <br />
          <h4>Additional Information Needed - Please complete the fields below:</h4><br />
          The fields marked with a red <b style="color:#FF0000">*</b> are required.<br /> 
          <g:if test="${!session.userNum}">
	                <% if (billType.id == 4) { %>
	                    <div class="note">Please refer to the Customer Number and Location Number at the top of your bill</div>
					<% } %>
	          <p style="text-align:center;">
	          	<a href="${createLinkTo(dir:'images',file:billType.imageFilename)}" target="_blank">See Sample Bill</a><br/><br/>
	            
				<a  href="${createLink(controller:'lookup',action:'selectLookupPage')}?billTypeId=${billType.id}">
					You may lookup your account information using our account lookup system.
	          	</a>
	          </p>
          </g:if>
<g:javascript>
function balSelectChange() {
	var balSelect = $('balSelect')
   	<% if (billType.id == 1) { %>
		var match = /Owner No:(\d*) Bill No:(\d*) Balance: \$([.0-9]*)/.exec(balSelect.options[balSelect.selectedIndex].text)
	    $('accountNum').value=match[1];
	    $('billNum').value=match[2];
		$('amount').value=match[3];
	<% } else if (billType.id == 2) { %>
		var match = /Account No:(\d*) Balance: \$([.0-9]*)/.exec(balSelect.options[balSelect.selectedIndex].text)
	    $('accountNum').value=match[1];
		$('amount').value=match[2];
	<% } else if (billType.id == 4) { %>
		var match = /Customer No:(\d*) Location No:(\d*) Balance: \$([.0-9]*)/.exec(balSelect.options[balSelect.selectedIndex].text)
	    $('accountNum').value=match[1];
	    $('billNum').value=match[2];
		$('amount').value=match[3];
	<% } %>
}
</g:javascript>

          <table style="width:100%;">
            <g:if test="${session.userNum && (billType.id == 1 || billType.id == 2 || billType.id == 4)}">
	          <g:if test="${session.userNum}">
	              <tr><td colspan="2" style="width:100%;text-align:center;"><b>Previously Stored Accounts:</b></td></tr>
	              <tr>
	              	<td colspan="2" style="width:100%;text-align:center;">
	              		<% if (balances?.size()) { %>
		              		<select id="balSelect" name="balSelect" onchange="balSelectChange();">
		              			<option>Select an account to populate the fields below</option>
		 					    <g:each var="${bal}" status="i" in="${balances}">
							    	<% if (bal.systemId == '01') { %>
				              			<option>${bal.displayName.encodeAsHTML()}/Owner No:${bal.reCustomerNum} Bill No:${bal.reBillNum} Balance: $${bal.balance}</option>
									<% } else if (bal.systemId == '02') { %>
				              			<option>${bal.displayName.encodeAsHTML()}/Account No:${bal.ppAccount} Balance: $${bal.balance}</option>
									<% } else if (bal.systemId == '04') { %>
				              			<option>${bal.displayName.encodeAsHTML()}/Customer No:${bal.wsCustomerNum} Location No:${bal.wsLocationNum} Balance: $${bal.balance}</option>
									<% } %>
			              		</g:each>
		              		</select>
	              		<% } %>
	              	</td>
	              </tr>
	          </g:if>
	              <tr>
	                <td colspan="2" style="width:100%;text-align:center;">
	                    <a href="${createLink(controller:'lookup',action:'selectLookupPage', params:[billTypeId:billType.id])}">
	                    	Use our account lookup system to link your accounts to your My Spotsy account.</a><br />
	                </td>
	              </tr>
            </g:if>
            <tr>
              <td style="width:50%;text-align:right;">
                <label class="label" for="accountNum"><b style="color:RED">*</b> 
                	${billType.name} - 
				   	<% if (billType.id == 1) { %>
						Current Owner
					<% } else if (billType.id == 4) { %>
					    Customer
					<% } else { %>
					    Account
					<% } %>					   
                	Number
                </label><br />
                ${billType.minActDigits} - ${billType.maxActDigits} digits:
              </td>
              <td style="width:50%;text-align:left;">
                <input type="text" name="accountNum" id="accountNum" class="text" value="${cmd?.accountNum}"
                       <%--  <g:if test="${cmd?.accountNum && !cmd.errors?.getFieldError('accountNum')}">readonly="readonly"</g:if>--%>
                />
              </td>
            </tr>
            <g:if test="${billType.id == 1 || billType.id == 4}"><!-- real estate or water/sewer -->
  	           <tr>
                <td style="width:50%;text-align:right;">
                  <label class="label" for="billNum"><b style="color:RED">*</b>${((billType.id == 1)?'Bill':'Location')} Number</label><br />
                  Up to 7 digits
                </td>
                <td style="width:50%;text-align:left;">
                  <input type="text" name="billNum" id="billNum" class="text" value="${cmd?.billNum}" 
                          <%--<g:if test="${cmd?.billNum && !cmd.errors?.getFieldError('billNum')}">readonly="readonly"</g:if>--%>
                  />
                </td>
              </tr>
            </g:if>
            <tr>
              <td colspan="2" style="width:100%;text-align:left;">
                <h4>Amount to Pay:</h4><br />
                This item allows you to choose how much you want to pay, please specify that amount below.
              </td>
            </tr>
            <tr>
              <td style="width:50%;text-align:right;" valign="top">
                <label class="label" for="amount"><b style="color:#FF0000">*</b><b>Amount:</b></label>
                <br />No Dollar Sign
                <br />Example: (100.00)
              </td>
              <td style="width:50%;text-align:left;" valign="top">
                <input type="text" name="amount" id="amount" value="${cmd?.amount}" class="text" size="10" maxlength="10" />
              </td>
            </tr>
          </table>
          <hr />
          <div style="text-align:center;">
			<% if (!flash.alreadySubmitted) { %>
        	    <input type="submit" class="button" value="Update Item" id="addtocartmid" name="addtocartmid" />
        	<% } %> 
          </div>
        </td>
        <td style="width:20%;vertical-align:top;">
          <div style="text-align:center;">
			<% if (!flash.alreadySubmitted) { %>
	            <input type="submit" class="button" value="Update Item" id="addtocartside" name="addtocartside"  />
        	<% } %> 
          </div>
        </td>
      </tr>
    </table>
 </g:form>

</body>

</html>
