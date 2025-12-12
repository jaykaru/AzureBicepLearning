param pAppServicePlan string  
param pWebAppName string  
param pInstrumentationKey string

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: pAppServicePlan
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
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

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: pWebAppName
  location: resourceGroup().location
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms', 'azbicep-dev-fc-asp1')
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
  






