using './Main.bicep'

param environment = 'dev'
param vmName = 'dev-vm'
param location = 'eastus'
param adminUsername = 'azureuser'
param adminPassword = 'Admin@123'
param rgname = 'rg-hexaware-${environment}'
