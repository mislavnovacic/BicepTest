// Parameters for the module
@description('The name of the storage account.')
param storageAccountName string

@description('The location where the storage account will be deployed.')
param location string

@description('The access tier for the storage account.')
param accessTier string

@description('The SKU name for the storage account.')
param skuName string

@description('The name of the file share.')
param fileShareName string

// Storage Account deployment
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  kind: 'FileStorage'
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    largeFileSharesState: 'Enabled'    
  }
}

// File service configuration
resource fileService 'Microsoft.Storage/storageAccounts/fileServices@2021-02-01' = {
  name: 'default'
  parent: storageAccount
}

// File share configuration
resource fileShare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: fileShareName
  parent: fileService
  properties: {
    shareQuota: 200
  }
}

// Output the Storage Account ID
output storageAccountId string = storageAccount.id
