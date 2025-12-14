param pAppServicePlan string 
param pWebAppName string 
param pAppInsightsName string 
param pSqlServerName string 
param pSqlDatabaseName string
param pAdminstratorLogin string
// @secure()
// param pAdministratorPassword string

resource keyvault 'Microsoft.KeyVault/vaults@2025-05-01' existing = {
  name: 'azbicep-dev-fc-kv2'
  scope: resourceGroup('azbicep-common-fc-rg')
}

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
    pAdministratorPassword: keyvault.getSecret('adminsqlserverpassword')
  }
}

module AppInsights '4.AppInsights.bicep' = {
  name: 'deployAppInsights'
  params: {
    pAppInsightsName: pAppInsightsName
  }
}


