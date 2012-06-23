<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Real Estate Lookup</title>
    </head>

<body>
  <br/>
<h3>Real Estate Bill - Account Information Lookup</h3>
<br>
There are several options to lookup your account. Please complete the required fields marked with a red <b style="color: rgb(255, 0, 0);">*</b> in the option of your choice and we will attempt to retrieve your information.<br><br>
<p style="text-align: center;">
  <a href="https://www.spotsylvania.va.us/gallery/popup.cfm?gallerynum=29" target="_blank">See Sample Bill</a><br><br>
</p>

<g:if test="${flash.message}">
  <div class="errors">${flash.message}</div>
  <g:if test="${flash.message} = 'Your search returned no results'">
    <a href="http://www.spotsylvania.va.us/contactus/feedback.cfm?deptnum=46">You may use this link to contact the Treasurer's Office if you are unable to find your account.</a>i
  </g:if>

</g:if>

<g:if test="${cmd?.hasErrors()}">
  <div class="errors"><g:renderErrors bean="${cmd}" /></div>
</g:if>

<g:form name="reSearchForm" action="lookupRealEstate" id="reSearchForm"  method="post">
<input name="billTypeId" id="billTypeId" value="1" type="hidden">
<table style="width: 100%;">
<tbody>
<tr>
    <td style="width: 40%; text-align: right;" valign="top">
      <label class="label" for="housenum"><b style="color: rgb(255, 0, 0);">*</b><b>House Number:</b></label>
    </td>
    <td style="width: 60%; text-align: left;" valign="top">
    <g:textField name="housenum" class="text" size="10" maxlength="10" value="${cmd?.housenum}"/>
  </td>
</tr>
<tr>
  <td style="width: 40%; text-align: right;" valign="top">
    <label class="label" for="street"><b style="color: rgb(255, 0, 0);">*</b><b>Street name:</b></label><br>
    Do not include prefixes or suffixes. For example W Main St. type in Main
  </td>
  <td style="width: 60%; text-align: left;" valign="top">
    <input name="street" id="street" class="text" size="25" maxlength="25" type="text" value="${cmd?.street}">
  </td>
</tr>
<tr>
  <td style="width: 100%; text-align: center;" colspan="2" valign="top">
    <hr>
    <b>OR</b>
    <hr>
  </td>
</tr>
<tr>
  <td style="width: 40%; text-align: right;" valign="top">
    <label class="label" for="recustomer"><b style="color: rgb(255, 0, 0);">*</b><b>Real Estate Owner Number:</b></label>
  </td>
  <td style="width: 60%; text-align: left;" valign="top">
    <input name="recustomer" id="recustomer" class="text" size="7" maxlength="7" type="text" value="${cmd?.recustomer}">
  </td>
</tr>
<tr>
  <td style="width: 100%; text-align: center;" colspan="2" valign="top">
    <hr>
    <b>OR</b>
    <hr>
  </td>
</tr>
<tr>
  <td style="width: 40%; text-align: right;" valign="top">
    <label class="label" for="refirstname"><b style="color: rgb(255, 0, 0);">*</b><b>First Name:</b></label><br>
    Only include the first 15 digits.
  </td>
  <td style="width: 60%; text-align: left;" valign="top">
    <input name="refirstname" id="refirstname" class="text" size="15" maxlength="15" type="text" value="${cmd?.refirstname}">
  </td>
</tr>
<tr>
  <td style="width: 40%; text-align: right;" valign="top">
    <label class="label" for="relastname"><b style="color: rgb(255, 0, 0);">*</b><b>Last Name:</b></label><br>
    Only include the first 15 digits.
  </td>
  <td style="width: 60%; text-align: left;" valign="top">
    <input name="relastname" id="relastname" class="text" size="15" maxlength="15" type="text" value="${cmd?.relastname}">
  </td>
</tr>
<tr>
  <td style="width: 100%; text-align: center;" colspan="2" valign="top">
    <hr>
    <b>OR</b>
    <hr>
  </td>
</tr>
<tr>
  <td style="width: 40%; text-align: right;" valign="top">
    <label class="label" for="rebizname"><b style="color: rgb(255, 0, 0);">*</b><b>Business Name:</b></label>
  </td>
  <td style="width: 60%; text-align: left;" valign="top">
    <input name="rebizname" id="rebizname" class="text" size="15" maxlength="15" type="text" value="${cmd?.rebizname}">
  </td>
</tr>
<tr>
  <td style="width: 100%; text-align: center;" colspan="2" valign="top">
    <br>
    <input name="submit" id="submit" class="button" value="Search" type="submit">
  </td>
</tr>
</tbody></table>
</g:form>

</body>
</html>