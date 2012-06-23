import grails.test.*

class BalanceTests extends GrailsUnitTestCase {
    static SDF = new java.text.SimpleDateFormat("yyyy-MM-dd")
    protected void setUp() {
        super.setUp()

    }

    protected void tearDown() {
        super.tearDown()
    }

    void test_populate_logic_used_in_PopulateTestDomain() {
        mockDomain(Balance)

	def attr = ['balanceNum','balanceImportNum','systemId','balance','credit','lastPaymentAmnt',       'lastPaymentDate','firstName','lastName','ppAccount','ppSS1L4','ppSS2L4','reCustomerNum','reParcel','reBillNum','reLegal','wsLocationNum','wsCustomerNum','wsPhone','wsDirectDeb','wsDirectDebDate','ppCareOf','houseNum','preDir',     'street',  'suffix','postDir','wsPostQual','apartment',   'city','state',    'zip',           'address1',               'address2','address3',       'displayName','ppTaxesPaidForYear','ppTaxesPaidCredit','coOwnerFirstName','coOwnerLastName']
	def valu =[[    90132239,              3111,      '02',   102.77,    null,            37.11, SDF.parse('2007-11-16'),    'DEANA','KUCHLEWSKI',  6409734,     1397,        0,              0,      null,          0,     null,              0,              0,     null,         null,             null,      null,      5710,    null,'Towles Mill',      'RD',     null,        null,       null,'PARTLOW',   'VA',225349502,'5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',      null,'Deana L Kuchlewski',                   0,               null,              null,            null],
                   [           2,              3111,      '02',   102.77,    null,            37.11, SDF.parse('2007-11-16'),    'DEANA','KUCHLEWSKI',  6409734,     1397,        0,              0,      null,          0,     null,              0,              0,     null,         null,             null,      null,      5710,    null,'Towles Mill',      'RD',     null,        null,       null,'PARTLOW',   'VA',225349502,'5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',      null,'Deana L Kuchlewski',                   0,               null,              null,            null],
                   [           3,              3111,      '02',   102.77,    null,            37.11, SDF.parse('2007-11-16'),    'DEANA','KUCHLEWSKI',  6409734,     1397,        0,              0,      null,          0,     null,              0,              0,     null,         null,             null,      null,      5710,    null,'Towles Mill',      'RD',     null,        null,       null,'PARTLOW',   'VA',225349502,'5710 Towles Mill RD', 'PARTLOW, VA 22534-9502',      null,'Deana L Kuchlewski',                   0,               null,              null,            null]
                  ]

        valu.eachWithIndex {val, i ->
            def map = [:]
            attr.eachWithIndex {atr, j ->
                    map.put(attr[j], valu[i][j])
            }
            def bal = new Balance(map)
            if (bal.validate() == false) {
                bal.errors.allErrors.each {println it}
            }
            assertTrue(bal.validate())
            assertEquals(3111, bal.balanceImportNum)
            assertEquals(37.11g, bal.lastPaymentAmnt)
            assertEquals(102.77g, bal.balance)
            assertEquals('DEANA', bal.firstName)
            assertEquals('02', bal.systemId)
            println "bal: $bal"
        }
    }

}
