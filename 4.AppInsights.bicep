
param pAppInsightsName string  
param pLocation string = resourceGroup().location


resource appInsightsComponents 'Microsoft.Insights/components@2020-02-02' = {
  name: pAppInsightsName 
  location: pLocation
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output oInstrumentationKey string = appInsightsComponents.properties.InstrumentationKey
output oAppInsightsId string = appInsightsComponents.id
