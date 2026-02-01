param Env string = 'dev'
param pAppServicePlan string 
param pWebAppName string 
param pAppInsightsName string 
param pSqlServerName string 
param pSqlDatabaseName string
param pAdminstratorLogin string
// @secure()
// param pAdministratorPassword string

param pSKUName string = (Env == 'dev') ? 'S1' : 'S2'
param pSKUCapacity int = (Env == 'dev') ? 1 : 2


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
    pSKUName: pSKUName
    pSKUCapacity: pSKUCapacity
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


