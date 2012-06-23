import com.ibm.as400.access.AS400
import com.ibm.as400.access.AS400SecurityException

import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

class AdminController {
    def beforeInterceptor = {
        log.debug "action: $actionName params: $params"
    }
	
	def runJob = { 
    	if (!params.jobName) {
    		flash.message = 'Please select a job'
    		return
    	}
    	if (!['epayment', 'epayadmin'].find{ it == params.user}) {
    		flash.message = 'User name is not authorized to run jobs'
       		return
    	}
		AS400 as400 = new AS400(CH.config.spotsy400.ip.toString(), CH.config.spotsy400.user.toString(), CH.config.spotsy400.pass.toString())
		
		try {
   			as400.authenticate(params.user, params.password);
        	session.adminLoggedIn = true
    		flash.message = "Job ${params.jobName} launched as a Java thread"
        	if (params.jobName == 'BalanceImportJob') {
        		Thread.start{BalanceImportJob.triggerNow()}
        	} else if (params.jobName == 'CheckTranUploadJob') {
        		Thread.start{CheckTranUploadJob.triggerNow()}
        	} else {
        		flash.message = "Invalid job name: ${params.jobName}"
        	}
    	} catch (AS400SecurityException ase) {
    		flash.message = "Invalid user and/or password"
    	}
	}
    
    

}
 