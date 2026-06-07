param pEnv string
param pAppServicePlan string 

param pWebAppName string 
param pAppInsightsName string 

param pSqlServerName string 
param pSqlDatabaseName string
param pAdminstratorLogin string
// @secure()
// param pAdministratorPassword string

// param pSKUName string = (Env == 'dev') ? 'S1' : 'S2'
// param pSKUCapacity int = (Env == 'dev') ? 1 : 2

// Define configuration for different environments
var vConfigurations = {
  dev: {
    pAppservicePlan: {
      pSkuName: 'S1'
      pSkuCapacity: 1
    }
  }
  prod: {
    pAppservicePlan: {
      pSkuName: 'S2'
      pSkuCapacity: 2
    }
  }
}


resource keyvault 'Microsoft.KeyVault/vaults@2025-05-01' existing = {
  name: 'azbicep-dev-fc-kv2'
  scope: resourceGroup('azbicep-common-fc-rg')
}

module AppServicePlan '2.AppServicePlan.bicep' = {
  name: 'deployAppServicePlan'
  params: {
    pAppServicePlan: pAppServicePlan
    pWebAppName: pWebAppName
    pInstrumentationKey: AppInsights.outputs.oInstrumentationKey
    pSKUName: vConfigurations[pEnv].pAppservicePlan.pSkuName
    pSKUCapacity: vConfigurations[pEnv].pAppservicePlan.pSkuCapacity
    pEnv: pEnv
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


