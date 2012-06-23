import java.sql.Timestamp

/** Auto-timed tasks which uses a cron (based the Unix cron facilities) setting  
 *
 */
class BalanceImportJob {
    static triggers = {
	 cron name: 'import545AMPM', cronExpression : "0 1 7,19 * * ?" // 7:01 AM and 7:01 PM  
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
