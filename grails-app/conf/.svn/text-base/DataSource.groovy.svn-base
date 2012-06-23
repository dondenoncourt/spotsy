
dataSource {
	pooled = true
	driverClassName = "org.hsqldb.jdbcDriver"
	username = "sa"
	password = ""
}
hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
		//	dialect=org.hibernate.dialect.SQLServerDialect
		//	driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"
		//	username = "donat"
		//	password = "vo2max"
		//	url = 'jdbc:sqlserver://SCWEB1\\SQL2000;databaseName=webdatabase' // test

            url = "jdbc:mysql://localhost/spotsy"
            driverClassName = "com.mysql.jdbc.Driver"
            dialect = org.hibernate.dialect.MySQLDialect
            username = "root"
            password = "*pure!choice"
            
      //      dbCreate = "update"	
			
			// url = 'jdbc:sqlserver://172.16.40.45;databaseName=webdatabase' // production  
			//username = "ddenoncourt"
			//password = "1234512"
			
			logSql = false
		}
	}
	test {
		dataSource {
			dbCreate = "create"
			url = "jdbc:hsqldb:mem:testDb"
		}
	}
	production {
		dataSource {
			dialect=org.hibernate.dialect.SQLServerDialect
			driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"
			username = "ddenoncourt"
			password = "1234512"
			url = 'jdbc:sqlserver://172.16.40.45;databaseName=webdatabase'
//		 Test Windows Box
//			url = 'jdbc:sqlserver://172.16.40.9\\SQL2000;databaseName=webdatabase'  //test
//			username = "donat"
//			password = "vo2max"
			logSql = false
		}
	}
}
