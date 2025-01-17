@description('The name of the VNet.')
param vnetName string

@description('The location where the resources will be deployed.')
param location string

@description('The address prefix for the VNet.')
param vnetAddressPrefix string

@description('The name of the subnet.')
param subnet1Name string

@description('The address prefix for the subnet.')
param subnet1AddressPrefix string

@description('The name of the route table.')
param routeTableName string

@description('The resource ID of the hub VNet.')
param hubVnetResourceId string

@description('The name of the hub VNet.')
param hubVnetName string

resource routeTable 'Microsoft.Network/routeTables@2021-05-01' = {
  name: routeTableName
  location: location
  properties: {
    routes: [
      {
        name: 'BlockInternetOutbound'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'None'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1AddressPrefix
          routeTable: {
            id: routeTable.id
          }
        }
      }
    ]
  }
}

// Spoke-to-Hub Peering
resource spokeToHubPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${vnetName}-to-${hubVnetName}'
  parent: vnet
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnetResourceId
    }
  }
}


// Hub-to-Spoke Peering
resource hubToSpokePeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01' = {
  name: '${hubVnetName}-to-${vnetName}'
  parent: vnet
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: hubVnetResourceId
    }
  }
}
