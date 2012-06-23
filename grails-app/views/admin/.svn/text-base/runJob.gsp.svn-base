<html> 
    <head> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
        <meta name="layout" content="main" /> 
        <title>Run a Job</title>
    </head> 
    <body > 
	    <CENTER>	
	           <g:if test="${flash.message}"><div class="errors">${flash.message}</div></g:if> 
	           <g:form >
	               <table> 
	                  <tr > 
	                   	<TH align="right" >Job:</TH>
	                   	<td>
	                   		<select id="jobName" name="jobName">
	                   			<option value="">- Select a Job -</option>
	                   			<option value="BalanceImportJob">Balance Import</option>
	                   			<option value="CheckTranUploadJob">Check Transaction Upload</option>
	                   		</select>
						</td> 
	                  </tr> 
	                  <tr > 
	                   	<TH align="right" >User:</TH>
	                   	<td><input type="text" maxlength='10' name='user' value='${params.user}' class="text"/></td> 
	                  </tr> 
	                  <tr> 
						<TH align="right">Password:</TH>
	                    <td><input type="password" maxlength='10' name='password' value='${params.password}' class="text"/></td> 
	                  </tr> 
	                  <tr> 
			               <td align="right"><g:actionSubmit value="Submit" action="runJob" styleClass="button"  /></td>
			               <td align="right"><input type="reset" value="Reset" styleClass="button"  /></td>
	                  </tr> 
	               </table> 
	           </g:form> 
	    </CENTER>
    </body> 
</html> 