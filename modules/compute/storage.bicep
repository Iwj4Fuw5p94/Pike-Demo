// param saName string
// param location string
// param tags object

// module sa 'br/public:avm/res/storage/storage-account:0.18.0' = {
//   name: 'saModule'
//   params: {
//     name: saName
//     location: location
//     tags: tags
//   }
// }

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'enterprise${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}


