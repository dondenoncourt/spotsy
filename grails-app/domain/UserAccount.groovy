/** Domain class that maps to the UserAccounts table. */
class UserAccount {
    Long userAccountNum = 0
    Long userNum
    Integer reCustomerNum
    Integer ppAccountNum
    Integer wsLocationNum
    Integer wsCustomerNum
    
    static constraints = {
        reCustomerNum nullable:true
        ppAccountNum nullable:true
        wsLocationNum nullable:true
        wsCustomerNum nullable:true
    }

    String toString () {"userAccountNum: ${userAccountNum} reCustomerNum: ${reCustomerNum} ppAccountNum: ${ppAccountNum} wsLocationNum: ${wsLocationNum} wsCustomerNum: ${wsCustomerNum}"}

    static mapping = {
            table 'UserAccounts'
            version false
            id column:'userAccountNum', name:'userAccountNum' //, generator:'assigned'
            userAccountNum column:'userAccountNum'
            userNum column:'UserNum'
            reCustomerNum column:'RECustomerNum'
            ppAccountNum column:'PPAccountNum'
            wsLocationNum column:'WSLocationNum'
            wsCustomerNum column:'WSCustomerNum'
    }
}
