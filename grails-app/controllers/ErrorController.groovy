/**
 * Handles application errors by emailing the stack to whoever is identified in
 * the configuration  value for app.error.email.to.addresses  
 */
public class ErrorController{

	def error = {

            try {
		sendMail {
			to grailsApplication.config.app.error.email.to.addresses.toArray()
			subject "Spotsy Java Web app error occurred."
			body( view:"/error/internalError", 
                              plugin:"email-confirmation",
                              model:[fromAddress:'dondenoncourt@gmail.com'])
			from grailsApplication.config.app.error.email.from.address
		}
            } catch (Exception e) {
                log.error "Problem emailing $e.message", e
            }
            render (view:'error')
	}
	
	def failure = {
		throw new RuntimeException('Error email test. Please ignore.')
	}
}
