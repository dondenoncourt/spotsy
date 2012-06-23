<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Personal Property Billing Information</title>
    </head>
<body>
<g:javascript library="prototype" />
  <br/>
<h3 align="left">Online Services<br/>
Account Information Lookup</h3>

<p style="text-align: center;"></p>
<h3>Personal Property Bill - Account Information Lookup Results</h3>

<br/>
These results last updated: <g:formatDate format="MM/dd/yyyy hh:mm:ss" date="${balCtl.finishDate}"/>.
All balances include interest, if applicable through <g:formatDate format="MM/dd/yyyy" date="${balCtl.finishDate}"/>.<br/>
<br/>

<% def lastYear = Calendar.getInstance().get(Calendar.YEAR) - 1 %>
<% def ppPaidTotal = 0g %>
<table style="width: 100%;">
  <tbody>
    <g:each var="${bal}" status="i" in="${balances}">
    <tr>
      <td style="width: 75%;">
      <table style="width: 100%;">
        <tbody>
          <tr>
            <td style="width: 40%; text-align: right;" valign="top">
              <b>Account Number :</b>
            </td>
            <td style="width: 60%; text-align: left;" valign="top">${bal.ppAccount}</td>
          </tr>
          <tr>
            <td style="width: 40%; text-align: right;" valign="top"><b>Name :</b></td>
            <td style="width: 60%; text-align: left;" valign="top">${bal.displayName}</td>
          </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top">
              </td>
              <td style="width:60%;text-align:left;" valign="top">
                ${bal.address1}<br />
                ${bal.address2}<br />
                ${bal.address3}
              </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top">
                <b>Last Payment received :</b>
              </td>
              <td style="width:60%;text-align:left;" valign="top">
                <g:formatNumber number="${bal.lastPaymentAmnt}" format="\$###,##0.00" /> received on <g:formatDate format="MM/dd/yyyy" date="${bal.lastPaymentDate}"/><br /><br />
              </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top">
                <b>Taxes Paid :</b>
              </td>
              <td style="width:60%;text-align:left;" valign="top">
                <b>
                <g:if test="${bal.ppTaxesPaidCredit == 'CR'}">
                  Credit to this account of <g:formatNumber number="${bal.ppTaxesPaidForYear}" format="\$###,##0.00" />
                  <% ppPaidTotal -= bal.ppTaxesPaidForYear %>
                </g:if><g:else>
                  <g:formatNumber number="${bal.ppTaxesPaidForYear}" format="\$###,##0.00" />
                  <% ppPaidTotal += bal.ppTaxesPaidForYear %>
                </g:else>
                (between 01/01/${lastYear} and 12/31/${lastYear})
                </b>
              </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top">
                <b>Balance :</b>
              </td>
              <td style="width:60%;text-align:left;" valign="top">
                <b>
                <g:if test="${bal.credit == 'CR'}">
                  Credit to this account of <g:formatNumber number="${bal.balance}" format="\$###,##0.00" />
                </g:if><g:else>
                  <g:formatNumber number="${bal.balance}" format="\$###,##0.00" /> (if paid on <g:formatDate format="MM/dd/yyyy" date="${balCtl.finishDate}"/>)
                </g:else>
                </b>
              </td>
            </tr>
          </table>
        </td>
        <td style="width:25%;">
          <g:if test="${bal.balance > 0 && bal.credit != 'CR'}">
            <g:link controller="payment" action="transtocart" params="[balanceNum:bal.balanceNum]" onclick="\$('paythisbill${i}').hide();">
          		<img src="${createLinkTo(dir:'images/buttons',file:'paythisbillonline.jpg')}" alt="Pay This Bill Online" border="0" width="150" height="25" id="paythisbill${i}" />
            </g:link>
          </g:if>
        </td>
      </tr> 
      <tr>
        <td style="width:100%;text-align:center;" valign="top" colspan="2">

          <hr />
        </td>
      </tr>
</g:each>
      <%-- PP Summary --%>
      <tr>
        <td style="width:100%;text-align:center; font-weight:bold;" valign="top" colspan="2">
            Total Taxes Paid for the above accounts: <g:formatNumber number="${ppPaidTotal}" format="\$###,##0.00" /> (between 01/01/${lastYear} and 12/31/${lastYear})<br /><br />
            <g:if test="${lookupByPPAccount == 1}">
              You have done a lookup by specific Personal Property account, the above total represents only that account and may not be a complete total of all of your accounts.<br /><br />
            </g:if>
        </td>
      </tr>
  </tbody>
</table>

</body>