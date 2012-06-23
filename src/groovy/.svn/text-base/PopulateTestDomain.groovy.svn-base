/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder
/** Populate the test database with data  */
class PopulateTestDomain {
    static SDF = new java.text.SimpleDateFormat("yyyy-MM-dd")

    static void populate() {
    	try {
	        def attr = ['balanceNum','balanceImportNum','systemId','balance','credit','lastPaymentAmnt',       'lastPaymentDate',    'firstName',  'lastName','ppAccount','ppSS1L4','ppSS2L4','reCustomerNum', 'reParcel','reBillNum',                            'reLegal','wsLocationNum','wsCustomerNum', 'wsPhone','wsDirectDeb','wsDirectDebDate',               'ppCareOf','houseNum','preDir',     'street',  'suffix','postDir','wsPostQual','apartment',          'city','state',    'zip',                'address1',               'address2',              'address3',                    'displayName','ppTaxesPaidForYear','ppTaxesPaidCredit','coOwnerFirstName','coOwnerLastName']
	        def valu =[[    89965342,              3111,      '04',    29.11,    null,            46.73, SDF.parse('2009-02-24'),       'ERIN K',    'BOTKIN',     null,     null,       null,           null,        null,      null,                                 null,         573128,          80991,5405827055,         null,             null,                      null,     6212,    null, 'HOT SPRING',      'LN',     null,        null,       null,'FREDERICKSBURG',   'VA',    22407,      '6212 HOT SPRING LN','FREDERICKSBURG VA 22407',                    null,                   'ERIN K BOTKIN',               null,               null,              null,        null],
	                   [    90247208,              3112,      '04',    29.11,    null,            46.73, SDF.parse('2009-02-24'),       'ERIN K',    'BOTKIN',     null,     null,       null,           null,        null,      null,                                 null,         573128,          80991,5405827055,         null,             null,                      null,     6212,    null, 'HOT SPRING',      'LN',     null,        null,       null,'FREDERICKSBURG',   'VA',    22407,      '6212 HOT SPRING LN','FREDERICKSBURG VA 22407',                    null,                   'ERIN K BOTKIN',               null,               null,              null,          null],
	                   [    90529049,              3113,      '04',    29.11,    null,            46.73, SDF.parse('2009-02-24'),       'ERIN K',    'BOTKIN',     null,     null,       null,           null,        null,      null,                                 null,         573128,          80991,5405827055,         null,             null,                      null,     6212,    null, 'HOT SPRING',      'LN',     null,        null,       null,'FREDERICKSBURG',   'VA',    22407,      '6212 HOT SPRING LN','FREDERICKSBURG VA 22407',                    null,                   'ERIN K BOTKIN',               null,               null,              null,        null],
	                   [    90570095,              3113,      '01',    681.2,    null,           673.34, SDF.parse('2008-07-15'),'THEODORE R JR','KUCHLEWSKI',     null,     null,       null,        2250181,'72-13- 18-',   1433610,'Pleasant Pines Estates Lot 18 Sec 3',           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',    22534,   'Deana Lynn Kuchlewski',    '5710 Towles Mill RD','PARTLOW, VA 22534-9502','Theodore Robert Kuchlewski Jr or',               null,               null,           'DEANA', 'KUCHLEWSKI'],
	                   [    90654504,              3113,      '02',        0,    null,              320, SDF.parse('2009-02-09'),'THEODORE R JR','KUCHLEWSKI',  4731352,     3923,       null,           null,        null,      null,                                 null,           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,     '5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',                    null,        'Theodore R Kuchlewski Jr',              291.7,               null,              null,            null],
	                   [    90654503,              3113,      '02',        0,    null,            42.05, SDF.parse('2006-08-28'),        'DEANA','KUCHLEWSKI',  4731345,     1397,       3923,           null,        null,      null,                                 null,           null,           null,      null,         null,             null,'Theodore R Kuchlewski Jr',     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,'Theodore R Kuchlewski Jr',    '5710 Towles Mill RD','PARTLOW, VA 22534-9502',            'Deana L Kuchlewski &',                  0,               null,              null, 'KUCHLEWSKI'],
	                   [    90006453,              3111,      '01',   681.02,    null,           673.34, SDF.parse('2008-07-15'),'THEODORE R JR','KUCHLEWSKI',     null,     null,       null,        2250181,'72-13- 18-',   1433610,'Pleasant Pines Estates Lot 18 Sec 3',           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',    22534,   'Deana Lynn Kuchlewski',    '5710 Towles Mill RD','PARTLOW, VA 22534-9502','Theodore Robert Kuchlewski Jr or',               null,               null,           'DEANA', 'KUCHLEWSKI'],
	                   [    90090844,              3111,      '02',        0,    null,            42.05, SDF.parse('2006-08-28'),        'DEANA','KUCHLEWSKI',  4731345,     1397,       3923,           null,        null,      null,                                 null,           null,           null,      null,         null,             null,'Theodore R Kuchlewski Jr',     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,'Theodore R Kuchlewski Jr',    '5710 Towles Mill RD','PARTLOW, VA 22534-9502',          'Deana L Kuchlewski &',                    0,               null,              null, 'KUCHLEWSKI'],
	                   [    90090845,              3111,      '02',        0,    null,              320, SDF.parse('2009-02-09'),'THEODORE R JR','KUCHLEWSKI',  4731352,     3923,       null,           null,        null,      null,                                 null,           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,     '5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',                    null,        'Theodore R Kuchlewski Jr',              291.7,               null,              null,         null],
	                   [    90372688,              3112,      '02',        0,    null,            42.05, SDF.parse('2006-08-28'),        'DEANA','KUCHLEWSKI',  4731345,     1397,       3923,           null,        null,      null,                                 null,           null,           null,      null,         null,             null,'Theodore R Kuchlewski Jr',     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,'Theodore R Kuchlewski Jr',    '5710 Towles Mill RD','PARTLOW, VA 22534-9502',             'Deana L Kuchlewski &',                 0,               null,              null, 'KUCHLEWSKI'],
	                   [    90372689,              3112,      '02',        0,    null,              320, SDF.parse('2009-02-09'),'THEODORE R JR','KUCHLEWSKI',  4731352,     3923,       null,           null,        null,      null,                                 null,           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,     '5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',                    null,        'Theodore R Kuchlewski Jr',              291.7,               null,              null,         null],
	                   [    90132239,              3111,      '02',   102.77,    null,            37.11, SDF.parse('2007-11-16'),        'DEANA','KUCHLEWSKI',  6409734,     1397,       null,            null,        null,     null,                                 null,           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,     '5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',                    null,              'Deana L Kuchlewski',                  0,               null,              null,        null],
	                   [    90288297,              3112,      '01',    681.2,    null,           673.34, SDF.parse('2008-07-15'),'THEODORE R JR','KUCHLEWSKI',     null,     null,       null,         2250181,'72-13- 18-',   433610,'Pleasant Pines Estates Lot 18 Sec 3',           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',    22534,   'Deana Lynn Kuchlewski',    '5710 Towles Mill RD','PARTLOW, VA 22534-9502','Theodore Robert Kuchlewski Jr or',               null,               null,            'DEANA', 'KUCHLEWSKI'],
	                   [    90414083,              3112,      '02',   102.79,    null,            37.11, SDF.parse('2007-11-16'),        'DEANA','KUCHLEWSKI',  6409734,     1397,       null,            null,        null,     null,                                 null,           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,     '5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',                    null,              'Deana L Kuchlewski',                  0,               null,              null,        null],
	                   [    90695899,              3113,      '02',  102.79,    null,             37.11, SDF.parse('2007-11-16'),        'DEANA','KUCHLEWSKI',  6409734,     1397,       null,            null,        null,     null,                                 null,           null,           null,      null,         null,             null,                      null,     5710,    null,'Towles Mill',      'RD',     null,        null,       null,       'PARTLOW',   'VA',225349502,     '5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',                    null,              'Deana L Kuchlewski',                  0,               null,              null,        null]
		]
	
	        valu.eachWithIndex {val, i ->
	            def map = [:]
	            attr.eachWithIndex {atr, j -> map.put(attr[j], valu[i][j]) }
	            def bal = new Balance(map)
	            if (!bal.save()) { bal.errors.each { println it }}
	        }
	        def bic = new BalanceImportControl( balanceImportNum:3111, startDate:(new Date().minus(2)), finishDate:(new Date().minus(1)), complete:1)
	        boolean ok = bic.save()  
	        if (!ok) {
	        	bic.errors.allErrors.each { println it.inspect() }
	            assert ok
	        }
	        bic = new BalanceImportControl( balanceImportNum:3110, startDate:(new Date().minus(20)), finishDate:(new Date().minus(20)), complete:1)
	        ok = bic.save()  
	        if (!ok) {
	        	bic.errors.allErrors.each { println it.inspect() }
	            assert ok
	        }
	        bic = new BalanceImportControl( balanceImportNum:3109, startDate:(new Date().minus(40)), finishDate:(new Date().minus(30)), complete:1) 
	        ok = bic.save()  
	        if (!ok) {
	        	bic.errors.allErrors.each { println it.inspect() }
	            assert ok
	        }

	        def bill = new BillType(name:"Real Estate Bill", minActDigits:7, maxActDigits:7,        thumbnailFilename:'RealEstateBill_tn.jpg',          imageFilename:'RealEstateBill.jpg',          specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.")
	        if (!bill.save()) { bill.errors.each { println it }}
	
	        new BillType(name:"Personal Property Bill",           minActDigits:7, maxActDigits:7,   thumbnailFilename:'PersonalPropertyTaxBill_tn.jpg', imageFilename:'PersonalPropertyTaxBill.jpg', specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Parking Ticket",                   minActDigits:5, maxActDigits:5,   thumbnailFilename:'ParkingTicket_tn.jpg',           imageFilename:'ParkingTicket.jpg',           specialNote:"A \$3.00 late payment penalty will be added to all tickets that are not paid within 5 days of the date that the ticket was issued. Please check the date on your ticket before entering the payment amount. If you have any questions, please call the Treasurer\'s Office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Water/Sewer Bill",                 minActDigits:10, maxActDigits:12, thumbnailFilename:'WaterSewerBill_tn.jpg',          imageFilename:'WaterSewerBill.jpg',          specialNote:"Payments for utility bills need to be made 2 Business days prior to the due date or the cutoff date to allow time for processing. If your water has been disconnected you cannot pay by electronic check. Please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a> for other payment options.").save()
	        new BillType(name:"Business License Bill",            minActDigits:5, maxActDigits:10,  thumbnailFilename:'BusinessLicense_tn.jpg',         imageFilename:'BusinessLicense.jpg',         specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Business Tangible Property Bill",  minActDigits:5, maxActDigits:10,  thumbnailFilename:'BTProperty_tn.jpg',              imageFilename:'BTProperty.jpg',              specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Meals Bill",                       minActDigits:5, maxActDigits:10,  thumbnailFilename:'Meals_tn.jpg',                   imageFilename:'Meals.jpg',                   specialNote:"	Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Short Term Rental Bill",           minActDigits:5, maxActDigits:10,  thumbnailFilename:'ShortTerm_tn.jpg',               imageFilename:'ShortTerm.jpg',               specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Transient Occupancy Bill",         minActDigits:5, maxActDigits:10,  thumbnailFilename:'Transient_tn.jpg',               imageFilename:'Transient.jpg',               specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"Public Service Corporation Bill", minActDigits:5, maxActDigits:10,  thumbnailFilename:'PSCorp_tn.jpg',                  imageFilename:'PSCorp.jpg',                  specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
	        new BillType(name:"CRW Transaction",                 minActDigits:1, maxActDigits:20, specialNote:"").save()
	
	        def ua = new UserAccount(userNum:199, ppAccountNum:1)
	        if (!ua.save()) { ua.errors.each { println it }}
	        new UserAccount(userNum:451, ppAccountNum:4731345).save()
	
	        def user = new User(userNum:199, userName:'don', password:'secret', email:'dondenoncourt@gmail.com', firstName:'Don', lastName:'Denoncourt', middleName:'',address1:'11203 Pinewood Court', city:'Richmond', state:'VA', zip:'23238', homePhone:'1(804)792-2279', workPhone:'1(804)792-2279')
	        if (!user.save()) { user.errors.each { println it }}
	        new User(userNum:451, userName:'deana', password:'secret', email:'DKuchlewski@spotsylvania.va.us', firstName:'Deana', lastName:'Kuchlewski', middleName:'',address1:'5710 Towles Mill RD', city:'Spotsylvania', state:'VA', zip:'12345', homePhone:'1(804)867-5309', workPhone:'1(804)867-5309').save()
        } catch (e) {
            println e  
            println "denoncourt denoncourt denoncourt denoncourt denoncourt "
        }

        /* not writing eChecks, using CSV instead
        def createTableEchecks =  """
        CREATE TABLE ECHECKS (
		TRNNUM CHAR(9) NOT NULL,
		FNAME CHAR(50) NOT NULL,
		LNAME CHAR(50) NOT NULL,
		MNAME CHAR(50) NOT NULL,
		HPHONE CHAR(30) NOT NULL,
		WPHONE CHAR(30) NOT NULL,
		EMAIL CHAR(50) NOT NULL,
		ADDR1 CHAR(50) NOT NULL,
		ADDR2 CHAR(50) NOT NULL,
		CITY CHAR(50) NOT NULL,
		STATE CHAR(50) NOT NULL,
		ZIP CHAR(10) NOT NULL,
		CNTRY CHAR(50) NOT NULL,
		DTEADD CHAR(50) NOT NULL,
		BTYPCD CHAR(2) NOT NULL,
		BTYPNM CHAR(50) NOT NULL,
		AMOUNT NUMERIC(12 , 2) NOT NULL,
		BLPAR1 CHAR(50) NOT NULL,
		BLPAR2 CHAR(50) NOT NULL,
		BLPAR3 CHAR(50) NOT NULL,
		BLPAR4 CHAR(50) NOT NULL,
		PARNM1 CHAR(50) NOT NULL,
		PARNM2 CHAR(50) NOT NULL,
		PARNM3 CHAR(50) NOT NULL,
		PARNM4 CHAR(50) NOT NULL,
		FINANB CHAR(12) NOT NULL,
		ACCTNB CHAR(17) NOT NULL,
		SAVCHK CHAR(1) NOT NULL,
		IPADDR CHAR(50) NOT NULL,
		CNFMNB CHAR(9) NOT NULL,
		GLCDE CHAR(50) NOT NULL,
        CARToctothorp NUMERIC(9 , 0) NOT NULL,
		CRITMoctothorp NUMERIC(9 , 0) NOT NULL
	);
	        Sql db = Sql.newInstance(ConfigurationHolder.config.spotsy400.url,
	                ConfigurationHolder.config.spotsy400.user,
	                ConfigurationHolder.config.spotsy400.pass,
	                ConfigurationHolder.config.spotsy400.jdbc.driver)
        """
        try {
            db.execute createTableEchecks
        } catch (java.sql.SQLException sqle) {
            println sqle // probably just "table already exists"
            db.execute "delete from ECHECKS"
        }
    */
    }
	
}

