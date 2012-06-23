/**
 * Handlers page requests related to the account lookup portion of the eChecks application.
 * <p>Once an account is selected the PaymentController handles request.
 */
class LookupController {
    def beforeInterceptor = {
        log.debug "action: $actionName params: $params"
        if (!session.userNum) {
            String userNum = params?.pageRef
            if (userNum) {
            	log.debug "userNum $userNum passed from Cold Fusion page redirect"
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

    /** Show all balances on file for the user */
    def index = { 
        def balances = []
        def balCtl 
    	if (session.userNum) { // lookup all UserAccount(s)
	        log.debug "looking up balances for userNum $session.userNum"
            balCtl = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])
    		UserAccount.findAllByUserNum(session.userNum).each {userAccount ->
    	        log.debug "userAccount: ${userAccount?.toString()}"
    	        // real estate
    	        Balance.findAllWhere(reCustomerNum:userAccount?.reCustomerNum, systemId:'01', 
    	                             balanceImportNum:balCtl.balanceImportNum).each {re ->
    	        	balances << re
    	        }
    	        // personal property
                Balance.findAllWhere(ppAccount:userAccount?.ppAccountNum, systemId:'02', 
                                                 balanceImportNum:balCtl.balanceImportNum).each {pp ->
    	        	balances << pp
    	        }
    	        // water/server
    	        Balance.findAllWhere(wsCustomerNum:userAccount?.wsCustomerNum, wsLocationNum:userAccount?.wsLocationNum, 
    	        								systemId:'04', balanceImportNum:balCtl.balanceImportNum).each {ws->
    	        	balances << ws
    	        }
    		}
    	}
        [balances:balances, balCtl:balCtl]
    }

    /** Remove the passed account number from the user's MySpotsy UserAccounts table and redisplay the index page */
	def unlink = {
		def ua 
	    switch (params.systemId) {
	        case '01': // real estate
	        	ua = UserAccount.findByUserNumAndReCustomerNum(session.userNum, params.reCustomerNum.toInteger())
				break
	        case '02': // personal property
				ua = UserAccount.findByUserNumAndPpAccountNum(session.userNum, params.ppAccount.toInteger())
				break
	        case '04': // water sewer
				ua = UserAccount.findWhere(userNum:session.userNum, wsCustomerNum:params.wsCustomerNum.toInteger(), wsLocationNum:params.wsLocationNum.toInteger())
				break
	    }
    	if (ua) {
    		ua.delete()
    		log.debug "UserAccount deleted params: $params"
    	} else {
    		log.error "UserAccount not found for delete params: $params"
    	}
    	redirect action:'index' 
	}
    /** Add the passed account number to the user's MySpotsy UserAccounts table and redisplay the index page */
	def link = {
		def ua
	    switch (params.systemId) {
	        case '01': // real estate
	        	if (UserAccount.findByUserNumAndReCustomerNum(session.userNum, params.reCustomerNum.toInteger()) ) {
		    		log.warn "UserAccount already exists, not added. link params: $params"
		    	} else {
	        		ua = new UserAccount(userNum:session.userNum, reCustomerNum:params.reCustomerNum.toInteger())
	        	}
				break
	        case '02': // personal property
				if (UserAccount.findByUserNumAndPpAccountNum(session.userNum, params.ppAccount.toInteger()) ) { 
		    		log.warn "UserAccount already exists, not added. link params: $params"
		    	} else {
					ua = new UserAccount(userNum:session.userNum, ppAccountNum:params.ppAccount.toInteger())
				}
				break
	        case '04': // water sewer
				if (UserAccount.findWhere(userNum:session.userNum, wsCustomerNum:params.wsCustomerNum.toInteger(), 
											wsLocationNum:params.wsLocationNum.toInteger()) ) {
		    		log.warn "UserAccount already exists, not added. link params: $params"
		    	} else {
					ua = new UserAccount(userNum:session.userNum, wsCustomerNum:params.wsCustomerNum.toInteger(), 
									wsLocationNum:params.wsLocationNum.toInteger()) 
				}
				break
	    }
		if (ua && !ua.save(flush:true)) {
			ua.errors.each {log.error it}
		}

    	redirect action:'index' 
	}
    /** Display the selected lookup page (re, pp, or ws) */
    def selectLookupPage = {
    	flash.message = null
        switch (params.billTypeId ) {
            case '1':
                render (view:'realEstateLookup')
                return
            case '2':
                render (view:'personalPropertyLookup')
                return
            case '4':
                render (view:'waterSewerLookup')
                break
        }
    }

    /** If errors, redisplay the waterSewerLookup page otherwise display the waterSewerBillInfo page with the current balance */
    def lookupWaterSewer = {WaterSewerLookupCommand cmd ->
    	flash.message = null
        if (cmd.hasErrors()) {
            render (view:'waterSewerLookup', model:[cmd:cmd])
            return
        }
        def balCtl = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])

