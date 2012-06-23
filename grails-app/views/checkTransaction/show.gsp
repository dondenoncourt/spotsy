<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="internal" />
        <title>Show CheckTransaction</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list">CheckTransaction List</g:link></span>
        </div>
        <div class="body">
            <h1>Show CheckTransaction</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            <td valign="top" class="value">${checkTransactionInstance.id}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">First Name:</td>
                            <td valign="top" class="value">${checkTransactionInstance.firstName}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Middle Name:</td>
                            <td valign="top" class="value">${checkTransactionInstance.middleName}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Last Name:</td>
                            <td valign="top" class="value">${checkTransactionInstance.lastName}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Address1:</td>
                            <td valign="top" class="value">${checkTransactionInstance.address1}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Address2:</td>
                            <td valign="top" class="value">${checkTransactionInstance.address2}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">City:</td>
                            <td valign="top" class="value">${checkTransactionInstance.city}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">State:</td>
                            <td valign="top" class="value">${checkTransactionInstance.state}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Zip:</td>
                            <td valign="top" class="value">${checkTransactionInstance.zip}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Country:</td>
                            <td valign="top" class="value">${checkTransactionInstance.country}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Email:</td>
                            <td valign="top" class="value">${checkTransactionInstance.email}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Account Num:</td>
                            <td valign="top" class="value">${checkTransactionInstance.accountNum}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Account Type:</td>
                            <td valign="top" class="value">${checkTransactionInstance.accountType}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Home Phone:</td>
                            <td valign="top" class="value">${checkTransactionInstance.homePhone}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Work Phone:</td>
                            <td valign="top" class="value">${checkTransactionInstance.workPhone}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Date Sent To400:</td>
                            <td valign="top" class="value">${checkTransactionInstance.dateSentTo400}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Routing Num:</td>
                            <td valign="top" class="value">${checkTransactionInstance.routingNum}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Ip Address:</td>
                            <td valign="top" class="value">${checkTransactionInstance.ipAddress}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Amount:</td>
                            <td valign="top" class="value">${checkTransactionInstance.amount}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Bill Type Id:</td>
                            <td valign="top" class="value">${checkTransactionInstance.billTypeId}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Confirmation Num:</td>
                            <td valign="top" class="value">${checkTransactionInstance.confirmationNum}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Date Created:</td>
                            <td valign="top" class="value">${checkTransactionInstance.dateCreated}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Payment Id:</td>
                            <td valign="top" class="value">${checkTransactionInstance.paymentId}</td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Payment Line Id:</td>
                            <td valign="top" class="value">${checkTransactionInstance.paymentLineId}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
