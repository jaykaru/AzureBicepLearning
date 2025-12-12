param pSqlServerName string  
param pSqlDatabaseName string  


resource sqlServer 'Microsoft.Sql/servers@2014-04-01' ={
  name: pSqlServerName 
  location: resourceGroup().location
  properties: {
    administratorLogin: 'sqladminuser'
    administratorLoginPassword: '' // use a strong password in production
    version: '12.0'
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {
  parent: sqlServer
  name: pSqlDatabaseName
  location: resourceGroup().location
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    edition: 'Basic'
    maxSizeBytes: '2147483648'
    requestedServiceObjectiveName: 'Basic'
  }
}



resource sqlServerFirewallRules 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sqlServer
  name: 'Jay IP address'
  properties: {
    startIpAddress: '1.1.1.1' // test IP address
    endIpAddress: '1.1.1.1'
  }
}

