targetScope = 'subscription'

resource azbicepresourcegroupDev 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'azbicep-dev-fc-rg'
  location: 'France Central'
}
resource azbicepresourcegroupStage 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'azbicep-stage-fc-rg'
  location: 'France Central'
}
resource azbicepresourcegroupProd 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'azbicep-prod-fc-rg'
  location: 'France Central'
}
resource azbicepresourcegroupKeyVault 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'azbicep-common-fc-rg'
  location: 'France Central'
}
