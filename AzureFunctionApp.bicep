param pLocation string = resourceGroup().location
param pServerFarmId string
param pFunctionAppName string
param pStorageAccountId string
param pStorageAccountName string
param pInstrumentationKey string

resource functionApp 'Microsoft.Web/sites@2021-02-01' = {
  name: 'azbicep-dev-fc-fapp1'
  location: pLocation
  kind: 'functionapp'
  properties: {
    serverFarmId: pServerFarmId
    siteConfig: {
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
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
      ]
    }
  }
  
}

