param pStorageAccountName string
param pLocation string  = resourceGroup().location
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: pStorageAccountName 
  location: pLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
output storageAccountId string = storageAccount.id

