import java.sql.Timestamp
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH

/** Auto-timed tasks which uses a cron (based the Unix cron facilities) setting  
 *
 */
class BalanceImportJob {
    static triggers = {
	 //cron name: 'importJob', cronExpression : "0 1 7,19 * * ?" // 7:01 AM and 7:01 PM  
	 cron name: 'importJob', cronExpression : CH.config.importJobCron
    }	
    	
    def balanceImportService
    
    /**   
     */
    def execute() {
        log.debug "BalanceImportJob processing begin"
        balanceImportService.importBalances()
        log.debug "BalanceImportJob processing done"
    }
}
