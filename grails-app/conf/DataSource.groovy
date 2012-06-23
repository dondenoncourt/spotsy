
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
			dialect=org.hibernate.dialect.SQLServerDialect
			driverClassName="com.microsoft.sqlserver.jdbc.SQLServerDriver"
			username = "ddenoncourt"
			password = "1234512"
			url = 'jdbc:sqlserver://172.16.40.45;databaseName=webdatabase'
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
