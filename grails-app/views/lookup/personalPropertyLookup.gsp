<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Personal Property Lookup</title>
    </head>
<body>
<g:javascript library="prototype" />

  <h3>Personal Property Bill - Account Information Lookup</h3>
<br/>
There are several options to lookup your account. Please complete the required fields marked with a red <b style="color: rgb(255, 0, 0);">*</b> in the option of your choice and we will attempt to retrieve your information.<br/><br/>
    <p style="text-align: center;">
        <a href="https://www.spotsylvania.va.us/gallery/popup.cfm?gallerynum=30" target="_blank">See Sample Bill</a><br/><br/>
    </p>

<g:if test="${flash.message}">
  <div id="messages" class="errors">${flash.message}</div>
</g:if>

<g:if test="${cmd?.hasErrors()}">
  <div id="errors" class="errors"><g:renderErrors bean="${cmd}" /></div>
</g:if>

<g:form name="ppSearchForm" action="lookupPersonalProp" id="ppSearchForm"  method="post" style="text-align: center;">
    <input name="billTypeId" id="billTypeId" value="2" type="hidden">

    <table style="width: 100%;">
            <tbody><tr>
                <td style="width: 40%; text-align: right;" valign="top">
                    <label class="label" for="lastName"><b style="color: rgb(255, 0, 0);">*</b><b>Last Name/Business Name:</b></label><br/>
                    Only include the first 15 digits.
                </td>
                <td style="width: 60%; text-align: left;" valign="top">
                  <tooltip:tip value="Enter the last name of the owner">
                    <input name="lastName" id="lastName" class="text" size="15" maxlength="15" type="text" value="${cmd?.lastName}"/>
                  </tooltip:tip>
                </td>
            </tr>
            <tr>
                <td style="width: 40%; text-align: right;" valign="top">
                    <label class="label" for="ppSS1L4"><b style="color: rgb(255, 0, 0);">*</b><b>Last 4 digits of owner's social security number or federal ID:</b></label>
                </td>
                <td style="width: 60%; text-align: left;" valign="top">
                    <input name="ppSS1L4" id="ppSS1L4" class="text" size="4" maxlength="4" type="text"  value="${cmd?.ppSS1L4}"/>
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
                    <label class="label" for="ppAccount"><b style="color: rgb(255, 0, 0);">*</b><b>Personal Property Account Number:</b></label>
                </td>
                <td style="width: 60%; text-align: left;" valign="top">
                    <input name="ppAccount" id="ppAccount" class="text" size="7" maxlength="7" type="text"  value="${cmd?.ppAccount}"/>
                </td>
            </tr>
            <tr>
                <td style="width: 100%; text-align: center;" colspan="2" valign="top">
                    <br/>
                    <input name="submit" id="submit" class="button" value="Search" type="submit" onclick="$('errors').hide();$('messages').hide();">
                </td>
            </tr>
    </tbody></table>
</g:form>
</body>
