<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Real Estate Billing Information</title>
    </head>
<body>
<g:javascript library="prototype" />
<h3 align="left">
Online Services<br>
Account Information Lookup</h3>
<p style="text-align: center;">
</p><h3>Real Estate Bill - Account Information Lookup Results</h3>
<br/>
These results last updated: <g:formatDate format="MM/dd/yyyy hh:mm:ss" date="${balCtl.finishDate}"/>.
All balances include interest, if applicable through <g:formatDate format="MM/dd/yyyy" date="${balCtl.finishDate}"/>.<br/>
<br/><br/>
<table style="width: 100%;">
  <tbody>
    <g:each var="${bal}" status="i" in="${balances}">
    <tr>
    <td style="width: 75%;">
      <table style="width: 100%;">
        <tbody><tr>
      <tr>
        <td style="width:40%;text-align:right;" valign="top">
          <b>Owner Number :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          ${bal.reCustomerNum}
        </td>
      </tr>
      <tr>
        <td style="width:40%;text-align:right;" valign="top">
          <b>Current Bill Number :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          ${bal.reBillNum}
        </td>
      </tr>
      <tr>
        <td style="width:40%;text-align:right;" valign="top">
          <b>Name :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          ${bal.displayName}
        </td>
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
          <b>Tax Map Number :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          ${bal.reParcel}
        </td>
      </tr>
      <tr>
        <td style="width:40%;text-align:right;" valign="top">
          <b>Physical Address :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          ${bal.houseNum} ${bal.preDir} ${bal.street} ${bal.postDir} ${bal.suffix}<br />
        </td>
      </tr>
      <tr>
        <td style="width:40%;text-align:right;" valign="top">
          <b>Description :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          ${bal.reLegal}
        </td>
      </tr>
      <tr>
        <td style="width:40%;text-align:right;" valign="top">
          <b>Last Payment received :</b>
        </td>
        <td style="width:60%;text-align:left;" valign="top">
          <g:formatNumber number="${bal.lastPaymentAmnt}" format="\$###,##0.00" />
          received on 
          <g:formatDate format="MM/dd/yyyy" date="${bal.lastPaymentDate}"/>
          <br /><br />
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
            <g:formatNumber number="${bal.balance}" format="\$###,##0.00" />
            (if paid on <g:formatDate format="MM/dd/yyyy" date="${balCtl.finishDate}"/>)  
          </g:else>
          </b>
        </td>
      </tr>
    </table>
  </td>
  <td style="width:25%;">
    <form action="https://www.spotsylvania.va.us/onlineservices/assessment/results.cfm" method="post" target="_blank">
      <input type="hidden" name="streetnum" id="streetnum" value="${bal.houseNum}" />
      <input type="hidden" name="streetname" id="streetname" value="${bal.street}" />
      <input type="hidden" name="parcelid" id="parcelid" value="" />
      <input type="image" name="submit" id="submit" class="button" value="Lookup Assessment" src="${createLinkTo(dir:'images/buttons',file:'lookupassessment.jpg')}" alt="Lookup Assessment" width="150" height="25" />
    </form><br />
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
</tbody>
</table>

</body>