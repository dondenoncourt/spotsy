import groovy.sql.Sql
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import java.text.SimpleDateFormat;

/** methods that are called in "batch" (currently only writeEchecksToCSV) */
class EchecksService  {
    def grailsApplication
    boolean transactional = true
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    
    // define insert as an attribute so unit tests can deal with the octothorp
    // (a.k.a. hash or pound) that is not supported by Hypersonic SQL but used on the 400
    
/*    
    def insert = """insert into ECHECKS (
        TRNNum,FName,LName,MName,HPhone,WPhone,Email,Addr1,Addr2,City,State,Zip,Cntry,DteAdd,BtypCD,BTYPNM,Amount,BLPAR1,BLPAR2,BLPar3,BLPAR4,PARNM1,PARNM2,PARNM3,PARNM4,FINANB,ACCTNB,SAVCHK,IPADDR,CNFMNB,GLCDE,CART#,CRITM#)
	values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
        """

    def writeEchecksTo400(List checkTrans) {
        log.debug "writing ${checkTrans.size()} check transactions to ECHECKS"
        Sql db = Sql.newInstance(ConfigurationHolder.config.spotsy400.url.toString(),
                                 ConfigurationHolder.config.spotsy400.user.toString(),
                                 ConfigurationHolder.config.spotsy400.pass.toString(),
                                 ConfigurationHolder.config.spotsy400.jdbc.driver.toString())
        def trnnum = db.firstRow ("select max(TRNNUM) as largest from ECHECKS")
        int nextTransNum = trnnum?.largest?.toInteger()?:0
        checkTrans.each{ct ->
            PaymentLine payLine = PaymentLine.get(ct.paymentLineId)
            def parmName1
            def parmName2 
            switch (ct.billTypeId) {
                case 1:
                    parmName1 = 'Current Owner Number'
                    parmName2 = 'Bill Number'
                    break;
                case 3:
                    parmName1 = 'Ticket Number'
                    parmName2 = ''
                    break;
                case 4:
                    parmName1 = 'Account Number'
                    parmName2 = 'Bill Number'
                    break;
                default:
                    parmName1 = 'Account Number'
                    parmName2 = ''
            }
            def billTypeCode = ct.billTypeId.toString().padLeft(2, '0')
            def billTypeName = BillType.get(ct.billTypeId)?.name
            def billParm2 = (payLine?.billNum > 0)?payLine.billNum:''
            db.execute insert,
            //        TRNNum,        FName,       LName,             MName,       HPhone,       WPhone,    Email,       Addr1,           Addr2,    City,    State,    Zip,      Cntry,
            [ ++nextTransNum, ct.firstName, ct.lastName, ct.middleName?:'', ct.homePhone, ct.workPhone, ct.email, ct.address1, ct.address2?:'', ct.city, ct.state, ct.zip, ct.country,
            //         DteAdd,       BtypCD,       BTYPNM,    Amount,
               ct.dateCreated, billTypeCode, billTypeName, ct.amount,
            //          BLPAR1,     BLPAR2,                    BLPar3, BLPAR4,
               payLine?.account, billParm2, ct.lastName?.toUpperCase(),     '',
            //   PARNM1,    PARNM2, PARNM3, PARNM4,
              parmName1, parmName2,     '',     '',
            //     FINANB,        ACCTNB,         SAVCHK,       IPADDR,            CNFMNB,      GLCDE,         CART#,           CRITM# )
            ct.routingNum, ct.accountNum, ct.accountType, ct.ipAddress, ct.confirmationNum, 'SPECIAL',  ct.paymentId, ct.paymentLineId]
            ct.dateSentTo400 = new Date()
            if (!ct.save()) {ct.errors.each {log.error it}}
        }

    }
*/
    /** write all Payment and PaymentLine(s) that have not yet been sent to management via a CSV
     * (as identified with dateSentTo400 in the Check_transaction table)
     * to a CSV (updating dateSentTo400 with the current date) and email the CSV to management.
     */
    String writeEchecksToCSV(List checkTrans) {
        log.debug "writing ${checkTrans.size()} check transactions to a CSV file"
        String csv = ''
        checkTrans.each{ct ->
            PaymentLine payLine = PaymentLine.get(ct.paymentLineId)
            if (!payLine || !payLine.account) {
            	def msg = " check Tran: $ct.id paymentLineId: $ct.paymentLineId not found or account is blank: transaction not added to CSV "
            	log.error(msg)
				try {
					sendMail {
						to ["dondenoncourt@gmail.com","webmaster@spotsylvania.va.us"]// grailsApplication.config.app.error.email.to.addresses.toArray()
						subject "Spotsy Java Web app writeEchecksToCSV error occurred."
						body (msg)
						from grailsApplication.config.app.error.email.from.address
					}
				} catch (Exception e) { log.error "Problem emailing $e.message", e}
            	return // from closure, so go to next checkTrans
            }
            def parmName1
            def parmName2 
            switch (ct.billTypeId) {
                case 1:
                    parmName1 = 'Current Owner Number'
                    parmName2 = 'Bill Number'
                    break;
                case 3:
                    parmName1 = 'Ticket Number'
                    parmName2 = ''
                    break;
                case 4:
                    parmName1 = 'Account Number'
                    parmName2 = 'Location No.'
                    break;
                default:
                    parmName1 = 'Account Number'
                    parmName2 = ''
            }
            def billTypeCode = ct.billTypeId.toString().padLeft(2, '0')
            def billTypeName = BillType.get(ct.billTypeId)?.name
            def billParm2 = (payLine?.billNum > 0)?payLine.billNum:''
            //        TRNNum,        FName,       LName,             MName,       HPhone,       WPhone,    Email,       Addr1,           Addr2,    City,    State,    Zip,      Cntry,
            //        DteAdd,       BtypCD,       BTYPNM,    Amount,
            //        BLPAR1,     BLPAR2,                    BLPar3, BLPAR4,
            //        PARNM1,    PARNM2, PARNM3, PARNM4,
            //        FINANB,        ACCTNB,         SAVCHK,       IPADDR,            CNFMNB,      GLCDE,         CART#,           CRITM# )
            csv += "${ct.id},"
            csv += "${ct.firstName ?ct.firstName ?.replaceAll(',',''):''},"
            csv += "${ct.lastName  ?ct.lastName  ?.replaceAll(',',''):''},"
            csv += "${ct.middleName?ct.middleName?.replaceAll(',',''):''},"
            csv += "${ct.homePhone ?ct.homePhone ?.replaceAll(',',''):''},"
            csv += "${ct.workPhone ?ct.workPhone ?.replaceAll(',',''):''},"
            csv += "${ct.email     ?ct.email     ?.replaceAll(',',''):''},"
            csv += "${ct.address1  ?ct.address1  ?.replaceAll(',',''):''},"
            csv += "${ct.address2  ?ct.address2  ?.replaceAll(',',''):''},"
            csv += "${ct.city      ?ct.city      ?.replaceAll(',',''):''},"
            csv += "${ct.state     ?ct.state     ?.replaceAll(',',''):''},"
            csv += "${ct.zip       ?ct.zip       ?.replaceAll(',',''):''},"
            csv += "${ct.country   ?ct.country   ?.replaceAll(',',''):''},"
            csv += "${dateFormat.format(ct.dateCreated)}.0,${billTypeCode},${billTypeName},${ct.amount},"
            csv += "${payLine?.account},${billParm2},"
            csv += "${ct.lastName  ?ct.lastName  ?.toUpperCase()?.replaceAll(',',''):''},,"
            csv += "${parmName1},${parmName2},,,"
            csv += "${ct.routingNum},${ct.accountNum},${ct.accountType},${ct.ipAddress},${ct.confirmationNum},SPECIAL,${ct.paymentId},${ct.paymentLineId}"
            csv += "\n"
            
            ct.dateSentTo400 = new Date()
	CheckTransaction.withTransaction {	
            if (!ct.save()) {
		ct.errors.each {log.error it}
	    }
	}
        }
        return csv.toString()
    }
    
}
// select btypcd, blpar1,blpar2,blpar4,lname, parnm1,parnm2,parnm4  from coredta10.echecks where btypcd = '01' and parnm1 <> 'Current Owner Number' and Parnm2 <>'Bill Number'
// select btypcd, blpar1,blpar2,blpar4,lname, parnm1,parnm2,parnm4  from coredta10.echecks where btypcd in ('04', '02') and parnm1 <> 'Account Number' and Parnm2 <>''
