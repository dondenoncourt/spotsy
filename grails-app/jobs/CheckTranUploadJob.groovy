import java.sql.Timestamp
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

/** Auto-timed tasks which uses a cron (based the Unix cron facilities) setting  
 * which is currently set to "0 59 23 * * ?"  or 11:59PM MON-FRI */
class CheckTranUploadJob {
    //def cronExpression = "0 * * * * ?" // every minute for testing
    //def cronExpression = "0 3 0 * * ?" // 0:03AM MON-FRI probably should be "0 3 0 * 1-5 ?"
    def cronExpression = CH.config.checkTranUploadJobCron
    def echecksService
    def grailsApplication
    def mailService
    
    /**  for all check_transaction row entries with a null dateSentTo400 column,
     *   generate a CSV (using the EchecksService class) 
     *   then email the CSV to the folks identified with the 
     *   soft-coded value called echeck.append.email.to
     *   with copies going to the folks listed in the soft-coded value called
     *   echeck.append.email.copy
     *   any email errors would be shown in the application log.
     */
    def execute() {
        log.debug "CheckTranUploadJob processing"

        def message
        def csv

        // code for "manual" rerun of specific dates
        //def list = CheckTransaction.withCriteria {between 'dateSentTo400', Date.parse('yyyy-MM-dd','2010-04-26'), Date.parse('yyyy-MM-dd','2010-04-28')}
        
        // get a list of CheckTransactions that have not been sent to the 400
        def list = CheckTransaction.withCriteria { isNull('dateSentTo400') }
        if (list.size() > 0) {
            csv = echecksService.writeEchecksToCSV(list)
            BigDecimal total = 0.0g
            Timestamp smallestDate = new Timestamp(new Date().time)
            Timestamp biggestDate = null
            list.each { 
            	total += it.amount 
            	if (it.dateCreated < smallestDate) {
            		smallestDate = new Timestamp(it.dateCreated.time)
            	}
            	if (!biggestDate || it.dateCreated > biggestDate) {
            		biggestDate = new Timestamp(it.dateCreated.time)
            	}
            }
            def formatDate = new java.text.SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
            message = "This file includes ${list.size()} transactions, for a total amount of \$$total between "+
            		formatDate.format(smallestDate)+' and '+formatDate.format(biggestDate)
            println message
        } else {
            message = "Sorry since the last time this e-checks process was run there have been no new payments submitted."
        }

        try {
        	log.debug "mailing to "+grailsApplication.config.echeck.append.email.to.addresses.toArray()
        	log.debug "copying mail to "+grailsApplication.config.echeck.append.email.copy.address
            mailService.sendMail {
            	if (csv) multipart true
                to grailsApplication.config.echeck.append.email.to.addresses.toArray()
                subject "Spotsy Electronic Checks Transaction Upload."
                body message
                from "treas@spotsylvania.va.us"
                cc  grailsApplication.config.echeck.append.email.copy.address 
                if (csv) attachBytes "echecks.csv", "text/csv", csv.getBytes("UTF-8")
            }
        } catch (Exception e) {
            log.error "Problem emailing $e.message", e
        }
    }
}
