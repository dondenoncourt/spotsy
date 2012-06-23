<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="internal" />
        <title>CheckTransaction List</title>
    </head>
    <body>
        <div class="body">
            <h1>CheckTransaction List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
          <div>
          <h2>Search by name, account, or transaction date</h2>
          
            <g:form action="list" method="post">
                   Last Name:
                    <g:textField name="lastName" />
                    Account:
                    <g:textField name="account" />
                    Transaction Date:
                    <g:datePicker name="transDate" value="${new Date()}" precision="day" years="${2009..2050}"/>
                    <input type="submit" class="buttons" name="search" value="Search"/>
            </g:form>
          </div>
          <br/>
          <br/>
            <div class="list">
                <table>
                    <thead>
                        <tr><td>Id</td><td>Trans Date</td><td>Name</td><td>Address1</td><td>Confirmation No</td><td>Amount</td><td>Account No</td><td>Routing No</td></tr>
                    </thead>
                    <tbody>
                    <g:each in="${checkTransactionInstanceList}" status="i" var="ct">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${ct.id}">${ct.id}</g:link></td>
                            <td><g:formatDate format="MM/dd/yyyy" date="${ct.dateCreated}"/></td>
                            <td>${ct.firstName} ${ct.middleName} ${ct.lastName}</td>
                            <td>${ct.address1}</td>
                            <td>${ct.confirmationNum}</td>
                            <td class="number"><g:formatNumber number="${ct.amount}" format="\$###,##0.00" /></td>
                            <td>${ct.accountNum}</td>
                            <td>${ct.routingNum}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${checkTransactionInstanceTotal}" params="${params}" />
            </div>
        </div>
    </body>
</html>
