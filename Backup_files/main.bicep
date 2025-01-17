// Import parameters
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

var resourceLocation = location

// Storage Account module deployment
module storageAccountModule 'module_storageaccount/main.bicep' = {
  name: 'storageAccountDeployment'
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
  params: {
    vnetName: vnetName
    location: resourceLocation
    vnetAddressPrefix: vnetAddressPrefix
    subnet1Name: subnet1Name
    subnet1AddressPrefix: subnet1AddressPrefix
    routeTableName: routeTableName
  }
}

// Create Peering with HUB network
//param subscriptionId string = 'f3be49af-c543-42e2-9b6d-6dce773995ff'
//param peeringVnetName string = 'mislav-vnet'
//param vnetResourceGroup string = 'RG-MISLAV-BICEP'
//param hubVnetName string = 'TEST-MISLAV-VNET1'
//param hubVnetResourceGroup string = 'RG-MISLAV-VNET-WEU-01'

// Existing VNet resources for peering
//resource existingVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
//  name: vnetName
//  scope: resourceGroup(subscriptionId, vnetResourceGroup)
//}

//resource existingHubVnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
//  name: hubVnetName
//  scope: resourceGroup(subscriptionId, hubVnetResourceGroup)
//}

// VNET Peering: mislav-vnet -> TEST-MISLAV-VNET1
//resource vnetPeeringToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
//  name: 'mislav-to-hub'
//  parent: vnet
// properties: {
//    allowVirtualNetworkAccess: true
//    allowForwardedTraffic: true
//    allowGatewayTransit: false
//    useRemoteGateways: false
//    remoteVirtualNetwork: {
//      id: existingHubVnet.id
//    }
//  }
//}

