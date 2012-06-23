import javax.servlet.http.Cookie

import groovy.sql.Sql

/**
 * Handlers page requests related to the payment portion of the eChecks application.
 */
class PaymentController {

	static def stateList = ['AL':'Alabama','AK':'Alaska','AZ':'Arizona','AR':'Arkansas','CA':'California','CO':'Colorado','CT':'Connecticut','DC':'District of Columbia','FL':'Florida','GA':'Georgia','HI':'Hawaii','ID':'Idaho','IL':'Illinois','IN':'Indiana','IA':'Iowa','KS':'Kansas','KY':'Kentucky','LA':'Louisiana','ME':'Maine','MD':'Maryland','MA':'Massachusetts','MI':'Michigan','MN':'Minnesota','MS':'Mississippi','MO':'Missouri','MT':'Montana','NE':'Nebraska','NV':'Nevada','NH':'New Hampshire','NJ':'New Jersey','NM':'New Mexico','NY':'New York','NC':'North Carolina','ND':'North Dakota','OH':'Ohio','OK':'Oklahoma','OR':'Oregon','PA':'Pennsylvania','RI':'Rhode Island','SC':'South Carolina','SD':'South Dakota','TN':'Tennessee','TX':'Texas','UT':'Utah','VT':'Vermont', 'VA':'Virginia','WA':'Washington','WV':'West Virginia','WI':'Wisconsin','WY':'Wyoming']
    static def actTypList = ['1':'Checking Account', '2':'Savings Account']
    def beforeInterceptor = {
        log.debug("action: $actionName params: $params")
        if (!session.userNum) {
            String userNum = params?.pageRef
            if (userNum) {
                session.userNum = userNum.toLong()
            }
        }
		if (!session.userNum) { // still not there, see if MySpotsy added the cookie
			String userNum = g.cookie(name:'MYSPOTSYUSERNUM')
			if (userNum) {
				session.userNum = userNum.toLong()
			}
		}
				
    }
    def afterInterceptor = {model ->
        log.debug("action: $actionName model: $model")
    }

    def sessionFactory

    /**
     * Look for a cookie called 'MYSPOTSYUSERNUM' (set by the MySpotsy app)
     * and adds that cookie to the HTTP path of this application
     */
    def login = {
        String userNum = g.cookie(name:'MYSPOTSYUSERNUM')
        if (!userNum) {
            def c = new Cookie('MYSPOTSYUSERNUM', params.userNum)
            c.path = '/'
            response.addCookie(c)
            userNum = params.userNum
        }
        session.userNum = userNum.toLong()
    }

	/** Display the list of all payment types (with a graphic in the bill_type table */
    def payments = {
        def billTypes = BillType.list()
        render view:'payments', model:[billTypes:billTypes]
    }

