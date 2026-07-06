param location string
param nsgId string
param subnetname string
param vnetName string
param tags object

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  tags: tags

  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }

    subnets: [
      {
        name: subnetname

        properties: {
          addressPrefix: '10.0.1.0/24'

          networkSecurityGroup: {
            id: nsgId
          }
        }
      }
    ]
  }
}

output subnetId string = vnet.properties.subnets[0].id











































// @description('Name of the Virtual Network')
// param vnetName string

// @description('Location for the VNet')
// param location string

// @description('Address space for the VNet')
// param addressSpace array

// @description('Tags to apply to the VNet')
// param vnetTags object

// resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' = {
//   name: vnetName
//   location: location
//   tags: vnetTags
//   properties: {
//     addressSpace: {
//       addressPrefixes: addressSpace
//     }
//     subnets: [
//       {
//         name: 'default'
//         properties: {
//           addressPrefix: '10.0.0.0/24'
//         }
//       }
//     ]
//   }
// }


