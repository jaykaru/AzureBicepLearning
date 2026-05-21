param pStorageAccountName string
param pLocation string  = resourceGroup().location
param pFileShareName string
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: pStorageAccountName 
  location: pLocation
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: '${pStorageAccountName}/default/${pFileShareName}' // The file share name is specified as a parameter, and it is created under the default file service of the storage account.
  dependsOn: [
    storageAccount
  ]
}

output storageAccountId string = storageAccount.id
