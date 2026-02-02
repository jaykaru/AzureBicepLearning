param pAppservicePlanName string 
param pSKUName string = 'S1'
param pSKUCapacity int = 1
param pLocation string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: pAppservicePlanName
  location: pLocation
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: pSKUName
    capacity: pSKUCapacity
  }
}

output appServicePlanId string = appServicePlan.id
