param pStorageAccountName string
param pLocation string  = resourceGroup().location
param pAppservicePlanName string 
param pSKUName string 
param pSKUCapacity int 
param pFunctionAppName string
param pAppInsightsName string
param pInstrumentationKey string



module storageAccountModule '5.StorageAccount.bicep' = {
  name: 'deployStorageAccount'
  params: {
    pStorageAccountName: pStorageAccountName
    pLocation: pLocation
  }
}

module appServicePlanLinuxModule 'AppServicePlan-Linux.bicep' = {
  name: 'deployAppServicePlan_Linux'
  params: {
    pAppservicePlanName: pAppservicePlanName
    pSKUName: pSKUName
    pSKUCapacity: pSKUCapacity
    pLocation: pLocation
  }
}

module functionAppModule 'AzureFunctionApp.bicep' = {
  name: 'deployFunctionApp'
  params: {
    pFunctionAppName: pFunctionAppName
    pServerFarmId: appServicePlanLinuxModule.outputs.appServicePlanId
    pLocation: pLocation
    pStorageAccountId: storageAccountModule.outputs.storageAccountId
    pStorageAccountName: pStorageAccountName
    pInstrumentationKey: pInstrumentationKey
  }
}

module appInsightsModule '4.AppInsights.bicep' = {
  name: 'deployAppInsights'
  params: {
    pAppInsightsName: pAppInsightsName
  }
}
