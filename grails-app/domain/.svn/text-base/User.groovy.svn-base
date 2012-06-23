/** Domain class that maps to the users table. */
class User {
    int userNum
    String userName
    String password
    String email
    String firstName
    String lastName
    String middleName
    String address1
    String address2
    String city
    String state
    String zip
    int districtNum
    int countryNum 
    String homePhone
    String workPhone
    int preferHTML
    int confirmed
    float confirmationNum
    Date dateAdded
    String registeredIP
    float sessionNum

    static constraints = {
        address1 nullable:true
        address2 nullable:true
        city nullable:true
        state nullable:true
        firstName nullable:true
        lastName nullable:true
        zip nullable:true
        districtNum nullable:true
        countryNum nullable:true
        homePhone nullable:true
        workPhone nullable:true
        preferHTML nullable:true
        confirmed nullable:true
        confirmationNum nullable:true
        dateAdded nullable:true
        registeredIP nullable:true
	sessionNum nullable:true
    }

    static mapping = {
        table 'users'
        version false
        id column: 'userNum', name:'userNum',generator:'assigned'
        userNum column: 'userNum'
        userName column: 'userName'
        password column: 'password'
        email column: 'email'
        firstName column: 'firstName'
        lastName column: 'lastName'
        middleName column: 'middleName'
        address1 column: 'address1'
        address2 column: 'address2'
        city column: 'city'
        state column: 'state'
        zip column: 'zip'
        districtNum column: 'districtNum'
        countryNum column: 'countryNum'
        homePhone column: 'homePhone'
        workPhone column: 'workPhone'
        preferHTML column: 'preferHTML'
        confirmed column: 'confirmed'
        confirmationNum column: 'confirmationNum'
        dateAdded column: 'dateAdded'
        registeredIP column: 'registeredIP'
        sessionNum column: 'sessionNum'
    }
}
