<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta Name="layout" content="payment" />
    <title>Change personal information</title>
  </head>
  <body>

    <h3 align="left">Online Payments and Purchases - Personal Information Correction</h3>
    <p>Please make your corrections below, when you are done submit the corrections by using the make corrections button below. You will be given the chance to review your information again.</p>
    <p>The fields marked with a red <b style="color:#FF0000">*</b> are required.</p><br />
    <g:if test="${flash.message}">
      <div class="errors">${flash.message}</div>
    </g:if>
    <g:if test="${cmd?.hasErrors()}">
      <div class="errors"><g:renderErrors bean="${cmd}" /></div>
    </g:if>

    <form action="changepersonal" method="post">
      <table border="0" style="width:100%">
        <tr>
          <td colspan="2" style="width:100%;text-align:left;"><h4>Personal Information:</h4></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="firstName"><b style="color:#FF0000">*</b><b>First Name:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="firstName" id="firstName" class="text" size="30" maxlength="50" value="${cmd.firstName}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="middleName"><b>Middle Name:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="middleName" id="middleName" class="text" size="30" maxlength="50" value="${cmd.middleName}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="lastName"><b style="color:#FF0000">*</b><b>Last Name:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="lastName" id="lastName" class="text" size="30" maxlength="50" value="${cmd.lastName}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="address1"><b style="color:#FF0000">*</b><b>Address Line 1:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="address1" id="address1" class="text" size="30" maxlength="50" value="${cmd.address1}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="address2"><b>Address Line 2:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="address2" id="address2" class="text" size="30" maxlength="50" value="${cmd.address2}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="city"><b style="color:#FF0000">*</b><b>City:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="city" id="city" class="text" size="30" maxlength="50" value="${cmd.city}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="state"><b style="color:#FF0000">*</b><b>State/Province:</b></label></td>
          <td style="width:60%;text-align:left;">
            <g:select name="state" from="${PaymentController.stateList}" optionKey="${{it.key}}" optionValue="${{it.value}}" value="${(cmd.state?:'VA')}"/>
          </td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top">
            <label class="label" for="country"><b style="color:#FF0000">*</b><b>Country:</b></label></td><td style="width:60%;text-align:left;">
         <%--   <input type="text" name="country" id="country" class="text" size="30" maxlength="50" value="${cmd.country}" />--%>
            <g:countrySelect name="country" value="${cmd.country}" noSelection="['':'-Choose your country-']"/>
          </td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="zip"><b style="color:#FF0000">*</b><b>Zip:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="zip" id="zip" class="text" size="10" maxlength="10" value="${cmd.zip}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top">
            <label class="label" for="homePhone"><b style="color:#FF0000">*</b><b>Home Phone Number:</b></label><br />Please include the area code as well.  <br />Example: 1-(555)555-5555 </td><td style="width:60%;text-align:left;"><input type="text" name="homePhone" id="homePhone" class="text" size="20" maxlength="30" value="${cmd.homePhone}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="workPhone"><b style="color:#FF0000">*</b><b>Daytime Phone Number:</b></label><br />Please include the area code as well. <br />Example: 1-(555)555-5555 </td>
          <td style="width:60%;text-align:left;">
            <input type="text" name="workPhone" id="workPhone" class="text" size="20" maxlength="30" value="${cmd.workPhone}" />
          </td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="email"><b style="color:#FF0000">*</b><b>E-Mail Address:</b></label></td>
          <td style="width:60%;text-align:left;"><input type="text" name="email" id="email" class="text" size="20" maxlength="50" value="${cmd.email}" /></td>
        </tr>
        <tr>
          <td colspan="2" style="width:100%;text-align:left;"><h4>Financial Information:</h4></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top">
            <label class="label" for="routingNum"><b style="color:#FF0000">*</b><b>Routing Number:</b></label><br />The financial institution number is exactly nine digits and can be found at the bottom of your check starting in the lower left corner.  </td>
          <td style="width:60%;text-align:left;" valign="top"><input type="text" name="routingNum" id="routingNum" class="text" size="10" maxlength="9" value="${cmd.routingNum}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="routingNum"><b style="color:#FF0000">*</b><b>Confirm Routing Number:</b></label><br />Please retype your financial institution number below to confirm it.  </td>
          <td style="width:60%;text-align:left;" valign="top"><input type="text" name="routingNum2" id="routingNum2" class="text" size="10" maxlength="9" value="${cmd.routingNum2}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="accountNum"><b style="color:#FF0000">*</b><b>Account Number:</b></label><br />The account number is located next to the financial institution number, and can be up to 17 characters.  </td>
          <td style="width:60%;text-align:left;" valign="top"><input type="text" name="accountNum" id="accountNum" class="text" size="20" maxlength="17" value="${cmd.accountNum}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="accountNum"><b style="color:#FF0000">*</b><b>Confirm Account Number:</b></label><br />Please retype your account number below to confirm it.  </td>
          <td style="width:60%;text-align:left;" valign="top"><input type="text" name="accountNum2" id="accountNum2" class="text" size="20" maxlength="17" value="${cmd.accountNum2}" /></td>
        </tr>
        <tr>
          <td style="width:40%;text-align:right;" valign="top"><label class="label" for="accountNum"><b style="color:#FF0000">*</b><b>Account Type:</b></label><br />Is this a savings account or a checking account?  </td>
          <td style="width:60%;text-align:left;" valign="top">
            <g:select name="accountType" from="${PaymentController.actTypList}" optionKey="${{it.key}}" optionValue="${{it.value}}" value="${cmd.accountType}" class="dropdown"/>
          </td>
        </tr>
        <tr>
          <td style="width:100%;text-align:center;" colspan="2" valign="top"><input type="submit" name="submit" id="submit" class="button" value="Make Correction" /></td>
        </tr>
  </table>
</form>
<br /><br />
</body>
</html>
