<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Water/Sewer Billing Information</title>
  </head>
  <body>
<g:javascript library="prototype" />

    <h3 align="left">
      <br/>
      Online Services<br/>
      Account Information Lookup</h3>
    <p style="text-align: center;">
    </p><h3>Water/Sewer Bill - Account Information Lookup Results</h3>
    <br/>
    These results last updated: <g:formatDate format="MM/dd/yyyy hh:mm:ss" date="${balCtl.finishDate}"/>.
  All balances include interest, if applicable through <g:formatDate format="MM/dd/yyyy" date="${balCtl.finishDate}"/>.<br/>
  <br/><br/>
  <table style="width: 100%;">
    <tbody>
    <g:each var="${bal}" status="i" in="${balances}">
      <tr>
        <td style="width:75%;">
          <table>
            <tr>
              <td style="width:40%;text-align:right;" valign="top"> <b>Customer Number :</b> </td>
              <td style="width:60%;text-align:left;" valign="top"> ${bal.wsCustomerNum} </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top"> <b>Location Number :</b> </td>
              <td style="width:60%;text-align:left;" valign="top"> ${bal.wsLocationNum} </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top"> <b>Name :</b> </td>
              <td style="width:60%;text-align:left;" valign="top"> ${bal.displayName} </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top"> <b>Service Address :</b> </td>
              <td style="width:60%;text-align:left;" valign="top">
                ${bal.address1}<br />
                ${bal.address2}<br />
                ${bal.address3}
              </td>
            </tr>
            <tr>
              <td style="width:40%;text-align:right;" valign="top"><b>Last Payment :</b></td>
              <td style="width:60%;text-align:left;" valign="top">
                <g:formatNumber number="${bal.lastPaymentAmnt}" format="\$###,##0.00" />
                received on
                <g:formatDate format="MM/dd/yyyy" date="${bal.lastPaymentDate}"/><br /><br />
                <g:if test="${bal.wsDirectDeb == '1' || bal.wsDirectDeb == 'C'}">
                	<div class="errors">
                    This account will be automatically drafted on <g:formatDate format="MM/dd/yyyy" date="${bal.wsDirectDebDate}"/> <br />
                    If service is terminated before the draft date, the bank account will not be drafted.
                    </div>
                </g:if>
                <g:if test="${bal.wsDirectDeb == 'P'}">
                    The current bill will not be drafted, the <b>next</b> bill will be drafted.
                </g:if>
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
              <tr>
                <td>
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
    </table>
    </td>
  </tr>
</g:each>
</table>

</body>
