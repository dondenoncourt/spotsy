import grails.test.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.groovy.grails.commons.DefaultGrailsApplication
import groovy.sql.Sql

/** series of automated integration tests for the eChecks CSV */
class EchecksServiceTests extends GrailsUnitTestCase {
    def echecksService
    def mailService

    protected void setUp() {
        super.setUp()

    }

    protected void tearDown() {
        super.tearDown()
    }
/*
    void dont_test_write_eChecks() {
        def config = new ConfigObject()
        config.spotsy400.url = "jdbc:hsqldb:mem:testDb"
        config.spotsy400.user = "sa"
        config.spotsy400.pass = ""
        config.spotsy400.jdbc.driver = "org.hsqldb.jdbcDriver"
        config.echeck.append.email.to.addresses = "dondenoncourt@gmail.com"
        config.echeck.append.email.from.address = "dondenoncourt@gmail.com"
        config.echeck.append.email.copy.address = "dondenoncourt@gmail.com"

        ConfigurationHolder.config = config
        GrailsApplication.metaClass.getConfig = {-> config }

        assertEquals "jdbc:hsqldb:mem:testDb", ConfigurationHolder.config.spotsy400.url.toString()
        assertEquals "sa",                     ConfigurationHolder.config.spotsy400.user.toString()
        assertEquals "",                       ConfigurationHolder.config.spotsy400.pass.toString()
        assertEquals "org.hsqldb.jdbcDriver",  ConfigurationHolder.config.spotsy400.jdbc.driver.toString()

        def pay = new Payment(userNum:199,confirmationNum:123456789)
        pay.addToLines(new PaymentLine(billTypeId:1,amount:1.23g, account:12345, billNum:123))
        Boolean saveOk = pay.save(flush:true)
        if (!saveOk) { pay.errors.each {println it} }
        assertTrue "payment save() failed", saveOk

        pay = new Payment(userNum:199,confirmationNum:987654321)
        pay.addToLines(new PaymentLine(billTypeId:4,amount:9.34g, account:54321, billNum:321))
        if (!pay.save(flush:true)) { pay.errors.each {println it} }

        pay = new Payment(userNum:199,confirmationNum:12121212)
        pay.addToLines(new PaymentLine(billTypeId:3,amount:5.55g, account:121212))
        if (!pay.save(flush:true)) { pay.errors.each {println it} }

        assertEquals 3, Payment.count()
        def payList = Payment.list()
        def checkTran = new CheckTransaction(paymentId:payList[0].id, paymentLineId:payList[0].lines[0].id, billTypeId:1, accountType:1, confirmationNum:123456789, amount:1.23g, firstName:'Don', lastName:'Denoncourt', middleName:'G', homePhone:'1(123)123-1234', workPhone:'1(123)123-1234', email:'d@home.com', address1:'2 1st Street', address2:'PO BOX, 1', city:'Spotsylvania', state:'VA', zip:'23233', country:'USA', routingNum:'051000020', accountNum:'12345', dateSentTo400:null, dateCreated:new Date(), ipAddress:'192.168.0.9')
        if (!checkTran.save(flush:true)) {println checkTran.errors}
        new CheckTransaction(paymentId:payList[1].id, paymentLineId:payList[1].lines[0].id, billTypeId:4, accountType:2, confirmationNum:987654321, amount:9.34g, firstName:'Don', lastName:'Denoncourt', middleName:'G', homePhone:'1(123)123-1234', workPhone:'1(123)123-1234', email:'d@home.com', address1:'2 1st Street', address2:'PO BOX, 1', city:'Spotsylvania', state:'VA', zip:'23233', country:'USA', routingNum:'051000020', accountNum:'54321',  dateSentTo400:null, dateCreated:new Date(), ipAddress:'192.168.0.9').save(flush:true)
        new CheckTransaction(paymentId:payList[2].id, paymentLineId:payList[2].lines[0].id, billTypeId:3, accountType:1, confirmationNum:12121212,  amount:5.55g, firstName:'Don', lastName:'Denoncourt', middleName:'G', homePhone:'1(123)123-1234', workPhone:'1(123)123-1234', email:'d@home.com', address1:'2 1st Street', address2:'PO BOX, 1', city:'Spotsylvania', state:'VA', zip:'23233', country:'USA', routingNum:'051000020', accountNum:'121212', dateSentTo400:null, dateCreated:new Date(), ipAddress:'192.168.0.9').save(flush:true)
        def checkTranList = CheckTransaction.list()
        assertEquals 3, checkTranList.size()
        echecksService.insert = echecksService.insert.replaceAll(/#/, 'octothorp')
        try {
            def job = new CheckTranUploadJob()
            job.grailsApplication = new DefaultGrailsApplication()
            job.echecksService = echecksService
            job.mailService = new Expando()
            job.mailService.sendMail = { } // don't send any mail 
            assertEquals "dondenoncourt@gmail.com", job.grailsApplication.config.echeck.append.email.to.addresses
            assertEquals 3, CheckTransaction.withCriteria { isNull('dateSentTo400') }.size()
            job.execute() // runs echecksService.writeEchecksTo400()
        } catch (Exception e) {
            println e.printStackTrace()
        }
        // make sure date sent to 400 is set
        assertEquals 0, CheckTransaction.withCriteria { isNull('dateSentTo400') }.size()
        Sql db = Sql.newInstance(ConfigurationHolder.config.spotsy400.url.toString(),
                                 ConfigurationHolder.config.spotsy400.user.toString(),
                                 ConfigurationHolder.config.spotsy400.pass.toString(),
                                 ConfigurationHolder.config.spotsy400.jdbc.driver.toString() )
        def count = db.firstRow ("select count(*) from ECHECKS")
        assertEquals 3, count[0]
        def rows = db.rows ("select * from ECHECKS")
        assertEquals '1',               rows[0].TRNNUM 
        assertEquals 'Don',       rows[0].FNAME
        assertEquals 'Denoncourt',        rows[0].LNAME
        assertEquals 'G',      rows[0].MNAME
        assertEquals '1(123)123-1234',  rows[0].HPHONE
        assertEquals '1(123)123-1234',  rows[0].WPHONE
        assertEquals 'd@home.com',      rows[0].EMAIL
        assertEquals '2 1st Street',        rows[0].ADDR1
        assertEquals 'PO BOX, 1',        rows[0].ADDR2
        assertEquals 'Spotsylvania',            rows[0].CITY
        assertEquals 'VA',           rows[0].STATE
        assertEquals '23233',           rows[0].ZIP
        assertEquals 'USA',         rows[0].CNTRY  //TODO get country code
        //DTEADD:Sat May 23 16:27:56 EDT 2009
        assertEquals '01',               rows[0].BTYPCD
        assertEquals BillType.get(1).name, rows[0].BTYPNM
        assertEquals 1.23g,             rows[0].AMOUNT
        assertEquals '12345',           rows[0].BLPAR1
        assertEquals '123',             rows[0].BLPAR2
        assertEquals 'Denoncourt',        rows[0].BLPAR3
        assertEquals '',                rows[0].BLPAR4
        assertEquals 'Current Owner Number',  rows[0].PARNM1
        assertEquals 'Bill Number',     rows[0].PARNM2
        assertEquals '',                rows[0].PARNM3
        assertEquals '',                rows[0].PARNM4
        assertEquals '051000020',       rows[0].FINANB
        assertEquals '12345',           rows[0].ACCTNB
        assertEquals '1',               rows[0].SAVCHK
        assertEquals '192.168.0.9',     rows[0].IPADDR
        assertEquals '123456789',       rows[0].CNFMNB
        assertEquals 'SPECIAL',         rows[0].GLCDE
        assertEquals payList[0].id,     rows[0].CARTOCTOTHORP // CART# on 400
        assertEquals payList[0].lines[0].id, rows[0].CRITMOCTOTHORP //CRITM# on 400
        
        assertEquals '04',               rows[1].BTYPCD
        assertEquals BillType.get(4).name, rows[1].BTYPNM
        assertEquals '987654321',       rows[1].CNFMNB
        assertEquals 9.34g,             rows[1].AMOUNT
        assertEquals payList[1].id,     rows[1].CARTOCTOTHORP // CART# on 400
        assertEquals '54321',           rows[1].BLPAR1
        assertEquals '321',             rows[1].BLPAR2
        assertEquals 'Account Number',  rows[1].PARNM1
        assertEquals 'Bill Number',     rows[1].PARNM2

        assertEquals '03',              rows[2].BTYPCD
        assertEquals BillType.get(3).name, rows[2].BTYPNM
        assertEquals '12121212',        rows[2].CNFMNB
        assertEquals 5.55g,             rows[2].AMOUNT
        assertEquals payList[2].id,     rows[2].CARTOCTOTHORP // CART# on 400
        assertEquals '121212',          rows[2].BLPAR1
        assertEquals '',                rows[2].BLPAR2
        assertEquals 'Ticket Number',   rows[2].PARNM1
        assertEquals '',                rows[2].PARNM2

    }
*/
    /** series of automated integration tests for the eChecks CSV */
    void test_gen_eChecks_csv() {

        def pay = new Payment(userNum:199,confirmationNum:123456789)
        pay.addToLines(new PaymentLine(billTypeId:1,amount:1.23g, account:12345, billNum:123))
        Boolean saveOk = pay.save(flush:true)
        if (!saveOk) { pay.errors.each {println it} }
        assertTrue "payment save() failed", saveOk

        pay = new Payment(userNum:199,confirmationNum:987654321)
        pay.addToLines(new PaymentLine(billTypeId:4,amount:9.34g, account:54321, billNum:321))
        if (!pay.save(flush:true)) { pay.errors.each {println it} }

        pay = new Payment(userNum:199,confirmationNum:12121212)
        pay.addToLines(new PaymentLine(billTypeId:3,amount:3.33g, account:121212))
        if (!pay.save(flush:true)) { pay.errors.each {println it} }
        pay = new Payment(userNum:199,confirmationNum:9288293)
        pay.addToLines(new PaymentLine(billTypeId:2,amount:2.22g, account:121212))
        if (!pay.save(flush:true)) { pay.errors.each {println it} }
        pay = new Payment(userNum:199,confirmationNum:7541527)
        pay.addToLines(new PaymentLine(billTypeId:5,amount:5.55g, account:121212))
        if (!pay.save(flush:true)) { pay.errors.each {println it} }

        assertEquals 5, Payment.count() 
        assertEquals 5, pay.list().size()
        pay.list().each {payIt ->
        	def line = payIt.lines[0]
    		// todo toggle accountType from 1|2 for check/savings
        	def checkTran =  
	            new CheckTransaction(paymentId:payIt.id, paymentLineId:line.id, billTypeId:line.billTypeId, accountType:1, 
	            		confirmationNum:payIt.confirmationNum,  
	            		amount:line.amount, firstName:'Don', lastName:'Denoncourt', middleName:'G', homePhone:'1(123)123-1234', workPhone:'1(123)123-1234', email:'d@home.com', address1:'2 1st Street', address2:'PO BOX, 1', city:'Spotsylvania', state:'VA', zip:'23233', country:'USA', 
	            		routingNum:'051000020', accountNum:'121212', 
	            		dateSentTo400:null, dateCreated:new Date(), ipAddress:'192.168.0.9') 
        	if (!checkTran.save(flush:true)) {
        		println checkTran.errors
        	}
        }

        def checkTranList = CheckTransaction.list()
        assertEquals 5, checkTranList.size()
        try {
            def job = new CheckTranUploadJob()
            job.grailsApplication = new DefaultGrailsApplication()
            job.echecksService = echecksService
            job.mailService = mailService
//            job.mailService = new Expando(); job.mailService.sendMail = { } // don't send any mail 

//			assertEquals (["dondenoncourt@gmail.com", "dondenoncourt@gmail.com"], job.grailsApplication.config.echeck.append.email.to.addresses.toArray())
            
            assertEquals (["dondenoncourt@gmail.com", "dondenoncourt@gmail.com"], job.grailsApplication.config.echeck.append.email.to.addresses.toArray())
            assertEquals 5, CheckTransaction.withCriteria { isNull('dateSentTo400') }.size()
            job.execute() // runs echecksService.writeEchecksToCSV()
        } catch (Exception e) {
            println e.printStackTrace()
        }
    }
}
