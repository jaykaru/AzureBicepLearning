param pStorageAccountName string
param pLocation string  = resourceGroup().location


module storageAccountModule '5.StorageAccount.bicep' = {
  name: 'deployStorageAccount'
  params: {
    pStorageAccountName: pStorageAccountName
    pLocation: pLocation
  }
}
