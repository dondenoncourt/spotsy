import grails.util.Environment

/**
 * This class's init method is called at application startup. 
 * Currently the init is coded to run only in test mode, where it sets up test data.
 */
class BootStrap {
    static SDF = new java.text.SimpleDateFormat("yyyy-MM-dd")

    def init = { servletContext ->
        log.debug "BootStrap Environment.current: ${Environment.current}"
        if (Environment.current == Environment.TEST) { // || Environment.current == Environment.DEVELOPMENT) {
            PopulateTestDomain.populate()
        }
     }
     def destroy = {
     }
}
/* comment to force svn update, delete */
