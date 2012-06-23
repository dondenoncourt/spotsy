<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Personal Property Lookup</title>
    </head>
    
<body>
<br/>
<h3 align="left">
  Online Services<br/>
  Account Information Lookup
</h3>
<p style="text-align: center;">
  Select the type of bill that you want to look up below:<br/>
</p>
<g:form name="selectLookupForm" controller="lookup" action="selectLookupPage" id="selectLookupForm"  method="post" style="text-align: center;">
  <label for="billTypeId" class="label">Select Bill Type:</label>
  <select name="billTypeId" id="billTypeId" size="1" class="dropdown">
    <option value="1">Real Estate Bill</option>
    <option value="2">Personal Property Bill</option>
    <option value="4">Water/Sewer Bill</option>
  </select>
  <input name="submit" id="submit" class="button" value="Go" type="submit"/>
</g:form>

   <g:each var="${bal}" status="i" in="${balances}">
	<dl>
    	<% if (bal.systemId == '01') { %>
		<dt>Account Type :</dt>			<dd>Real Estate</dd>   	 
		<dt>Owner Number :</dt>			<dd>${bal.reCustomerNum}</dd>
		<dt>Current Bill Number :</dt>	<dd>${bal.reBillNum}</dd>
		<dt>Physical Address :</dt>		<dd>${bal.houseNum} ${bal.preDir} ${bal.street} ${bal.postDir} ${bal.suffix}<br /></dd>
		<dt>Tax Map Number :</dt>		<dd>${bal.reParcel}</dd>
		<dt>Description :</dt>			<dd>${bal.reLegal}</dd>
		<% } else if (bal.systemId == '02') { %>
		<dt>Account Type :</dt>			<dd>Personal Property</dd>   	 
		<dt>Account Number :</dt>		<dd>${bal.ppAccount}</dd>
		<% } else if (bal.systemId == '04') { /* water/sewer */%>
		<dt>Account Type :</dt>			<dd>Water Sewer</dd>   	 
		<dt>Customer Number :</dt>		<dd>${bal.wsCustomerNum}</dd>
		<dt>Location Number :</dt>		<dd>${bal.wsLocationNum}</dd>
		<% } %>
		<dt>Name on Account :</dt>		<dd>${bal.displayName}</dd>
		<dt>Address :</dt>				<dd>${bal.address1}</dd>
		<dt>&nbsp;</dt>					<dd>${bal.address2}</dd>
		<dt>&nbsp;</dt>					<dd>${bal.address3}</dd>
		<dt>Last Payment Details :</dt>	<dd>
		                                   <g:formatNumber number="${bal.lastPaymentAmnt}" format="\$###,##0.00" /> 
		                                   received on 
		                                   <g:formatDate format="MM/dd/yyyy" date="${bal.lastPaymentDate}"/>
		                                </dd>
		<dt>Balance Due :</dt>			<dd><g:formatNumber number="${bal.balance}" format="\$###,##0.00" /> (if paid on <g:formatDate format="MM/dd/yyyy" date="${balCtl.finishDate}"/>)</dd>
		<dt>&nbsp;</dt>					<dd>Unlink this account Unlink this account [ link yet to be coded... ] </dd>
		<dt>&nbsp;</dt>					<dd>
              <g:if test="${bal.balance > 0 && bal.credit != 'CR'}">
                <g:link controller="payment" action="transtocart" params="[balanceNum:bal.balanceNum]" onclick="\$('paythisbill${i}').hide();">
              		<img src="${createLinkTo(dir:'images/buttons',file:'paythisbillonline.jpg')}" alt="Pay This Bill Online" border="0" width="150" height="25" id="paythisbill${i}" />
                </g:link>
             	  </g:if>
		</dd>
	</dl>
</g:each>

</body>
</html>
