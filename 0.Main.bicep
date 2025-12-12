param pAppServicePlan string = 'azbicep-dev-fc-asp1'
param pWebAppName string = 'azbicep-dev-fc-webapp'
param pAppInsightsName string = 'azbicep-dev-fc-webapp-ai'
param pSqlServerName string = 'azbicep-dev-fc-sqlserver'
param pSqlDatabaseName string = 'database1'

module AppServicePlan '2.AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    pAppInsightsName: pAppInsightsName
    pAppServicePlan: pAppServicePlan
    pWebAppName: pWebAppName
  }
}

module SQLDatabase '3.SQLDatabase.bicep' = {
  name: 'deploySQLDatabase'
  params: {
    pSqlDatabaseName: pSqlDatabaseName 
    pSqlServerName: pSqlServerName
  }
}


