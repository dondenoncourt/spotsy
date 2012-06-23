<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="payment" />
    <title>List Bill Payment Types</title>
</head>
<body>

<div style="text-align:right;">
  <a href="${createLink(controller:'payment', action:'viewcart')}">Shopping Cart</a> &nbsp;
</div>

<h3>Online Payments</h3>

<table style="width:100%;">
<g:each var="bill" status="i" in="${billTypes}">
  <g:if test="${i == 0 || (i % 3) == 0}">
  <tr>
  </g:if>
      <td style="width:33%;text-align:center;">
          <a href="<g:createLink controller="payment" action="itemdetails" />?billTypeId=${bill.id}&doNotValidateAccount=true">
              <img src="${createLinkTo(dir:'images',file:bill.thumbnailFilename)}"
                   alt="Sample ${bill.name}" width="77" height="100" border="0" /><br />
              ${bill.name}<br />
          </a>
      </td>
  <g:if test="${ ((i+1) % 3) == 0}">
  </tr><tr><td style="width:100%" colspan="3">&nbsp;</td></tr>
  </g:if>
</g:each>
</table>

</body>
</html>

