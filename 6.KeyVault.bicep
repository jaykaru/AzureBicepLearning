param pKeyVaultName string = 'az-bicep-dev-fc-01'
param pLocation string = resourceGroup().location
param pAccessPolicies array = [
  {
    objectId: '1bdf4dff-9646-4bcc-90ac-b6ae1e05e78e' // get from entra user 
  }
  {
    objectId: '88d0c16e-3b0b-41d4-8aea-ef14382ffc0c' // get from entra user 
  }
]

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: pKeyVaultName
  location: pLocation
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: subscription().tenantId
    accessPolicies: [
      // {
      //   tenantId: subscription().tenantId
      //   objectId: // get from entra user 
      //   permissions: {
      //     keys: [
      //       'get'
      //       'list'
      //     ]
      //     secrets: [
      //       'list'
      //       'get'
      //       'set'
      //     ]
      //   }
      // }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource keyVaultAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2019-09-01' = {
  name: 'add' // allowed values are add or replace or delete 
  parent: keyVault // symbolic reference to the key vault resource
  properties: {
    accessPolicies: [ for accesspolicy in pAccessPolicies: {
        objectId: accesspolicy.objectId
        permissions: {
          keys: [
            'get'
            'list'
          ]
          secrets: [
            'list'
            'get'
            'set'
          ]
        }
         tenantId: subscription().tenantId
      }
    ]
  }
}

resource Keys 'Microsoft.KeyVault/vaults/keys@2019-09-01' = {
  name: '${pKeyVaultName}-key1'
  parent: keyVault
  properties: {
    kty: 'RSA'
    keySize: 2048
    curveName: 'P-256'
  }
}

resource Secret 'Microsoft.KeyVault/vaults/secrets@2025-05-01' = {
  name: '${pKeyVaultName}-secret1'
  parent: keyVault
  properties: {
    value: 'This is a secret value'
  }
}
