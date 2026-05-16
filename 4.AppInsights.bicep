
param pAppInsightsName string  


resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName 
  location: resourceGroup().location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output oInstrumentationKey string = appInsightsComponents.properties.InstrumentationKey
output oAppInsightsId string = appInsightsComponents.id
