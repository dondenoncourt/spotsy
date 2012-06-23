/** Domain class that maps to the check_transaction table. 
 * <p>Note: the check_transaction table was created defined for this application.</p>
*/
class CheckTransaction {
    int paymentId
    int paymentLineId
    int billTypeId
    int accountType
    long confirmationNum
    BigDecimal amount
    String firstName
    String lastName
    String middleName
    String homePhone
    String workPhone
    String email
    String address1
    String address2
    String city
    String state
    String zip
    String country
    String routingNum
    String accountNum
    Date dateSentTo400
    Date dateCreated
    String ipAddress

    static constraints = {
        firstName blank:false
        middleName nullable:true
        lastName blank:false
        address1 blank:false
        address2 nullable:true
        city blank:false
        state blank:false, minSize:2
        zip blank:false, matches:/^\d{5}(-?\d{4})?$/
        country blank:false  //TODO convert ISO 3-digit countries to integer?
        email blank:false, email:true
        accountNum blank:false, minSize:4
        accountType blank:false, inList:[1,2]
        homePhone blank:false,  matches:/^(\d-?)?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$/
        workPhone blank:false,  matches:/^(\d-?)?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$/
        dateSentTo400 nullable:true
        routingNum (blank:false, matches:/^\d{9}$/, validator: {val, obj ->
          if (val?.size() < 9) return false
          def n = 0;
          for (def i = 0; i < val.size(); i += 3) {
            n += val[i].toInteger() * 3
            n += val[i + 1].toInteger() * 7
            n += val[i + 2].toInteger();
          }
          return (n != 0 && n % 10 == 0)
        })
        ipAddress blank:false
    }
    String toString() {
        "paymentId: $paymentId, paymentLineId: $paymentLineId, billTypeId $billTypeId confirmationNum: $confirmationNum $firstName $lastName"
    }

}