        def balances
        if (cmd.wsCustomerNum && cmd.wsLocationNum) {
            balances = Balance.findAllWhere(wsCustomerNum:cmd.wsCustomerNum.toInteger(), wsLocationNum:cmd.wsLocationNum.toInteger(), systemId:'04', balanceImportNum:balCtl.balanceImportNum)
        } else if (cmd.wsCustomerNumOnly) {
            balances = Balance.findAllWhere(wsCustomerNum:cmd.wsCustomerNumOnly.toInteger(), systemId:'04', balanceImportNum:balCtl.balanceImportNum)
        } 
        if (!balances) {
            flash.message = "No billing information found for selection criteria"
            render (view:'waterSewerLookup',  model:[cmd:cmd])
            return
        }
        render (view:'waterSewerBillInfo', model:[balCtl:balCtl, balances:balances])
    }

    /** If errors, redisplay the realEstateLookup page otherwise display the realEstateBillInfo page with the current balance */
    def lookupRealEstate = {RealEstateLookupCommand cmd ->
    	flash.message = null
        if (cmd.hasErrors()) {
            render (view:'realEstateLookup', model:[cmd:cmd])
            return
        }
        def balCtl = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])
        def balances
        if  (cmd.housenum) {
            balances = Balance.findAllWhere(houseNum:cmd.housenum.toInteger(), street:cmd.street, systemId:'01', balanceImportNum:balCtl.balanceImportNum)
        } else if (cmd.refirstname) {
            balances = Balance.findAllWhere(firstName:cmd.refirstname, lastName:cmd.relastname, systemId:'01', balanceImportNum:balCtl.balanceImportNum)
            if (!balances) {
            	balances = Balance.findAllWhere(coOwnerFirstName:cmd.refirstname, coOwnerLastName:cmd.relastname, systemId:'01', balanceImportNum:balCtl.balanceImportNum)
            }
        } else if (cmd.rebizname) {
            balances = Balance.findAllWhere(lastName:cmd.rebizname, systemId:'01', balanceImportNum:balCtl.balanceImportNum)
        }  else if (cmd.recustomer) {
            balances = Balance.findAllWhere(reCustomerNum:cmd.recustomer.toInteger(), systemId:'01', balanceImportNum:balCtl.balanceImportNum)
        }
        if (!balances) {
            flash.message = "No balances found for selection criteria"
            render (view:'realEstateLookup', model:[cmd:cmd])
            return
        }
        render (view:'realEstateBillInfo', model:[balCtl:balCtl, balances:balances])
    }

    /** If errors, redisplay the personalPropertyLookup page otherwise display the personalPropertyLookup page with the current balance */
    def lookupPersonalProp = {PersonalPropertyLookupCommand cmd ->
    	flash.message = null
        if (cmd.hasErrors()) {
            render (view:'personalPropertyLookup', model:[cmd:cmd])
            return
        }
        def lookupByPpAccount = false
        def balCtl = BalanceImportControl.findByComplete(1, [sort:'finishDate',order:'desc'])
        log.debug "balCtl.balanceImportNum: ${balCtl.balanceImportNum}"
        def balances
        if (params.ppAccount.trim().size() > 0) {
            lookupByPpAccount = true
            balances = Balance.findAllWhere(ppAccount:params.ppAccount.toInteger(), systemId:'02', balanceImportNum:balCtl.balanceImportNum)
        } else {
            balances = Balance.findAllWhere(lastName:params.lastName, ppSS1L4:new Integer(params.ppSS1L4?:0), systemId:'02', balanceImportNum:balCtl.balanceImportNum)
        }
        log.debug "balances: $balances"
        if (balances) {
            render (view:'personalPropertyBillInfo', model:[balCtl:balCtl, balances:balances, lookupByPpAccount:lookupByPpAccount])
        } else {
            flash.message = 'Your search returned no results.<br/>'
            flash.message += '<a href="http://www.spotsylvania.va.us/contactus/feedback.cfm?deptnum=46">You may use this link to contact the Treasurer\'s Office if you are unable to find your account.</a>'
            render (view:'personalPropertyLookup', model:[cmd:cmd])
        }
    }
}
/** validate user entered WS account numbers */
class WaterSewerLookupCommand {
    String wsCustomerNum
    String wsLocationNum
    String wsCustomerNumOnly
    static constraints = {
       wsCustomerNum(validator: {val, obj ->
       		if (obj.wsCustomerNumOnly.size() != 0 && obj.wsCustomerNum.size() != 0) {
                return "spotsy.lookup.only.one"
       		}
            if (obj.wsCustomerNum.size() > 0) {
                obj.wsCustomerNum = obj.wsCustomerNum?.replaceAll(/\D/, {''})
                if (!( obj.wsCustomerNum ==~ /\d{4,12}/ ) ) {
                    return "WaterSewerLookupCommand.wsCustomerNum.all.digits"
                }
            }
       })
       wsLocationNum(validator: {val, obj ->
            if (obj.wsLocationNum.size() > 0 || obj.wsCustomerNum) {
                obj.wsLocationNum = obj.wsLocationNum?.replaceAll(/\D/, {''})
                if (!( obj.wsLocationNum ==~ /\d{4,12}/ ) ) {
                    return "WaterSewerLookupCommand.wsLocationNum.all.digits"
                }
            }
       })
       wsCustomerNumOnly(validator: {val, obj ->
            if (obj.wsCustomerNumOnly.size() > 0) {
                obj.wsCustomerNumOnly = obj.wsCustomerNumOnly?.replaceAll(/\D/, {''})
                if (!( obj.wsCustomerNumOnly ==~ /\d{4,12}/ ) ) {
                    return "WaterSewerLookupCommand.wsCustomerNumOnly.all.digits"
                }
            }
       })
    }
}
/** validate user entered RE account numbers, house num, street, and business name */
class RealEstateLookupCommand {
   String refirstname
   String relastname
   String housenum
   String street
   String recustomer
   String rebizname
   static constraints = {
       housenum(matches:"[0-9]*")
       recustomer(matches:"[0-9]*")
       refirstname (validator:
            {val, obj ->
                if (obj.refirstname == "" &&  obj.relastname == ""
                    &&  obj.housenum == "" &&  obj.street == ""
                    &&  obj.recustomer == "" &&  obj.rebizname == "") {
                    return "spotsy.lookup.at.least.one"
                }
                if ((obj.refirstname != "" &&  obj.relastname != "")
                    &&  (obj.housenum != "" || obj.street != ""
                        || obj.recustomer != ""
                        || obj.rebizname != "") ) {
                        return "spotsy.lookup.only.one"
                }
                if ((obj.housenum != "" &&  obj.street != "")
                    &&  (obj.refirstname != "" || obj.relastname != ""
                        || obj.recustomer != ""
                        || obj.rebizname != "") ) {
                        return "spotsy.lookup.only.one"
                }
                if ((obj.recustomer != "")
                    &&  (obj.housenum != "" || obj.street != ""
                        || obj.refirstname != "" || obj.relastname != ""
                        || obj.rebizname != "") ) {
                        return "spotsy.lookup.only.one"
                }
                if ((obj.rebizname != "")
                    &&  (obj.housenum != "" || obj.street != ""
                        || obj.refirstname != "" || obj.relastname != ""
                        || obj.recustomer != "") ) {
                        return "spotsy.lookup.only.one"
                }
            }
       )
   }
}

/** validate user entered PP account numbers, 4 digit social, and last name */
class PersonalPropertyLookupCommand {
    String lastName
    String ppSS1L4
    String ppAccount

    static constraints = {
       ppAccount(matches:"[0-9]*")
       ppSS1L4(matches:"[0-9]*")
       lastName (validator:
            {val, obj ->
                if (!obj.ppAccount && !obj.lastName) {
                    return "spotsy.lookup.at.least.one"
                }
                if (obj.ppAccount && obj.lastName) {
                    return "spotsy.lookup.only.one"
                }
            }
       )
    }
}
