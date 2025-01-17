// Import parameters
@description('The name of the resource group for the Storage Account.')
param storageAccountRgName string

@description('The name of the resource group for the VNet.')
param vnetRgName string

@description('The location where the resources will be deployed.')
param location string

@description('The name of the VNet.')
param vnetName string

@description('The address prefix for the VNet.')
param vnetAddressPrefix string

@description('The name of the subnet.')
param subnet1Name string

@description('The address prefix for the subnet.')
param subnet1AddressPrefix string

@description('The name of the route table.')
param routeTableName string

@description('The access tier for the storage account.')
param accessTier string

@description('The SKU name for the storage account.')
param skuName string

@description('The name of the storage account.')
param storageAccountName string

@description('The name of the file share.')
param fileShareName string

@description('The resource ID of the hub VNet.')
param hubVnetResourceId string

@description('The name of the hub VNet.')
param hubVnetName string

var resourceLocation = location

// Storage Account module deployment
module storageAccountModule 'module_storageaccount/main.bicep' = {
  name: 'storageAccountDeployment'
  scope: resourceGroup(storageAccountRgName)
  params: {
    storageAccountName: storageAccountName
    location: resourceLocation
    accessTier: accessTier
    skuName: skuName
    fileShareName: fileShareName
  }
}

// VNet module deployment
module vnetModule 'module_vnet/main.bicep' = {
  name: 'vnetDeployment'
  scope: resourceGroup(vnetRgName)
  params: {
    vnetName: vnetName
    location: resourceLocation
    vnetAddressPrefix: vnetAddressPrefix
    subnet1Name: subnet1Name
    subnet1AddressPrefix: subnet1AddressPrefix
    routeTableName: routeTableName
    hubVnetResourceId: hubVnetResourceId
    hubVnetName: hubVnetName
  }
}

output storageAccountId string = storageAccountModule.outputs.storageAccountId