	/** display the edit page with attributes specific to the selected bill type */
    def itemdetails = {
        BillType billType = BillType.get(params.billTypeId)
        def balances = []
        if (session.userNum) {
        	balances = getBalances(billType.id)
        }
        render (view:'edit', model:[billType:billType, balances:balances, doNotValidateAccount:params.doNotValidateAccount?true:false])
    }
    /**
     * invoked by personal prop, real estate, and water/sewer bill info pages "Pay This Bill" button.
     * Takes the user selected account numbers, retrieves balance information,
     * adds that to the user's session, and displays the edit page
     */
    def transtocart = {
        Balance bal = Balance.findByBalanceNum(params.balanceNum) 
        log.debug "bal: ${bal}"
        BillType billType = BillType.get(bal.systemId.toInteger() )

        def account
        def billNum
        switch (billType.id) {
            case  1: // real estate
                account = bal.reCustomerNum
                billNum = bal.reBillNum
                break
            case  2: // personal property
                account = bal.ppAccount
                break
            case  4: // water/sewer
                account = bal.wsCustomerNum
                billNum = bal.wsLocationNum
                break
        }
        def balances = []
        if (session.userNum) {
		balances = getBalances(billType.id)
        }
        BigDecimal amount = (bal.credit && bal?.credit == 'CR')? 0 : (bal.balance > 0? bal.balance:bal.balance.multiply(-1))
        session.bal = bal
        EditToCartCommand cmd = new EditToCartCommand(billTypeId:billType.id, accountNum:account, billNum:billNum, amount:amount, balId:bal.balanceNum)
        render (view:'edit', model:[bal:bal, cmd:cmd, billType:billType, balances:balances])
    }
    private List getBalances(def billTypeId) {
        def balCtl = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])
        def balances = []
	UserAccount.findAllByUserNum(session.userNum).each {userAccount ->
		switch (billTypeId) {
		case  1: // real estate
			Balance.findAllWhere(reCustomerNum:userAccount.reCustomerNum, systemId:'01', 
		    balanceImportNum:balCtl.balanceImportNum).each {re -> balances << re }
		    break
		case  2: // personal property
			Balance.findAllWhere(ppAccount:userAccount.ppAccountNum, systemId:'02', 
		    balanceImportNum:balCtl.balanceImportNum).each {pp -> balances << pp }
		    break
		case  4: // water/sewer
			Balance.findAllWhere(wsCustomerNum:userAccount.wsCustomerNum, wsLocationNum:userAccount.wsLocationNum, 
						systemId:'04', balanceImportNum:balCtl.balanceImportNum).each {ws-> balances << ws }
		    break
		}
	}
	return balances
    }
	/** Takes the user entered account and payment and checks for duplication payment, 
	 *  If there is an existing payment, show an error and return to the edittocart page.
	 *  Otherwise, create Payment and associated PaymentLine(s) objects in the user's 
	 *  session to hold their payment in transient memory until the confirmation page.
	 *  Then display the viewcart page.
	 */
    def edittocart = {EditToCartCommand cmd ->
    	flash.message = null
        if (cmd.hasErrors()) {
            render (view:'edit', model:[cmd:cmd, billType: BillType.get(cmd.billTypeId)])
            return
        }
		Sql sql = new Sql(sessionFactory.getCurrentSession().connection())

		boolean dup = false
    	String select = """select p.confirmation_num, pl.account 
    	                     from payment p 
    	                     inner join payment_line pl 
    	                             on p.id = payment_id 
    	                     inner join check_transaction ct 
    	                             on ct.confirmation_num = p.confirmation_num 
    	                     where  pl.account = ${cmd.accountNum} 
                               and  pl.bill_num = ${cmd.billNum}
                               and  ct.date_sent_to400 is NULL
                               and  pl.bill_Type_Id = ${cmd.billTypeId}; """	
        log.debug "checking for duplicate payment with: $select"                               
        sql.eachRow (select) {dup = it as boolean}
                          
        if (!dup && session.payment) {
        	session.payment.lines.each {line ->
                int billNum = cmd.billNum?cmd.billNum.toInteger():0
                if (line.account ==  cmd.accountNum && line.billNum == billNum) {
                	dup = true
                }
            }
        }
		
    	if (dup) {
			flash.message = "This bill has already been selected for payment."
   			flash.alreadySubmitted = true
			render (view:'edit', model:[cmd:cmd, billType: BillType.get(cmd.billTypeId)])
	        return
    	}
    	if (!cmd.balId) {
            def balCtl = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])
            def bal
            switch (cmd.billTypeId) {
            	case  1: // real estate
			    	bal = Balance.findWhere(systemId:'01', balanceImportNum:balCtl.balanceImportNum, 
                                                        reCustomerNum:cmd.accountNum?cmd.accountNum.toInteger():0, 
                                                        reBillNum:cmd.billNum?cmd.billNum.toInteger():0)
	                break
	            case  2: // personal property
	            	bal = Balance.findWhere(systemId:'02', balanceImportNum:balCtl.balanceImportNum, 
                                                ppAccount:cmd.accountNum?cmd.accountNum.toInteger():0)
	                break
	            case  4: // water/sewer
	            	bal = Balance.findWhere(systemId:'04', balanceImportNum:balCtl.balanceImportNum,  
                                                wsCustomerNum:cmd.accountNum?cmd.accountNum.toInteger():0,
                                                wsLocationNum:cmd.billNum?cmd.billNum.toInteger():0)
	                break
            }
            if ([1,2,4].find {it == cmd.billTypeId} ) {
            	if (!bal && !params.doNotValidateAccount) {
        			flash.message = "Invalid account number: ${cmd.accountNum} ${cmd.billNum}"
    				render (view:'edit', model:[cmd:cmd, billType: BillType.get(cmd.billTypeId)])
    		        return
            	}
				if (bal) {
					cmd.balId = bal.balanceNum
				}
            }
    	}
        Payment pay = session.payment
        if (!pay) {
            pay = new Payment(userNum:session.userNum)  
            session.payment = pay
        }
        PaymentLine line = new PaymentLine(billTypeId:cmd.billTypeId,amount:cmd.amount, account:cmd.accountNum, billNum:cmd.billNum, balanceNum:cmd.balId)
        pay.addToLines(line)
        if (!pay.save()) {
            pay.errors.each {log.error it}
            flash.message = "unexpected error creating a payment"
            render (view:'edit', model:[cmd:cmd, billType:BillType.get(cmd.billTypeId)])
            return
        }
        log.debug pay
		redirect action:'viewcart',params:[id:session?.payment?.id]
    }
    /** Display all Payment and associated Payment(s) transient ('cart') information with the view page */
    def viewcart = {
    	if (params.id) {
/*TODO sometimes gives: 
        "Provided id of the wrong type for class Payment. Expected: class java.lang.Long, got class java.lang.String"
        so  Payment.get(params.id.toLong())?

*/
    		session.payment = Payment.get(params.id)
    	}
        render (view:'view', model:[pay:session.payment])// , bal:session.bal] ) get with paymentLine's transient balanceNum
    }
    /** remove a line item as selected from a link in the viewcart page */
    def removeitem = {
        PaymentLine line = PaymentLine.get(params.id)
        if (line) {
			def checkTran = CheckTransaction.findByPaymentLineId(params.id)
			if (checkTran) {
				flash.message = "Payment $line already submitted with confirmation no: $checkTran.confirmationNum, remove not allowed."
			} else {
	        	log.debug("deleting PaymentLine: "+line)
	        	line.delete()
	        	session.payment = Payment.get(line.payment.id)
	            session.payment?.removeFromLines(line)
	      		session.payment?.lines?.remove(line)
			}
        }
		redirect action:'viewcart',params:[id:session?.payment?.id]
    }

    /** Begin the checkout process by retrieving the user info from the users table 
     * and prompt the user in the checkout page 
     */
    def checkout = {
        UserInfoCommand cmd = new UserInfoCommand()
        if (session.userNum) {
            log.debug "fill user info from User.findByUserNum(${session.userNum})"
            def user = User.findByUserNum(session.userNum)
            if (user && !cmd.lastName) {
                cmd.lastName = user.lastName
                cmd.firstName = user.firstName
                cmd.middleName = user.middleName
                cmd.homePhone = user.homePhone
                cmd.workPhone = user.workPhone
                cmd.email = user.email
                cmd.address1 = user.address1
                cmd.address2 = user.address2
                cmd.city = user.city
                cmd.state = user.state
                cmd.zip = user.zip
            }
        }
        render (view:'checkout', model:[cmd:cmd])
    }
    /** display the preview page, unless there are errors in the user entries for the changepersonal page
     * in which case, the changepersonal page is displayed. 
     */
    def preview = {UserInfoCommand cmd ->
       if (cmd.hasErrors()) {
            render (view:'changepersonal', model:[cmd:cmd])
            return
        }
        render (view:'preview', model:[cmd:cmd])
    }
    /** display the preview page, unless there are errors in the user info,  
     * in which case, the changepersonal page is displayed. 
     */
    def changepersonal = {UserInfoCommand cmd ->
       if (cmd.hasErrors() || params.edit) {
            render (view:'changepersonal', model:[cmd:cmd])
            return
        }
        render (view:'preview', model:[cmd:cmd])
    }

    /**  commit the Payment and PaymentLine(s) data that is in transient memory to the 
     * payment and payment_lines tables. And display the finalsubmit page.
     */
    def submitpayment = {UserInfoCommand cmd ->

    	def alreadySubmitted = false
		withForm {
		}.invalidToken {
    		if (!params.unittesting) {
    			alreadySubmitted = true
    		}
		}
		if (alreadySubmitted) {
			render view:'/index'
			return
		}
		
    	Payment pay = session.payment
        if (!pay || !pay.lines.size()) {
            flash.message = "There are no payments to submit"
            render (view:'preview', model:[cmd:cmd])
            return
        }
        pay.complete = new Date()
        pay.confirmationNum = Math.abs(new Random().nextInt())
        log.debug "confirmationNum: ${pay.confirmationNum}"
        pay.save()
        pay.lines.each { line -> 
            def props = cmd.properties //[lastName:cmd.lastName, firstName:cmd.firstName, middleName:cmd.middleName, homePhone:cmd.homePhone, workPhone:cmd.workPhone, email:cmd.email, address1:cmd.address1, address2:cmd.address2, city:cmd.city, state:cmd.state, zip:cmd.zip, country:cmd.country, routingNum:cmd.routingNum, accountNum:cmd.accountNum, accountType:cmd.accountType]
            props += [paymentId:pay.id, confirmationNum:pay.confirmationNum]
            props += [paymentLineId:line.id, billTypeId:line.billTypeId, amount:line.amount]
            props.ipAddress = request.remoteAddr
            def trans = new CheckTransaction(props)
            if (!trans.save()) { 
                trans.errors.each { log.error it }
                flash.message = "unexpected error creating a check transaction"
            }
            log.debug trans.dump()
        }
        if (flash.message) {
            render (view:'changepersonal', model:[cmd:cmd])
            return
        }

        session.payment = null 
        session.bal = null
        render (view:'finalsubmit', model:[cmd:cmd, payment:pay])
    }

 }

