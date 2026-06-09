targetScope = 'resourceGroup'

param location string = resourceGroup().location
param environment string
param vmName string
param adminUsername string

@secure()
param adminPassword string = ''

var tags = {
  Environment: environment
  Owner: 'CloudTeam'
  Project: 'LandingZone'
}

//
// NSG
//
module nsg './modules/networking/nsg.bicep' = {
  name: 'nsgDeploy'
  params: {
    location: location
    nsgName: '${vmName}-nsg'
    tags: tags
  }
}

//
// VNET
//
module vnet './modules/networking/vnet.bicep' = {
  name: 'vnetDeploy'
  params: {
    location: location
    nsgId: nsg.outputs.nsgId
    tags: tags
  }
}

//
// KEY VAULT
//
module keyVault './modules/security/keyvault.bicep' = {
  name: 'kvDeploy'
  params: {
    location: location
    adminPassword: adminPassword
    tags: tags
  }
}

//
// VM
//
module vm './modules/compute/vm.bicep' = {
  name: 'vmDeploy'
  params: {
    location: location
    vmName: vmName
    subnetId: vnet.outputs.subnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    tags: tags
  }

  dependsOn: [
    keyVault
  ]
}

module vm2 './modules/compute/vm.bicep' = {
  name: 'vmDeploy02'

  params: {
    location: location
    vmName: 'appvm02'
    subnetId: vnet.outputs.subnetId
    adminUsername: adminUsername
    adminPassword: adminPassword
    tags: tags
  }
}

//
// ALERT
//
module alert './modules/monitoring/alert.bicep' = {
  name: 'alertDeploy'
  params: {
    vmId: vm.outputs.vmId
  }
}

















































// param rgName string = 'myEnterpriseRG'
// targetScope = 'subscription'
// param location string = 'eastus'
// param rgTags object = {
//   environment: 'production'
//   owner: 'enterprise-team'
//   costCenter: 'CC1234'
//   compliance: 'ISO27001'
// }

// resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
//   name: rgName
//   location: location
//   tags: rgTags
// }

// module vnet './modules/networking/vnet.bicep' = {
//   name: 'vnetDeployment'
//   scope: rg
//   params: {
//     vnetName: 'enterprise-vnet'
//     location: location
//     addressSpace: [
//       '10.0.0.0/16'
//     ]
//     vnetTags: rgTags
//   }
// }


