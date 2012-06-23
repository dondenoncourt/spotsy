/** Domain class that maps to the payment table. 
 * <p>Note: the payment table was created defined for this application.</p>
 */
class Payment {
    int userNum
    int validationNum
    Date dateCreated
    Date complete
    Date lastUpdated
    int confirmationNum
    List lines

    static hasMany = [lines:PaymentLine]
    static constraints = {
        userNum nullable:true
        complete nullable:true
        validationNum nullable:true
        confirmationNum nullable:true
    }
    String toString() {
        def rtn = "userNum: $userNum lines: "
        lines.each {
            rtn += it
        }
        return rtn
    }
}