/**
 * Validate edittocart user input: accountNum, billNum, and amount.
 */
class EditToCartCommand {
    int billTypeId
    String accountNum // digits constraints based on billTypeId
    String billNum // required if billTypeId is 1
    BigDecimal amount
    long balId
    
    String toString() { return "EditToCartCommand billTypeId: $billTypeId, accountNum: $accountNum, billNum: $billNum"}

    static constraints = {
       billTypeId(min:1, validator: {val, obj ->
	       return (BillType.get(val) != null)
       })
        /* validation from the previously used ItemParameters "data types" table */
       accountNum (blank:false, validator: {val, obj ->
            def bt = BillType.get(obj.billTypeId)
            if (bt) {
	            obj.accountNum = obj.accountNum?.replaceAll(/\D/, {''})
	            return obj.accountNum?.size() >= bt.minActDigits && obj.accountNum?.size() <= bt.maxActDigits
            }
       })
       billNum(validator: {val, obj ->
            if (obj.billTypeId == 1) {
                if (!val) return 'EditToCartCommand.billNum.for.real.estate.missing'
                obj.billNum = obj.billNum?.replaceAll(/\D/, {''})
                return obj.billNum ==~ /\d{1,7}/
            }
            if (obj.billTypeId == 4) {
                if (!val) return 'EditToCartCommand.billNum.for.water.sewer.missing'
                obj.billNum = obj.billNum?.replaceAll(/\D/, {''})
                return obj.billNum ==~ /\d{1,7}/
            }
       })
       amount(nullable:false, min:0.01g)
    }
 }
