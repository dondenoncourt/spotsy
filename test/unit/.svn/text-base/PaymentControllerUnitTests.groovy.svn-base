import grails.test.*

class PaymentControllerUnitTests extends ControllerUnitTestCase { 
    protected void setUp() {
        super.setUp()
    	mockDomain(BillType)
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
        new BillType(name:"Public Service Corporation Bill",  minActDigits:5, maxActDigits:10,  thumbnailFilename:'PSCorp_tn.jpg',                  imageFilename:'PSCorp.jpg',                  specialNote:"Payment will be considered on-time as long as submission is made by midnight Eastern Standard Time on the due date. Payment will be posted to the oldest unpaid bill. If you have any questions about the due date or the amount due on your account, please call the Treasurer\'s office at (540) 507-7058 or <a href=\"/contactus/feedback.cfm?deptnum=46\">contact the Treasurer\'s Office via the web</a>.").save()
        new BillType(name:"CRW Transaction",                  minActDigits:1, maxActDigits:20, specialNote:"").save()
    }

    protected void tearDown() {
        super.tearDown()
    }
    void testEditToCartCommand() {
       	mockCommandObject(EditToCartCommand)

       	// bad bill type id
    	def cmd = new EditToCartCommand(billTypeId:0, balId:201, accountNum:123,  billNum:123, amount:123d)
    	assertFalse cmd.validate()
       	assertEquals "min.notmet", cmd.errors.getFieldErrors('billTypeId')[0].code
    	cmd = new EditToCartCommand(billTypeId:942, balId:201, accountNum:123,  billNum:123, amount:123d)
    	assertFalse cmd.validate()
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('billTypeId')[0].code
    	
    	// Real Estate
    	cmd = new EditToCartCommand(billTypeId:1, balId:201, accountNum:"",  billNum:null, amount:null)
    	assertFalse cmd.validate()
       	assertEquals "EditToCartCommand.billNum.for.real.estate.missing", cmd.errors.getFieldErrors('billNum')[0].code
       	assertEquals "nullable", cmd.errors.getFieldErrors('amount')[0].code
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:1, balId:201, accountNum:"12345678", billNum:null, amount:1.23d)
    	assertFalse cmd.validate()
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:1, balId:201, accountNum:"1234567",  billNum:null, amount:null)
    	assertFalse cmd.validate()
       	assertEquals 0, cmd.errors.getFieldErrors('accountNum').size()
       	cmd = new EditToCartCommand(billTypeId:1, balId:201, accountNum:"123456",  billNum:null, amount:null)
    	assertFalse cmd.validate()
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:1, balId:201, accountNum:"1234567",  billNum:"1234567", amount:1.23d)
    	assert cmd.validate()

       	// Water/Sewer
       	cmd = new EditToCartCommand(billTypeId:4, balId:201, accountNum:null,  billNum:null, amount:1.23d)
    	assertFalse cmd.validate()
       	assert "EditToCartCommand.billNum.for.water.sewer.missing", cmd.errors.getFieldError('billNumxxx').code
       	assert "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:4, balId:201, accountNum:"12345",  billNum:"ABC123", amount:1.23d)
    	assertFalse cmd.validate()
       	assert "EditToCartCommand.billNum.for.water.sewer.missing", cmd.errors.getFieldError('billNum').code
       	assert "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:4, balId:201, accountNum:"1234567890abd",  billNum:"123457", amount:1.23d)
    	assert cmd.validate()

    	// Parking Ticket
       	cmd = new EditToCartCommand(billTypeId:3, balId:201, accountNum:null,  billNum:null, amount:null)
    	assertFalse cmd.validate()
    	assertEquals 2, cmd.errors.allErrors.size()
       	assertEquals "nullable", cmd.errors.getFieldErrors('amount')[0].code
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:3, balId:201, accountNum:null,  billNum:null, amount:1.23d)
    	assertFalse cmd.validate()
    	assertEquals 1, cmd.errors.allErrors.size()
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:3, balId:201, accountNum:"1234",  billNum:null, amount:1.23d)
    	assertFalse cmd.validate()
    	assertEquals 1, cmd.errors.allErrors.size()
       	assertEquals "validator.invalid", cmd.errors.getFieldErrors('accountNum')[0].code
       	cmd = new EditToCartCommand(billTypeId:3, balId:201, accountNum:"ABC12345",  billNum:null, amount:1.23d)
    	assert cmd.validate()
    	
//       	cmd.errors.allErrors.each {println it}

       	
       	
    }
}
