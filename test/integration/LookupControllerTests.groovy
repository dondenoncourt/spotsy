import grails.test.*

/** series of automated tests for the LookupController */
class LookupControllerTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    /** series of automated tests for water sewer */
    void test_water_sewer() {
        def controller = new LookupController()
        controller.params.wsCustLocNum =  ''
        controller.params.wsCustomerNum =  ''
        controller.params.wsLocationNum =  ''
        controller.params.wsCustomerNumOnly =  ''
        controller.lookupWaterSewer()
        assertEquals('/lookup/waterSewerLookup', controller.modelAndView.viewName)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("spotsy.lookup.at.least.one") )

        controller.params.wsCustLocNum =  '12345678901'
        controller.lookupWaterSewer()
        assertEquals('/lookup/waterSewerLookup', controller.modelAndView.viewName)
        println controller.modelAndView.model.cmd.errors.fieldErrors[0].toString()
        assertEquals "No billing information found for selection criteria", controller.flash.message

        controller.params.wsCustLocNum =  ''
        controller.params.wsCustomerNumOnly = '80991'
        controller.lookupWaterSewer()
        assertEquals('/lookup/waterSewerBillInfo', controller.modelAndView.viewName)

        controller.params.wsCustomerNumOnly =  ''
        controller.params.wsCustomerNum =  '80991'
        controller.params.wsLocationNum =  '573128'
        controller.lookupWaterSewer()
        assertEquals('/lookup/waterSewerBillInfo', controller.modelAndView.viewName)

    }
    /** series of automated tests for real estate */
    void test_real_estate() {
        // TODO add tests for other selection criterion
        def controller = new LookupController()
        controller.params.refirstname =  ''
        controller.params.relastname =  ''
        controller.params.housenum =  ''
        controller.params.street =  ''
        controller.params.recustomer =  ''
        controller.params.rebizname =  ''
        controller.lookupRealEstate()
        //println controller.response
        assertEquals('refirstname', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("spotsy.lookup.at.least.one") )

        controller.params.housenum =  'bogus'
        controller.params.street =  'bogus'
        controller.lookupRealEstate()
        assertEquals('housenum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)

        controller.params.housenum =  '123'
        controller.lookupRealEstate()
        assertEquals "No balances found for selection criteria", controller.flash.message

        controller.params.refirstname =  'x'
        controller.params.relastname =  'x'
        controller.params.housenum =  'x'
        controller.params.street =  'x'
        controller.params.recustomer =  'x'
        controller.params.rebizname =  'x'
        controller.lookupRealEstate()
        //println controller.response
        assertEquals('refirstname', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("spotsy.lookup.only.one") )

        controller.params.housenum =  '5710'
        controller.params.street =  'Towles Mill'
        controller.params.refirstname =  ''
        controller.params.relastname =  ''
        controller.params.recustomer =  ''
        controller.params.rebizname =  ''
        controller.lookupRealEstate()
        assertEquals('/lookup/realEstateBillInfo', controller.modelAndView.viewName)

    }
    /** series of automated tests for personal property */
    void testLookupPersonalProperty() {
        def controller = new LookupController()
        controller.params.lastName = ''
        controller.params.ppSS1L4 = ''
        controller.params.ppAccount = ''
        controller.lookupPersonalProp()
        assertEquals('lastName', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("spotsy.lookup.at.least.one") )

        controller.params.ppAccount = 'should be numeric'
        controller.lookupPersonalProp()
        assertEquals('ppAccount', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)

        controller.params.lastName = 'x'
        controller.params.ppSS1L4 = '123'
        controller.params.ppAccount = 'x'
        controller.lookupPersonalProp()
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("spotsy.lookup.only.one") )

    }

}
