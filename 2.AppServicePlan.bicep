resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-dev-fc-asp1'
  location: resourceGroup().location
  sku: {
    name: 'S1'
    capacity: 1
  }
}
resource appServicePlanLinux 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-dev-fc-linux-asp1'
  location: resourceGroup().location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: 'S1'
    capacity: 1
  }
}



