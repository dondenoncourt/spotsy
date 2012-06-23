import grails.test.*

class PaymentTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }
    void testConstraints() {
        mockDomain(Payment)
        mockDomain(PaymentLine)
        Payment pay = new Payment(userNum:1)
        PaymentLine line = new PaymentLine(billTypeId:1,amount:1.23g, account:'1234', billNum:4321)
        pay.addToLines(line)
        assertNotNull pay.save()
        pay = new Payment(userNum:2)
        line = new PaymentLine(billTypeId:1,amount:4.56g, account:'4444')
        pay.addToLines(line)
        line.validate()
        assertEquals('billTypeId', line.errors.fieldErrors[0].field)
        assertTrue(line.errors.fieldErrors[0].toString().contains("PaymentLine.billTypeId.PaymenLine.billNum.for.real.estate.or.water.sewer.missing") )
        line = new PaymentLine(billTypeId:2,amount:1.23g, account:'1234', billNum:4321, payment:pay)
        line.validate()
        assertEquals('billNum', line.errors.fieldErrors[0].field)
        assertTrue(line.errors.fieldErrors[0].toString().contains("PaymenLine.billNum.for.real.estate.or.water.sewer.only") )


    }

    void testRelationships() {
        mockDomain(Payment)
        mockDomain(PaymentLine)
        Payment pay = new Payment(userNum:1)
        PaymentLine line = new PaymentLine(billTypeId:1,amount:1.23g, account:'1234', billNum:4321)
        pay.addToLines(line)
        if (!pay.save()) {
            pay.errors.each {it-> println it}
            fail("should have saved OK: $pay")
        }
        line = new PaymentLine(billTypeId:2,amount:3.32g, account:'4321')
        pay.addToLines(line)
        assert pay.save(flush:true)
        assertEquals(2, pay.lines.size())
        assertEquals(java.util.ArrayList.class, pay.lines.class)
        assertEquals(PaymentLine.class,pay.lines[0].class)
        assertEquals(1, pay.lines[0].billTypeId)
        assertEquals(2, pay.lines[1].billTypeId)
        assertEquals(1.23g, pay.lines[0].amount)
        assertEquals('4321', pay.lines[1].account)
        assertEquals('userNum: 1 lines: [billTypeId: 1, amount: 1.23, account: 1234 billNum: 4321][billTypeId: 2, amount: 3.32, account: 4321 ]'.toString(),
            pay.toString())
    }
}
