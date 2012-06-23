import grails.test.*
import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import grails.util.Environment

/**
 * Note: test using the dev environment, not the default of test.
 * Use grails dev test-app BalanceImportService -integration
 * also use: -DJAVA_OPTS="-Xms512M -Xmx512M" 
 */
class BalanceImportServiceTests extends GrailsUnitTestCase {
	def balanceImportService
    def sessionFactory
    boolean transactional = false
	
    protected void setUp() {
        super.setUp()
        if (Environment.current != Environment.DEVELOPMENT) {
        	println "This test requires DEVELOPMENT environment"
        } else {
	        Sql db = Sql.newInstance(ConfigurationHolder.config.spotsy400.url,
	                ConfigurationHolder.config.spotsy400.user,
	                ConfigurationHolder.config.spotsy400.pass,
	                ConfigurationHolder.config.spotsy400.jdbc.driver)
	        db.execute("delete from SystemImportControl") 
	        [
		     	[11815,'04',3911,'2010-02-22 17:46:59.0','2010-02-22 17:21:29.0',1,'2010-02-22 17:46:59.0',35809],
		    	[11816,'01',3911,'2010-02-22 17:48:51.0','2010-02-22 17:18:22.0',1,'2010-02-22 17:48:51.0',60043],
		    	[11818,'02',3911,'2010-02-22 18:05:04.0','2010-02-22 17:10:05.0',1,'2010-02-22 18:05:04.0',184198],
		    	[11819,'04',3912,'2010-02-23 05:46:50.0','2010-02-23 05:22:01.0',1,'2010-02-23 05:46:50.0',35805],
		    	[11820,'01',3912,'2010-02-23 05:48:07.0','2010-02-23 05:19:41.0',1,'2010-02-23 05:48:07.0',60043],
		    	[11821,'02',3912,'2010-02-23 05:52:14.0','2010-02-23 05:10:44.0',1,'2010-02-23 05:52:14.0',184198]
			].each {row ->
			 	db.execute("insert into SystemImportControl  (SystemImportNum,SystemCode,BalanceImportNum,DateFinish,SourceDate,Complete,LastRecordDate,RecordsProcessed) values (?, ?, ?, ?, ?, ?, ?, ?)", row)
	        }
	       	
	       db.execute("delete from BalanceImportControl") 
	        [
	         [3913, '2010-02-23 17:40:00.0','2010-02-23 17:46:45.0',1],	
	         [3914, '2010-02-23 17:48:00.0','2010-02-23 17:54:22.0',1],
	         [3915, '2010-02-24 05:46:00.0','2010-02-24 05:52:33.0',1]
	        ].each {row ->
		 		db.execute("insert into BalanceImportControl  ( BalanceImportNum, StartDate, FinishDate, Complete) values (?, ?, ?, ?)", row)
	        }
	
	        try {
	            db.execute "create table epmbalts (SYSTEMID CHAR(2) not null, LASTRUN	CHAR(19) not null)"
	        } catch (java.sql.SQLException sqle) {
	            println sqle // probably just "table already exists"
	            db.execute "delete from epmbalts"
	        }
	
	        db.execute("delete from epmbalts") 
	        [
		        ['02', '02/23/2010 17:04:35'],
		        ['01', '02/23/2010 17:13:51'],	
		        ['04', '02/23/2010 17:17:08']
	 		].each {row ->
	 			db.execute("insert into epmbalts (SYSTEMID, LASTRUN) values (?, ?)", row)
	        }
	
	        db.execute("delete from BalanceImport") 
        } // in DEVELOPMENT environment
	}

    protected void tearDown() {
        super.tearDown()
    }

    void testImport() {
        if (Environment.current != Environment.DEVELOPMENT) {
        	return
        }
    	balanceImportService.sessionFactory = sessionFactory
    	assertEquals 3, BalanceImportControl.list().size()
    	assertEquals 6, SystemImportControl.list().size()
    	balanceImportService.importBalances()
    	assertEquals 4, BalanceImportControl.list().size()
    	assertEquals 9, SystemImportControl.list().size()
    }
}
