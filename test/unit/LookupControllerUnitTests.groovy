import grails.test.*
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import org.codehaus.groovy.grails.commons.GrailsApplication

class LookupControllerUnitTests extends ControllerUnitTestCase {

    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testPopulation() {
        def config = new ConfigObject()
        config.spotsy400.url = "jdbc:hsqldb:mem:testDb"
        config.spotsy400.user = "sa"
        config.spotsy400.pass = ""
        config.spotsy400.jdbc.driver = "org.hsqldb.jdbcDriver"
        ConfigurationHolder.config = config
        GrailsApplication.metaClass.getConfig = {-> config }

        assertEquals "jdbc:hsqldb:mem:testDb", ConfigurationHolder.config.spotsy400.url.toString()
        assertEquals "sa",                     ConfigurationHolder.config.spotsy400.user.toString()
        assertEquals "",                       ConfigurationHolder.config.spotsy400.pass.toString()
        assertEquals "org.hsqldb.jdbcDriver",  ConfigurationHolder.config.spotsy400.jdbc.driver.toString()

        mockDomain(Balance)
        mockDomain(BalanceImportControl)
        mockDomain(BillType)
        mockDomain(UserAccount)
        mockDomain(User)
        PopulateTestDomain.populate()
        def bal = Balance.get(1)
        assertEquals(89965342, bal.balanceNum)
    }
    void testSelectLookupPage () {
        mockParams.billTypeId = '1'
        controller.selectLookupPage()
        assertEquals("realEstateLookup", renderArgs.view)
        mockParams.billTypeId = '2'
        controller.selectLookupPage()
        assertEquals("personalPropertyLookup", renderArgs.view)
        mockParams.billTypeId = '4'
        controller.selectLookupPage()
        assertEquals("waterSewerLookup", renderArgs.view)
    }
	
}

