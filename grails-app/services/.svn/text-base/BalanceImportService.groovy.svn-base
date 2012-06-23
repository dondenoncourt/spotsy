import groovy.sql.Sql
import java.sql.Timestamp
import org.codehaus.groovy.grails.commons.ConfigurationHolder

import java.text.SimpleDateFormat
import java.util.Date;

class BalanceImportService {
	def sessionFactory
    static SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy hh:mm:ss")
    static SimpleDateFormat mdy = new SimpleDateFormat("MM/dd/yyyy")
	
    boolean transactional = false

    def importBalances() {
    	// most recent get pp, re, ws SIC rows
    	int maxImportNum = BalanceImportControl.withCriteria(uniqueResult:true) {
		    projections {max("balanceImportNum")}
		     eq ('complete', 1)
		}
    	def sicMap = ['01':SystemImportControl.findByBalanceImportNumAndSystemCode(maxImportNum, '01')?.sourceDate, 
    	              '02':SystemImportControl.findByBalanceImportNumAndSystemCode(maxImportNum, '02')?.sourceDate, 
    	              '04':SystemImportControl.findByBalanceImportNumAndSystemCode(maxImportNum, '04')?.sourceDate
    	             ]
    	log.debug "SystemImportControl map: $sicMap"    	   
        Sql sql400 = Sql.newInstance(ConfigurationHolder.config.spotsy400.url.toString(),
                ConfigurationHolder.config.spotsy400.user.toString(),
                ConfigurationHolder.config.spotsy400.pass.toString(),
                ConfigurationHolder.config.spotsy400.jdbc.driver.toString())
    	String select = "select * from epmbalts where systemid = '01'"	    	
    	def balMap = ['01':new Timestamp(sdf.parse(sql400.firstRow ("select * from epmbalts where systemid = '01'")?.lastRun).time),
    				  '02':new Timestamp(sdf.parse(sql400.firstRow ("select * from epmbalts where systemid = '02'")?.lastRun).time),
    				  '04':new Timestamp(sdf.parse(sql400.firstRow ("select * from epmbalts where systemid = '04'")?.lastRun).time)
    		          ]
        log.debug "epmbalts map: $balMap"  
        /* this code checks to see if the import has run recently 
        if (sicMap.'01' == balMap.'01' && sicMap.'02' == balMap.'02' && sicMap.'04' == balMap.'04') {
			log.info "don't bother doing the import, it must have just been done"
        	return 
        }
        */ 
        try {
			BalanceImportControl.withTransaction {
				def bicList = BalanceImportControl.listOrderByBalanceImportNum(max:3, order:"desc") 
				if (bicList.size() == 3) {
					int oldBicNum = bicList[2].balanceImportNum
					Sql mssql = new Sql(sessionFactory.getCurrentSession().connection())
					mssql.execute("delete from BalanceImportControl where balanceImportNum <= ?", [oldBicNum])
					mssql.execute("delete from SystemImportControl  where balanceImportNum <= ?", [oldBicNum])
					mssql.execute("delete from BalanceImport        where balanceImportNum <= ?", [oldBicNum])
					log.info "delete from BalanceImportControl, SystemImportControl, and BalanceImport where balanceImportNum <= $oldBicNum"
				}
			}
        } catch (Exception e) {sendErrorEmail(e)}

    	def now = new Date()
    	// create a new BIC and let the DB gen a new balanceImportNum
		int balanceImportNum = 0
        try {
			BalanceImportControl.withTransaction {
				def bic = new BalanceImportControl(startDate:now, complete:0) 
				boolean ok = bic.save()  
				if (!ok) {
				    bic.errors.allErrors.each { println it.inspect() }
				}
				balanceImportNum = bic.balanceImportNum
			}
	    } catch (Exception e) {sendErrorEmail(e)}
    	doImport(balanceImportNum, '01', balMap.'01', now) 
    	doImport(balanceImportNum, '02', balMap.'02', now) 
    	doImport(balanceImportNum, '04', balMap.'04', now) 

        try {
			BalanceImportControl.withTransaction {
				def bic = BalanceImportControl.findByBalanceImportNum(balanceImportNum)
				bic.finishDate = new Date()
				bic.complete = 1
				bic.save()
				int importTime = bic.finishDate.time - bic.startDate.time
				log.info "BalanceImport took ${(importTime.intdiv(1000).intdiv(60))} minutes ${(  importTime.intdiv(1000).mod(60) )} seconds"
			}
	    } catch (Exception e) {sendErrorEmail(e)}
    }
    private def doImport(int balanceImportNum, String systemCode, Timestamp lastRun, Date now) {
		int sicId 
        try {
			SystemImportControl.withTransaction {
				def sic = new SystemImportControl(systemCode:systemCode, balanceImportNum:balanceImportNum, sourceDate:lastRun, complete:0, lastRecordDate:now)
				boolean ok = sic.save()  
				if (!ok) {
				    sic.errors.allErrors.each { println it.inspect() }
				}
				sicId = sic.systemImportNum
			}
	    } catch (Exception e) {sendErrorEmail(e)}

    	Sql sql400 = Sql.newInstance(ConfigurationHolder.config.spotsy400.url.toString(),
		        ConfigurationHolder.config.spotsy400.user.toString(),
		        ConfigurationHolder.config.spotsy400.pass.toString(),
		        ConfigurationHolder.config.spotsy400.jdbc.driver.toString())
    	Sql msSql = new Sql(sessionFactory.getCurrentSession().connection())

		int maxImportNum = SystemImportControl.withCriteria(uniqueResult:true) {
		    projections {max("balanceImportNum")}
		     eq ('complete', 0)
		     eq ('systemCode', systemCode)
		     eq ('sourceDate', new Timestamp(sdf.parse(sql400.firstRow ("select * from epmbalts where systemid = ?", [systemCode])?.lastRun).time)) 
		}
    	long currentBalanceNum = Balance.withCriteria(uniqueResult:true) {
		    projections {max("balanceNum")}
		}
    	if (!currentBalanceNum || currentBalanceNum > 99999999) {
    		currentBalanceNum = 1
    	} else {
    		currentBalanceNum++
    	}
        List batch = []
    	int recordsProcessed = 0
    	def kountRow = sql400.firstRow("select count(*) from epmbal where SystemID = ? ", [systemCode])
    	log.info "BalanceImport for ${systemCode} about to process ${(kountRow[0])} records"
        try {
			sql400.query ("select * from epmbal where SystemID = ? ", [systemCode]) {rs ->  // fetch first 50 rows only
				while (rs.next()) {
					msSql.execute (
							"""insert into BalanceImport  ( balanceNum, balanceImportNum, systemId, balance, credit, lastPaymentAmnt, lastPaymentDate, firstName, lastName, ppAccount, ppSS1L4, ppSS2L4, reCustomerNum, reParcel, reBillNum, reLegal, wsLocationNum, wsCustomerNum, wsPhone, wsDirectDeb, wsDirectDebDate, ppCareOf, houseNum, preDir, street, suffix, postDir, wsPostQual, apartment, city, state, zip, address1, address2, address3, displayName, ppTaxesPaidForYear, ppTaxesPaidCredit, coOwnerFirstName, coOwnerLastName)  
						                        values ( ?,          ?,                ?,        ?,       ?,      ?,               ?,               ?,          ?,       ?,         ?,       ?,       ?,             ?,        ?,         ?,       ?,             ?,             ?,       ?,           ?,               ?,        ?,        ?,      ?,      ?,      ?,       ?,          ?,         ?,    ?,     ?,   ?,        ?,        ?,        ?,           ?,                  ?,                 ?,                ?) """,  
							[
							currentBalanceNum++,  
							balanceImportNum,
							systemCode,  
							new BigDecimal(rs.getString('balance').trim()?:0g),
							rs.getString('creditBal').trim(),
							new BigDecimal(rs.getString('lastPmnt').trim()?:0g),
							rs.getString('lastPmntDT').trim().size()?new java.sql.Date(mdy.parse(rs.getString('lastPmntDT').trim()).time):null,
							rs.getString('firstName').trim()?:null,
							rs.getString('lastName').trim()?:null,
							new Integer(rs.getString('ppAccount').trim()?:0)?:null,
							new Integer(rs.getString('ppSS1L4').trim()?:0)?:null,
							new Integer(rs.getString('ppSS2L4').trim()?:0)?:null,
							new Integer(rs.getString('reCustomer').trim()?:0)?:null,
							rs.getString('reParcel').trim()?:null,
							new Integer(rs.getString('reBill').trim()?:0)?:null,
							rs.getString('reLegalDes').trim()?:null,
							new Integer(rs.getString('wsLocation').trim()?:0)?:null,
							new Integer(rs.getString('wsCustomer').trim()?:0)?:null,
							rs.getString('wsPhone').trim()?:null,
							rs.getString('wsDirDeb').trim()?:null,
							rs.getString('wsDirDDT').trim().size()?new java.sql.Date(mdy.parse(rs.getString('wsDirDDT').trim()).time):null,
							rs.getString('ppCareOf').trim()?:null,
							new Integer(rs.getString('houseNbr').trim()?:0)?:null,
							rs.getString('preDir').trim()?:null,
							rs.getString('street').trim()?:null,
							rs.getString('suffix').trim()?:null,
							rs.getString('postDir').trim()?:null,
							rs.getString('wsPostQual').trim(),
							rs.getString('apartmt').trim()?:null,
							rs.getString('city').trim()?:null,
							rs.getString('state').trim()?:null,
							rs.getString('zipCode').trim()?:null,
							rs.getString('address1').trim()?:null,
							rs.getString('address2').trim()?:null,
							rs.getString('address3').trim()?:null,
							rs.getString('displayNam').trim()?:null,
							rs.getString('ppTaxPaid').trim()?new BigDecimal(rs.getString('ppTaxPaid').trim()):null,
							rs.getString('ppTPCredit').trim()?:null,
							rs.getString('coFirstNm').trim()?:null,
							rs.getString('coLastNm').trim()?:null
							]
					)
					recordsProcessed++
				}
			} 
		} catch (Exception e) {
			log.error "Exception $e"
			e.printStackTrace()
			sendErrorEmail(e)
		}
        try {
			SystemImportControl.withTransaction {
			    SystemImportControl sic = SystemImportControl.findBySystemImportNum(sicId)
			    sic.recordsProcessed = recordsProcessed
				sic.complete = 1
				sic.dateFinish = new Date()
				sic.save()
				int importTime = sic.dateFinish.time - sic.lastRecordDate.time
				log.info "BalanceImport for ${systemCode} took ${(importTime.intdiv(1000).intdiv(60))} minutes ${(  importTime.intdiv(1000).mod(60) )} seconds"
			}
	    } catch (Exception e) {sendErrorEmail(e)}
    }
    private sendErrorEmail(Exception e) {
    	log.error ("sendErrorEmai: $e")
		try {
			sendMail {
				to ["dondenoncourt@gmail.com"]//,"webmaster@spotsylvania.va.us"]// grailsApplication.config.app.error.email.to.addresses.toArray()
				subject "Spotsy Java Web app balance import error occurred."
				body (e.toString())
				from grailsApplication.config.app.error.email.from.address
			}
		} catch (Exception e2) { log.error "Problem emailing $e2.message", e}

    }
}
