<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="payment" />
    <title>Checkout</title>
</head>
<body>

<h3 align="left">Online Payments and Purchases</h3>
<form name="checkoutForm" action="preview" method="post">
<table border="0" style="width:100%">
  <tr>
    <td style="width:100%;text-align:center;" colspan="2" valign="top">
      <p>
        The fields marked with a red <b style="color:#FF0000">*</b> are required.
      </p>
    </td>
  </tr>    
  <tr>
    <td colspan="2" style="width:100%;text-align:left;">
      <h4>Personal Information Section:</h4>
    </td>
  </tr>
  <g:if test="${flash.message}">
    <td colspan="2" style="width:100%;text-align:left;"><div class="errors">${flash.message}</div></td>
  </g:if>
  <%--<g:if test="${cmd?.hasErrors()}">--%>
    <%--<td colspan="2" style="width:100%;text-align:left;"><div class="errors"><g:renderErrors bean="${cmd}" /></div></td>--%>
  <%--</g:if>--%>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="firstName"><b style="color:#FF0000">*</b><b>First Name:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="firstName" id="firstName" class="text" size="30" maxlength="50" value="${cmd.firstName}"/></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="middleName"><b>Middle Name:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="middleName" id="middleName" class="text" size="30" maxlength="50" value="${cmd.middleName}"/></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="lastName"><b style="color:#FF0000">*</b><b>Last Name:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="lastName" id="lastName" class="text" size="30" maxlength="50" value="${cmd.lastName}"/></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="address1"><b style="color:#FF0000">*</b><b>Address Line 1:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="address1" id="address1" class="text" size="30" maxlength="50" value="${cmd.address1}"/></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="address2"><b>Address Line 2:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="address2" id="address2" class="text" size="30" maxlength="50" value="${cmd.address2}"/></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="city"><b style="color:#FF0000">*</b><b>City:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="city" id="city" class="text" size="30" maxlength="50" value="${cmd.city}" /></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="statelist"><b style="color:#FF0000">*</b><b>State:</b></label></td>
    <td style="width:60%;text-align:left;">
      <g:select name="state" from="${PaymentController.stateList}" optionKey="${{it.key}}" optionValue="${{it.value}}" value="${(cmd.state?:'VA')}"/>
      <g:if test="${(!PaymentController.stateList.containsKey(cmd.state))}">
        <label class="label" for="statetext">or other province: </label>
        <input type="text" name="statetext" id="statetext" class="text" size="30" maxlength="50" value="${cmd.state}"/>
      </g:if>
    </td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="zip"><b style="color:#FF0000">*</b><b>Zip:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="zip" id="zip" class="text" size="10" maxlength="10" value="${cmd.zip}"/></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="country"><b style="color:#FF0000">*</b><b>Country:</b></label></td>
    <td style="width:60%;text-align:left;">
      <g:countrySelect name="country" value="${cmd.country}" value="usa"/>
    </td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="homePhone"><b style="color:#FF0000">*</b><b>Home Phone Number:</b></label>
      <br />Please include the area code as well.
      <br />Example: 1-(555)555-5555
    </td>
    <td style="width:60%;text-align:left;"><input type="text" name="homePhone" id="homePhone" class="text" size="20" maxlength="30" value="${cmd.homePhone}" /></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="workPhone"><b style="color:#FF0000">*</b><b>Daytime Phone Number:</b></label>
      <br />Please include the area code as well.
      <br />Example: 1-(555)555-5555
    </td>
    <td style="width:60%;text-align:left;"><input type="text" name="workPhone" id="workPhone" class="text" size="20" maxlength="30" value="${cmd.workPhone}" /></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top"><label class="label" for="email"><b style="color:#FF0000">*</b><b>E-Mail Address:</b></label></td>
    <td style="width:60%;text-align:left;"><input type="text" name="email" id="email" class="text" size="20" maxlength="50" value="${cmd.email}"/></td>
  </tr>
  <tr>
    <td colspan="2" style="width:100%;text-align:left;">
      <h4>Financial Information Section:</h4>
      <p>
        On the bottom, left corner of your checks, you will see a series of two (2) numbers. The first one is your Routing Number, the second is your account number. Please supply the first two (2) numbers in the spaces provided. Please note that the representation below is a sample of a regular check. If you are using a non-standard check then please consult your records for the required information listed above.
      </p>
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width:100%;text-align:center;">
      <img src="${(createLinkTo(dir:'images', file:'echeckmarked.jpg') )}" alt="Example Check Dipicting location of various fields" height="255" width="568" />
    </td>
  </tr>
  <tr style="background-color:#99CC99">
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="routingNum"><b style="color:#FF0000">*</b><b>Routing Number:</b></label>
      <br />The routing number is exactly nine digits and can be found at the bottom of your check starting in the lower left corner.
    </td>
    <td style="width:60%;text-align:left;" valign="top">
    	<input type="text" name="routingNum" id="routingNum" class="text" size="10" maxlength="9" value="${cmd.routingNum}" />
    	Do not use the routing number that is printed on the deposit slip.
    </td>
  </tr>
  <tr style="background-color:#99CC99">
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="routingNum2"><b style="color:#FF0000">*</b><b>Confirm Routing Number:</b></label>
      <br />Please input your routing number again to verify it.
    </td>
    <td style="width:60%;text-align:left;" valign="top"><input type="text" name="routingNum2" id="routingNum2" class="text" size="10" maxlength="9" value="${cmd.routingNum2}" /></td>
  </tr>
  <tr style="background-color:#99CCCC">
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="accountNum"><b style="color:#FF0000">*</b><b>Account Number:</b></label>
      <br />The account number is located next to the routing number, and can be up to 17 characters.
    </td>
    <td style="width:60%;text-align:left;" valign="top"><input type="text" name="accountNum" id="accountNum" class="text" size="20" maxlength="17" value="${cmd.accountNum}" /></td>
  </tr>
  <tr style="background-color:#99CCCC">
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="accountNum2"><b style="color:#FF0000">*</b><b>Confirm Account Number:</b></label>
      <br />Please input your account number again to verify it.
    </td>
    <td style="width:60%;text-align:left;" valign="top"><input type="text" name="accountNum2" id="accountNum2" class="text" size="20" maxlength="17" value="${cmd.accountNum2}" /></td>
  </tr>
  <tr>
    <td style="width:40%;text-align:right;" valign="top">
      <label class="label" for="accountNum"><b style="color:#FF0000">*</b><b>Account Type:</b></label>
      <br />Is this a savings account or a checking account?
    </td>
    <td style="width:60%;text-align:left;" valign="top">
      <select name="accountType" id="accountType" size="1" class="dropdown">
        <option value="1" selected="selected">Checking Account</option>
        <option value="2">Savings Account</option>
      </select>
    </td>
  </tr>
  <tr>
    <td colspan="2" style="width:100%;text-align:center;">
      <br />
      This page is protected by a 128 bit SSL certificate provided by Verisign. You may use the logo below to verify that our website is secure.
      <p align="center">
        <script src="https://seal.verisign.com/getseal?host_name=www.spotsylvania.va.us&amp;size=M&amp;use_flash=NO&amp;use_transparent=YES&amp;lang=en">
        </script>
      </p>
      <input type="submit" name="submit" id="submit" class="button" value="Continue" /><input type="reset" name="submit" id="submit" class="button" value="Clear Form" />
    </td>
  </tr>
</table>
</form>

</body>
</html>
