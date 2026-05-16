param pStorageAccountName string
param pLocation string  = resourceGroup().location
param pAppservicePlanName string 
param pSKUName string 
param pSKUCapacity int 
param pFunctionAppName string
param pAppInsightsName string
param pStartIndex int = 1
param pCount int = 5




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
module functionAppModule 'AzureFunctionApp.bicep' = [for Index in range(pStartIndex, pCount) :{
  name: 'deployFunctionApp-${Index}'
  params: {
    pFunctionAppName: '${pFunctionAppName}-${Index}'
    pServerFarmId: appServicePlanLinuxModule.outputs.appServicePlanId
    pLocation: pLocation
    pStorageAccountId: storageAccountModule.outputs.storageAccountId
    pStorageAccountName: pStorageAccountName
    pInstrumentationKey: appInsightsModule[Index -pStartIndex].outputs.oInstrumentationKey
    // pAppInsightsId: appInsightsModule.outputs.oAppInsightsId
  }
}]

module appInsightsModule '4.AppInsights.bicep' = [for Index in range(pStartIndex, pCount) :{
  name: 'deployAppInsights-${Index}'
  params: {
    pAppInsightsName: '${pAppInsightsName}-${Index}'
  }
}]

