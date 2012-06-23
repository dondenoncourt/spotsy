import grails.test.*
import javax.servlet.http.Cookie

/** series of automated integration tests for the PaymentController */
class PaymentControllerTests extends GrailsUnitTestCase {
    def sessionFactory
    
    protected void setUp() {
        super.setUp()
   }

    protected void tearDown() {
        super.tearDown()
    }

    /** series of automated integration tests for transtocart */
    void testTranstocart() {
        def controller = new PaymentController()
        controller.sessionFactory = sessionFactory
        controller.params.balanceNum =  '89965342'
        controller.transtocart()
        assertNotNull 'bal is null', controller.modelAndView.model.bal
        assertNotNull 'billType is null', controller.modelAndView.model.billType

        // Does not handle invalid balancNum
//        controller.params.balanceNum =  '999'
//        controller.transtocart()

    }

    /** series of automated integration tests for bank routing number validation */
    void test_bank_route_number_validation() {
        def controller = new PaymentController()
        controller.params.firstName = 'Don'
        controller.params.lastName = 'Denoncourt'
        controller.params.middleName = ''
        controller.params.homePhone = '11231231234'
        controller.params.workPhone = '11231231234'
        controller.params.email = 'd@h.com'
        controller.params.address1 = '11203 Pinewood Court'
        controller.params.address2 = ''
        controller.params.city = 'Richmond'
        controller.params.state = 'VA'
        controller.params.zip = '23238'
        controller.params.country = 'usa'
        controller.params.routingNum = '051000020'
        controller.params.routingNum2 = '051000020'
        controller.params.accountNum = '12345'
        controller.params.accountNum2 = '12345'
        controller.params.accountType = '1'
        controller.changepersonal()
        assertEquals 'there should be zero command errors from checkout action', 0, controller.modelAndView.model.cmd.errors.fieldErrors.size()
        assertEquals('/payment/preview', controller.modelAndView.viewName)
        controller.params.routingNum = null
        controller.params.routingNum2 = null
        controller.changepersonal()
        assertEquals 'there should be 1 error from checkout action', 1, controller.modelAndView.model.cmd.errors.fieldErrors.size()
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("rejected value [null]") )
        controller.params.routingNum = '123456789'
        controller.params.routingNum2 = '123456789'
        controller.changepersonal()
        assertEquals 'there should be 1 error from checkout action', 1, controller.modelAndView.model.cmd.errors.fieldErrors.size()
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("rejected value [123456789]") )

    }

    /** series of automated integration tests for user login and lookup */
    void test_happy_path_with_login_and_lookup() {
        def lookupController = new LookupController()
        lookupController.session.userNum = '199'
        lookupController.params.refirstname =  ''
        lookupController.params.relastname =  ''
        lookupController.params.recustomer =  ''
        lookupController.params.rebizname =  ''
        lookupController.params.housenum =  '5710'
        lookupController.params.street =  'Towles Mill'
        lookupController.lookupRealEstate()
        assertEquals('/lookup/realEstateBillInfo', lookupController.modelAndView.viewName)
        assertNotNull lookupController.modelAndView.model.balances
        assertEquals '90006453'.toString(), lookupController.modelAndView.model.balances[0].balanceNum.toString()
        assertNotNull lookupController.session.userNum

        def controller = new PaymentController()
        controller.sessionFactory = sessionFactory
        controller.params.balanceNum = lookupController.modelAndView.model.balances[0].balanceNum
        controller.transtocart()
        assertEquals('/payment/edit', controller.modelAndView.viewName)

        controller.params.billTypeId = controller.modelAndView.model.cmd.billTypeId
        controller.params.accountNum = controller.modelAndView.model.cmd.accountNum
        controller.params.billNum = controller.modelAndView.model.cmd.billNum
        controller.params.amount = controller.modelAndView.model.cmd.amount
        controller.params.unittesting = true
        controller.edittocart()
        assertEquals('/payment/view', controller.modelAndView.viewName)

        controller.session.userNum = '199'
        controller.params.accountType = '1'
        controller.params.country = 'usa'
        controller.params.routingNum = '051000020'
        controller.params.routingNum2 = '051000020'
        controller.params.accountNum = '1234'
        controller.params.accountNum2 = '1234'
        controller.preview()
        assertEquals 'there should be zero command errors from preview action', 0, controller.modelAndView.model.cmd.errors.fieldErrors.size()
        assertEquals('/payment/preview', controller.modelAndView.viewName)

        controller.modelAndView.model.cmd.properties.each {key, value -> controller.params."$key" = value}
        controller.preview()
        assertEquals 'there should be zero errors in checkout.gsp', 0, controller.modelAndView.model.cmd.errors.fieldErrors.size()
        assertEquals('/payment/preview', controller.modelAndView.viewName)

        controller.modelAndView.model.cmd.properties.each {key, value -> controller.params."$key" = value}
        controller.submitpayment()

        assertEquals "unexpected error creating a check transaction", controller.flash.message
        assertEquals('/payment/changepersonal', controller.modelAndView.viewName)

        controller.flash.message = '' // clear error
        controller.params.firstName = 'Don'
        controller.params.lastName = 'Denoncourt'
        controller.params.address1 = '11203 Pinewood Court'
        controller.params.city = 'Richmond'
        controller.params.state = 'VA'
        controller.params.zip = '23238'
        controller.params.homePhone = '1(804)792-2279'
        controller.params.workPhone = '1(804)792-2279'
        controller.params.email = 'd@h.com'
        controller.submitpayment()

        sessionFactory.getCurrentSession().flush()
        assertEquals('/payment/finalsubmit', controller.modelAndView.viewName)
        assertEquals 1, CheckTransaction.list().size()
        assertEquals '1(804)792-2279', CheckTransaction.list()[0].homePhone
        assertEquals '127.0.0.1', CheckTransaction.list()[0].ipAddress
    }
    /** series of automated integration tests with no myspotsy login */
    void test_happy_path_no_login_no_lookup() {
        def controller = new PaymentController()
        controller.params.billTypeId = '1'
        controller.params.accountNum = '1234567'
        controller.params.billNum = '1234567'
        controller.params.amount = '1.23'
        controller.params.unittesting = true

        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)
        assertEquals('/payment/view', controller.modelAndView.viewName)
        assertEquals('1234567', controller.modelAndView.model.pay.lines[0].account)
        assertEquals(1234567, controller.modelAndView.model.pay.lines[0].billNum)
        assertEquals(1.23g, controller.modelAndView.model.pay.lines[0].amount)
        assertEquals(1, controller.modelAndView.model.pay.lines[0].billTypeId)

        sessionFactory.getCurrentSession().flush()
        controller = new PaymentController()
        controller.checkout()
        assertEquals('/payment/checkout', controller.modelAndView.viewName)

        controller = new PaymentController()
        controller.params.routingNum = '051000020'
        controller.params.routingNum2 = '051000020'
        controller.preview()
        assertEquals('/payment/changepersonal', controller.modelAndView.viewName)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("UserInfoCommand.accountNum2.validator.invalid") )

        controller.params.accountType = 2
        controller.params.firstName = 'Don'
        controller.params.lastName = 'Denoncourt'
        controller.params.homePhone = '1(804)867-5309'
        controller.params.workPhone = '1(804)867-5309'
        controller.params.email = 'dondenoncourt@gmail.com'
        controller.params.address1 = 'Pinewood'
        controller.params.city = 'Richmond'
        controller.params.state = 'VA'
        controller.params.zip = '23238'
        controller.params.country = 'usa'
        controller.params.routingNum = '051000020'
        controller.params.routingNum2 = '051000020'
        controller.params.accountNum = '1234'
        controller.params.accountNum2 = '1234'
        controller.params.unittesting = true
        controller.checkout()
        assertEquals('/payment/checkout', controller.modelAndView.viewName)
        // checkout does no validation

        // TODO invoke preview to double check validation of UserInfoCommand

        controller = new PaymentController()
        controller.submitpayment()
        sessionFactory.getCurrentSession().flush()
        assertEquals 1, CheckTransaction.list().size()
        assertEquals '1(804)867-5309', CheckTransaction.list()[0].homePhone
        assertTrue CheckTransaction.list()[0].confirmationNum > 0
        //assertEquals('/payment/WHERE?', controller.modelAndView.viewName)

    }
    /** series of automated integration tests for edittocart page handling */
    void testEdittocart() {
        def controller = new PaymentController()
        // Real Estate
        controller.params.billTypeId = BillType.findByName('Real Estate Bill').id
        assertEquals(1, controller.params.billTypeId)
        controller.params.accountNum = '1'
        controller.params.amount = '1.23'
        controller.params.billNum = ''
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd.errors)
        assertEquals('billNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.billNum.for.real.estate.missing") )

        controller.params.accountNum = '1234567'
        controller.params.billNum = ''
        controller.edittocart()
        assertEquals('billNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.billNum.for.real.estate.missing") )

        controller.params.accountNum = '1234567'
        controller.params.billNum = '123456789'
        controller.edittocart()
        assertEquals('billNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.billNum.validator.invalid") )

        //billNum 1-7 digits for real estate
        controller.params.billNum = '123456789'
        controller.edittocart()
        assertEquals('billNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.billNum.validator.invalid") )

        controller.params.billNum = '1234567'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)

        controller.params.billNum = '1'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)

        // Real Estate 7 digits required
        controller.params.billTypeId = BillType.findByName('Personal Property Bill').id
        assertEquals(2, controller.params.billTypeId)
        controller.params.accountNum = '1'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd.errors)
        assertEquals('accountNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.accountNum.validator.invalid") )
        controller.params.accountNum = '1234567'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)

        //Water/Sewer Bill digits 10-12 required
        controller.params.billTypeId = BillType.findByName('Water/Sewer Bill').id
        assertEquals(4, controller.params.billTypeId)
        controller.params.accountNum = '1'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd.errors)
        assertEquals('accountNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.accountNum.validator.invalid") )
        controller.params.accountNum = '12345678910'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)
        controller.params.accountNum = '123456789112'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)
        controller.params.accountNum = '1234567891123'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd.errors)
        assertEquals('accountNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)


        //Water/Sewer Bill digits 5-10 required
        controller.params.billTypeId = BillType.findByName('Business License Bill').id
        assertEquals(5, controller.params.billTypeId)
        controller.params.accountNum = '1234'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd.errors)
        assertEquals('accountNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)
        assertTrue(controller.modelAndView.model.cmd.errors.fieldErrors[0].toString().contains("EditToCartCommand.accountNum.validator.invalid") )
        controller.params.accountNum = '12345'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)
        controller.params.accountNum = '1234567891'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd)
        controller.params.accountNum = '12345678911'
        controller.edittocart()
        assertNotNull(controller.modelAndView.model.cmd.errors)
        assertEquals('accountNum', controller.modelAndView.model.cmd.errors.fieldErrors[0].field)

    }
}
