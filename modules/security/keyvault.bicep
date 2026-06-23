param location string

@secure()
param adminPassword string

param tags object

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: 'enterprise-kv-0024'
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
      enablePurgeProtection: true

      // for security
  softDeleteRetentionInDays: 90

  publicNetworkAccess: 'Disabled'

  networkAcls: {
    bypass: 'AzureServices'
    defaultAction: 'Deny'
  }
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'vmAdminPassword'

  properties: {
    value: adminPassword
    contentType: 'Password'
    
  }
  
}

output keyVaultId string = keyVault.id
