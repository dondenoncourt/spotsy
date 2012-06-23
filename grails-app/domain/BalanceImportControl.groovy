/** Domain class that maps to the BalanceImportControl table. */
/*
insert into BalanceImportControl (BalanceImportNum,StartDate,FinishDate,Complete)
values
(3911,'2010-02-22 17:46:00.0','2010-02-22 18:05:04.0',1),
(3912,'2010-02-23 05:46:00.0','2010-02-23 05:52:14.0',1);
 */
class BalanceImportControl {
    int balanceImportNum
    Date startDate
    Date finishDate
    int complete
    static constraints = {
    	finishDate nullable:true
    }
	static mapping = {
		table 'BalanceImportControl'
		version false
		id column:'balanceImportNum',name:'balanceImportNum' 
		balanceImportNum column:'balanceImportNum'
		startDate column:'startDate'
		finishDate column:'finishDate'
		complete column:'complete'
	}
	
    String toString() {
        return "start: $startDate finish: $finishDate complete: $complete"
    }
}
