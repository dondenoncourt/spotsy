import java.util.Date;

/** Domain class that maps to the SystemImportControl table. */
/*
insert into SystemImportControl (SystemImportNum,SystemCode,BalanceImportNum,DateFinish,SourceDate,Complete,LastRecordDate,RecordsProcessed)
values
(11815,'04',3911,'2010-02-22 17:46:59.0','2010-02-22 17:21:29.0',1,'2010-02-22 17:46:59.0',35809),
(11816,'01',3911,'2010-02-22 17:48:51.0','2010-02-22 17:18:22.0',1,'2010-02-22 17:48:51.0',60043),
(11818,'02',3911,'2010-02-22 18:05:04.0','2010-02-22 17:10:05.0',1,'2010-02-22 18:05:04.0',184198),
(11819,'04',3912,'2010-02-23 05:46:50.0','2010-02-23 05:22:01.0',1,'2010-02-23 05:46:50.0',35805),
(11820,'01',3912,'2010-02-23 05:48:07.0','2010-02-23 05:19:41.0',1,'2010-02-23 05:48:07.0',60043),
(11821,'02',3912,'2010-02-23 05:52:14.0','2010-02-23 05:10:44.0',1,'2010-02-23 05:52:14.0',184198);


 */
class SystemImportControl {
    int systemImportNum
    String systemCode
    int balanceImportNum
    Date dateFinish
    Date sourceDate
    int complete
    Date lastRecordDate
    int recordsProcessed
    static constraints = {
		systemCode 	maxSize:2
		dateFinish  nullable:true
    }
	static mapping = {
		table 'SystemImportControl'
		version false
		id column:'systemImportNum',name:'systemImportNum' 
		systemImportNum		column:'systemImportNum'
		systemCode 			column:'systemCode' 
		balanceImportNum	column:'balanceImportNum'
		dateFinish			column:'dateFinish'
		sourceDate			column:'sourceDate'
		lastRecordDate		column:'lastRecordDate'
		recordsProcessed	column:'recordsProcessed' 
	}
	
    String toString() {
        return "id:$systemImportNum, '$systemCode', balImpNum:$balanceImportNum, dateFinish:$dateFinish, sourceDate:$sourceDate, complete:$complete, lastRecordDate:$lastRecordDate "
    }
}
