param pAppServicePlan string 
param pWebAppName string 
param pAppInsightsName string 
param pSqlServerName string 
param pSqlDatabaseName string
param pAdminstratorLogin string
@secure()
param pAdministratorPassword string


module AppServicePlan '2.AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    pAppServicePlan: pAppServicePlan
    pWebAppName: pWebAppName
    pInstrumentationKey: AppInsights.outputs.instrumentationKey
  }
}

module SQLDatabase '3.SQLDatabase.bicep' = {
  name: 'deploySQLDatabase'
  params: {
    pSqlDatabaseName: pSqlDatabaseName 
    pSqlServerName: pSqlServerName
    pAdminstratorLogin: pAdminstratorLogin
    pAdministratorPassword: pAdministratorPassword
  }
}

module AppInsights '4.AppInsights.bicep' = {
  name: 'deployAppInsights'
  params: {
    pAppInsightsName: pAppInsightsName
  }
}


