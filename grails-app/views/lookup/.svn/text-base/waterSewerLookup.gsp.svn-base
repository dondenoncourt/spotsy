<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <title>Water/Sewer Lookup</title>
  </head>

  <body>

    <h3>Water/Sewer - Account Information Lookup</h3>
    <br>
    There are several options to lookup your account. Please complete the required fields marked with a red <b style="color: rgb(255, 0, 0);">*</b> in the option of your choice and we will attempt to retrieve your information.<br><br>
    <p style="text-align: center;">
      <a href="https://www.spotsylvania.va.us/gallery/popup.cfm?gallerynum=31" target="_blank">See Sample Bill</a><br><br>
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

  <g:form name="wsSearchForm" action="lookupWaterSewer" id="wsSearchForm"  method="post">
  <input name="billTypeId" id="billTypeId" value="4" type="hidden">
  <table style="width: 100%;">
    <tbody>
<%-- Removed per Janet
     <tr>
      <td style="width:40%;text-align:right;" valign="top">
        <label class="label" for="wsAccountNum"><b style="color:#FF0000">*</b><b>Account Number:</b></label><br />
	This can be found on your water and sewer bill. 
      </td>
      <td style="width:60%;text-align:left;" valign="top">
        <input type="text" name="wsCustLocNum" id="wsCustLocNum" class="text" value="${cmd?.wsCustLocNum}" size="12" maxlength="12" />
      </td>
    </tr>
    <tr>
      <td style="width:100%;text-align:center;" valign="top" colspan="2">
        <hr />
        <b>OR</b>
        <hr />
      </td>
    </tr>
--%>    
    <tr>
      <td style="width:40%;text-align:right;" valign="top">
        <label class="label" for="wsCustomerNum"><b style="color:#FF0000">*</b><b>Customer Number:</b></label>
      </td>
      <td style="width:60%;text-align:left;" valign="top">
        <input type="text" name="wsCustomerNum" id="wsCustomerNum" class="text" value="${cmd?.wsCustomerNum}" size="9" maxlength="9" />
      </td>
    </tr>
    <tr>
      <td style="width:40%;text-align:right;" valign="top">
        <label class="label" for="wsLocationNum"><b style="color:#FF0000">*</b><b>Location Number:</b></label>
      </td>
      <td style="width:60%;text-align:left;" valign="top">
        <input type="text" name="wsLocationNum" id="wsLocationNum" value="${cmd?.wsLocationNum}" class="text" size="9" maxlength="9" />
      </td>
    </tr>
    <tr>
      <td style="width:100%;text-align:center;" valign="top" colspan="2">
        <hr />
        <b>OR</b>
        <hr />
      </td>
    </tr>
    <tr>
      <td style="width:40%;text-align:right;" valign="top">
        <label class="label" for="wsCustomerNumOnly"><b style="color:#FF0000">*</b><b>Customer Number:</b></label>
      </td>
      <td style="width:60%;text-align:left;" valign="top">
        <input type="text" name="wsCustomerNumOnly" id="wsCustomerNumOnly" value="${cmd?.wsCustomerNumOnly}" class="text" size="9" maxlength="9" />
      </td>
    </tr>
  <tr>
    <td style="width:100%;text-align:center;" valign="top" colspan="2">
      <br />
      <input type="submit" name="submit" id="submit" class="button" value="Search" />
    </td>
  </tr>
</table>
</g:form>

</body>
</html>