import grails.test.*

class BalanceImportControlTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testSomething() {
        mockDomain(BalanceImportControl, [
            new BalanceImportControl(id:1, balanceImportNum:1, startDate:(new Date().minus(2)), finishDate:(new Date().minus(1)), complete:1),
            new BalanceImportControl(id:2, balanceImportNum:2, startDate:(new Date().minus(20)), finishDate:(new Date().minus(20)), complete:1),
            new BalanceImportControl(id:4, balanceImportNum:4, startDate:(new Date().minus(40)), finishDate:(new Date().minus(30)), complete:1)
        ])
        def list = BalanceImportControl.list()
        assertEquals(3, list.size())
        def bal = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])
        assertEquals(1, bal.id)
    }
}
