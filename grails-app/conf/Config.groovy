/* locations to search for config files that get merged into the main config
 * config files can either be Java properties files or ConfigSlurper scripts

 * grails.config.locations = [ "classpath:${appName}-config.properties",
 *                             "classpath:${appName}-config.groovy",
 *                             "file:${userHome}/.grails/${appName}-config.properties",
 *                             "file:${userHome}/.grails/${appName}-config.groovy"]
 *
 * if(System.properties["${appName}.config.location"]) {
 *    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
 * }
 */

grails {
    mail {
        host = "172.16.2.239"
        port =  25
    }
}

checkTranUploadJobCron="0 3 0 * * ?" // 0:03AM MON-FRI probably should be "0 3 0 * 1-5 ?"
importJobCron="0 1 7,19 * * ?" // 7:01 AM and 7:01 PM  
//checkTranUploadJobCron="0 0 1 1 * ?" // jan 1
//importJobCron="0 0 1 1 * ?" // jan 1

grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]
/* The default codec used to encode data with ${} */
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"

/* enabled native2ascii conversion of i18n properties files */
grails.enable.native2ascii = true

spotsy400.ip="172.16.2.1"
spotsy400.user="epayment"
spotsy400.pass="epayadmin"
spotsy400.jdbc.driver="com.ibm.as400.access.AS400JDBCDriver"

echeck.append.email.to.addresses=["KCatlett@spotsylvania.va.us","LBenn@spotsylvania.va.us","TJett@spotsylvania.va.us","RAshley@spotsylvania.va.us", "webmaster@spotsy"]
echeck.append.email.copy.address="webmaster@spotsylvania.va.us"
echeck.append.email.from.address="treas@spotsylvania.va.us"

app.error.email.to.addresses=["dondenoncourt@gmail.com"]
app.error.email.from.address="webmaster@spotsylvania.va.us"


/* set per-environment serverURL stem for creating absolute links */
environments {
    production {
        grails.serverURL = "http://www.changeme.com"
        spotsy400.url="jdbc:as400://172.16.2.1/COREDTA10" // COREDTA10 is true production COREGEN is test
/* begin for test       
        echeck.append.email.to.addresses=["dondenoncourt@gmail.com"]
        echeck.append.email.from.address="dondenoncourt@gmail.com"
        app.error.email.to.addresses=["dondenoncourt@gmail.com"]
        app.error.email.from.address="dondenoncourt@gmail.com"
// end for test        */
    }
    development {

       // comment the following spotys400 to use the 400 default settings for upload test
        spotsy400.url="jdbc:mysql://localhost/spotsy"
        spotsy400.user="root"
        spotsy400.pass="*pure!choice"
        spotsy400.jdbc.driver="com.mysql.jdbc.Driver"

        echeck.append.email.to.addresses=["dondenoncourt@gmail.com"]
        echeck.append.email.from.address="dondenoncourt@gmail.com"
        app.error.email.to.addresses=["dondenoncourt@gmail.com"]
        app.error.email.from.address="dondenoncourt@gmail.com"

        // comment the following for Spotsy test
//        grails.mail.host = "smtp.gmail.com"
//        grails.mail.port = 465
//        grails.mail.username = "dondenoncourt@gmail.com"
//        grails.mail.password = "vo2max"
//        grails.mail.props = ["mail.smtp.auth":"true",
//                             "mail.smtp.socketFactory.port":"465",
//                             "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
//                             "mail.smtp.socketFactory.fallback":"false"
//                             ]
        
    }
    test {
        spotsy400.url="jdbc:hsqldb:mem:testDb"
        spotsy400.user="sa"
        spotsy400.pass=""
        spotsy400.jdbc.driver="org.hsqldb.jdbcDriver"

        echeck.append.email.to.addresses=["dondenoncourt@gmail.com", "dondenoncourt@gmail.com"]
        echeck.append.email.from.address="dondenoncourt@gmail.com"
        echeck.append.email.copy.address="dondenoncourt@gmail.com"

        app.error.email.to.addresses=["dondenoncourt@gmail.com","dondenoncourt@gmail.com"]
        app.error.email.from.address="dondenoncourt@gmail.com"

        grails.mail.host = "smtp.gmail.com"
        grails.mail.port = 465
        grails.mail.username = "dondenoncourt@gmail.com"
        grails.mail.password = "vo2max"
        grails.mail.props = ["mail.smtp.auth":"true",
                             "mail.smtp.socketFactory.port":"465",
                             "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                             "mail.smtp.socketFactory.fallback":"false"
                             ]
    }
}

log4j = {
    appenders {
            rollingFile name:"spotsyLogFile", file:"spotsyjava.log", maxFileSize:'10MB', append:false, layout: pattern(conversionPattern: '%-5p %c{1} %d{dd MMM HH:mm:ss} %m%n')
    }
    debug spotsyLogFile:"grails.app"
    error  'org.codehaus.groovy.grails.web.servlet',  //  controllers
	       'org.codehaus.groovy.grails.web.pages', //  GSP
	       'org.codehaus.groovy.grails.web.sitemesh', //  layouts
	       'org.codehaus.groovy.grails."web.mapping.filter', // URL mapping
	       'org.codehaus.groovy.grails."web.mapping', // URL mapping
	       'org.codehaus.groovy.grails.commons', // core / classloading
	       'org.codehaus.groovy.grails.plugins', // plugins
	       'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
	       'org.springframework',
	       'org.hibernate'
    warn   'org.mortbay.log'
}
