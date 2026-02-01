param pEnv string 
param pAppServicePlan string  
param pWebAppName string  
param pInstrumentationKey string
@description('''
Please provide a valid SKU name The allowed values are 
- F1
- B1
- B2
- B3
- S1
- S2
- S3
''')
@allowed(['F1','B1','B2','B3','S1','S2','S3'])
param pSKUName string
@minValue(1)
@maxValue(30)
param pSKUCapacity int



resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: pAppServicePlan
  location: resourceGroup().location
  sku: {
    name: pSKUName
    capacity: pSKUCapacity
  }
}
// resource appServicePlanLinux 'Microsoft.Web/serverfarms@2020-12-01' = {
//   name: 'azbicep-dev-fc-linux-asp1'
//   location: resourceGroup().location
//   kind: 'linux'
//   properties: {
//     reserved: true
//   }
//   sku: {
//     name: 'S1'
//     capacity: 1
//   }
// }

resource webAppSlot 'Microsoft.Web/sites/slots@2025-03-01' = if (pEnv == 'dev') {
  name: '${pWebAppName}-slot'
  location: resourceGroup().location
  parent : webApplication  // parent should be web app
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: pWebAppName
  location: resourceGroup().location
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', pAppServicePlan) // or can give appServicePlan.name
  }
  dependsOn: [
    appServicePlan
  ]
}

resource azbicepwebapp1appsetting 'Microsoft.Web/sites/config@2025-03-01'  = {
  parent: webApplication
  name: 'web'
  properties: {
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: pInstrumentationKey 
      }
      {
        name: 'key2'
        value: 'value2'
      }
    ]
  }
}
  






