/** Domain class that maps to the BalanceImport table. */
class Balance implements Serializable {
	
	long balanceNum
	Integer balanceImportNum
	String systemId
	BigDecimal balance
	String credit
	BigDecimal lastPaymentAmnt
	Date lastPaymentDate
	String firstName
	String lastName
	Integer ppAccount
	Integer ppSS1L4
	Integer ppSS2L4
	Integer reCustomerNum
	String reParcel
	Integer reBillNum
	String reLegal
	Integer wsLocationNum
	Integer wsCustomerNum
	String wsPhone
	String wsDirectDeb
	Date wsDirectDebDate
	String ppCareOf
	Integer houseNum
	String preDir
	String street
	String suffix
	String postDir
	String wsPostQual
	String apartment
	String city
	String state
	String zip
	String address1
	String address2
	String address3
	String displayName
	BigDecimal ppTaxesPaidForYear
	String ppTaxesPaidCredit
	String coOwnerFirstName
	String coOwnerLastName

    static constraints = {
	balanceImportNum(nullable:false)
	balance(nullable:false,scale:2)
	credit(nullable:true,size:0..5)
    systemId(nullable:false,size:0..2)
	lastPaymentAmnt(nullable:true,scale:2)
	lastPaymentDate(nullable:true)
	firstName(nullable:true,size:0..50)
	lastName(nullable:true,size:0..50)
	ppAccount(nullable:true)
	ppSS1L4(nullable:true)
	ppSS2L4(nullable:true)
	reCustomerNum(nullable:true)
	reParcel(nullable:true,size:0..20)
	reBillNum(nullable:true)
	reLegal(nullable:true)
	wsDirectDeb(size:0..50)
	wsLocationNum(nullable:true)
	wsCustomerNum(nullable:true)
	wsPhone(nullable:true,size:0..50)
	wsDirectDeb(nullable:true)
	wsDirectDebDate(nullable:true)
	ppCareOf(nullable:true,size:0..50)
	houseNum(nullable:true)
	preDir(nullable:true,size:0..5)
	street(nullable:true,size:0..50)
	suffix(nullable:true,size:0..5)
	postDir(nullable:true,size:0..5)
	wsPostQual(nullable:true,size:0..5)
	apartment(nullable:true,size:0..5)
	city(nullable:true,size:0..50)
	state(nullable:true,size:0..5)
	zip(nullable:true,size:0..15)
	address1(nullable:true,size:0..50)
	address2(nullable:true,size:0..50)
	address3(nullable:true,size:0..50)
	displayName(nullable:true,size:0..50)
	ppTaxesPaidForYear(nullable:true,scale:2)
	ppTaxesPaidCredit(nullable:true,size:0..2)
	coOwnerFirstName(nullable:true,size:0..50)
	coOwnerLastName(nullable:true,size:0..50)
   }
	static mapping = {
		table 'BalanceImport'
		version false
		id column:'balanceNum',name:'balanceNum',generator:'assigned'
		balanceNum column:'balanceNum'
		balanceImportNum column:'balanceImportNum'
		systemId column:'systemId'
		balance column:'balance'
		credit column:'credit'
		lastPaymentAmnt column:'lastPaymentAmnt'
		lastPaymentDate column:'lastPaymentDate'
		firstName column:'firstName'
		lastName column:'lastName'
		ppAccount column:'ppAccount'
		ppSS1L4 column:'pPSS1L4'
		ppSS2L4 column:'pPSS2L4'
		reCustomerNum column:'rECustomerNum'
		reParcel column:'reParcel'
		reBillNum column:'reBillNum'
		reLegal column:'reLegal'
		wsLocationNum column:'wSLocationNum'
		wsCustomerNum column:'wSCustomerNum'
		wsPhone column:'wSPhone'
		wsDirectDeb column:'wSDirectDeb'
		wsDirectDebDate column:'wSDirectDebDate'
		ppCareOf column:'pPCareOf'
		houseNum column:'houseNum'
		preDir column:'preDir'
		street column:'street'
		suffix column:'suffix'
		postDir column:'postDir'
		wsPostQual column:'wSPostQual'
		apartment column:'apartment'
		city column:'city'
		state column:'state'
		zip column:'zip'
		address1 column:'address1'
		address2 column:'address2'
		address3 column:'address3'
		displayName column:'displayName'
		ppTaxesPaidForYear column:'pPTaxesPaidForYear'
		ppTaxesPaidCredit column:'pPTaxesPaidCredit'
		coOwnerFirstName column:'coOwnerFirstName'
		coOwnerLastName column:'coOwnerLastName'
	}
        String toString() {
            [balanceNum:balanceNum,balanceImportNum:balanceImportNum,systemId:systemId,balance:balance,credit:credit,lastPaymentAmnt:lastPaymentAmnt,lastPaymentDate:lastPaymentDate,firstName:firstName,lastName:lastName,ppAccount:ppAccount,ppSS1L4:ppSS1L4,ppSS2L4:ppSS2L4,houseNum:houseNum,street:street,  suffix:suffix,city:city,state:state,zip:zip,address1:address1,address2:address2,address3:address3,displayName:displayName,ppTaxesPaidForYear:ppTaxesPaidForYear,ppTaxesPaidCredit:ppTaxesPaidCredit,coOwnerFirstName:coOwnerFirstName,coOwnerLastName:coOwnerLastName]
	}

}
