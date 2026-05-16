
param PACRName string = 'azurebicepModulescr1'
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2021-09-01' = {
  name: PACRName
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  // Enable authentication for the Container Registry because once CR is crated the repositories is created
  // the way we create repo is we are going to publish the Azure Bicep modules from this machine
  // From this machine we need to authenticate ourselfs to the CR, in order to do that we need to enable authentication
  // the we enable authenciation is by setting properties adminUserEnabled to true, once we set that to true then we can get the username and password for the CR and then we can authenticate to the CR and then we can publish the modules to the CR
  properties: {
    adminUserEnabled: true // Container Registry enables the passwords
  }
}
