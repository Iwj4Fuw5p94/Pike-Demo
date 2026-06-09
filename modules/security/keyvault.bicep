param location string

@secure()
param adminPassword string

param tags object

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'enterprise-kv-0023'
  location: location
  tags: tags

  properties: {
    tenantId: subscription().tenantId

    sku: {
      family: 'A'
      name: 'standard'
    }

    enableRbacAuthorization: true
    accessPolicies: []

    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'vmAdminPassword'

  properties: {
    value: adminPassword
  }
}

output keyVaultId string = keyVault.id
