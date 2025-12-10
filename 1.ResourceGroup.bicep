targetScope = 'subscription'

resource azbicepresourcegroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'azbicep-dev-fc-rg'
  location: 'France Central'
}