/**
 * Validate user info: routingNum, accountNum, account type, and phone numbers 
 */
class UserInfoCommand {
    String lastName
    String firstName
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
    String routingNum2
    String accountNum
    String accountNum2
    String accountType

    static constraints = {
       email blank:false, email:true
       firstName blank:false
       lastName blank:false
       city blank:false
       state blank:false, minSize:2
       address1 blank:false
       country blank:false  //TODO convert ISO 3-digit countries to integer?
       zip blank:false, matches:/^\d{5}(-?\d{4})?$/
       routingNum (blank:false, matches:/^\d{9}$/, validator: {val, obj ->
       	  val = val?.replaceAll(/\D/, {''})
          if (val?.size() < 9) return false
          def n = 0;
          for (def i = 0; i < val.size(); i += 3) {
            n += val[i].toInteger() * 3
            n += val[i + 1].toInteger() * 7
            n += val[i + 2].toInteger();
          }
          return (n != 0 && n % 10 == 0)
       })
       routingNum2 (validator: {val, obj ->
               return val == obj.routingNum
       })
       accountNum blank:false, minSize:4
       accountNum2 (validator: {val, obj ->
               return val == obj.accountNum
       })
       accountType blank:false
       homePhone blank:false,  matches:/^(\d-?)?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$/
       workPhone blank:false,  matches:/^(\d-?)?\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$/
    }

 }
