param pLocation string = resourceGroup().location
param pServerFarmId string // This let us know which Appservice plan to use
param pFunctionAppName string
param pStorageAccountId string
param pStorageAccountName string
param pInstrumentationKey string
// param pAppInsightsId string // this is used when we used reference function to get instrumentation key from app insights module, but now we are using output from app insights module, so we do not need this parameter



resource functionApp 'Microsoft.Web/sites@2021-02-01' = {
  name: pFunctionAppName
  location: pLocation
  kind: 'functionapp' //if you do not give kind it will consider as normal App service, so we need to give kind as functionapp 
  properties: {
    serverFarmId: pServerFarmId
    siteConfig: { // azure function app need storange account, so we give storang account connection strings
      appSettings: [
        {
          name: 'AzureWebJobsDashboard'
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2019-06-01').keys[0].value}'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2019-06-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: 'DefaultEndpointsProtocol=https;AccountName=${pStorageAccountName};AccountKey=${listKeys(pStorageAccountId, '2019-06-01').keys[0].value}'
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: toLower(pFunctionAppName)
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_APP_INSIGHTS_INSTRUMENTATION_KEY'
          value: pInstrumentationKey
          // value: reference(pAppInsightsId, '2020-02-02').InstrumentationKey
         
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
  }
  
}

