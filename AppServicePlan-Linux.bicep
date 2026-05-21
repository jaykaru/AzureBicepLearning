param pAppservicePlanName string 
param pSKUName string = 'WS1'//'S1' // WS1 and above sku is supported for logic Apps Standard, S1 is supported for both Web Apps and Logic Apps Standard.
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
