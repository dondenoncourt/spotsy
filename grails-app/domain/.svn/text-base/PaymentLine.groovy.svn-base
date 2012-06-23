/** Domain class that maps to the payment_line table. 
 * <p>Note: the payment_line table was created defined for this application.</p>
 */

class PaymentLine {
    int billTypeId // use enum? 1,2,4 ? personal property, water, parking ticket
    BigDecimal amount
    String account
    int billNum
	long balanceNum
	
    static belongsTo = [payment:Payment]
    static constraints = {
        billNum(nullable:true, validator: {val, obj ->
            if (val && (obj.billTypeId != 1 && obj.billTypeId != 4) ) {
                    return "PaymenLine.billNum.for.real.estate.or.water.sewer.only"
            }
        })
       billTypeId(validator: {val, obj ->
            if ((val == 1 || val == 4) && !obj.billNum) {
                return "PaymenLine.billNum.for.real.estate.or.water.sewer.missing"
            }
        })
    }
    String toString() {
        return "[id: $id, billTypeId: $billTypeId, amount: $amount, account: $account "+(billTypeId == 1?"billNum: $billNum":'')+"]"
    }
}
