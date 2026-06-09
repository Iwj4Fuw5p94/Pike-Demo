targetScope = 'subscription'


resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'myEnterpriseRG'
  location: 'eastus'
  tags: {
    environment: 'production'
    owner: 'enterprise-team'
    costCenter: 'CC1234'
    compliance: 'ISO27001'
  }
}
