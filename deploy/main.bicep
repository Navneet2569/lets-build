param storageAccountName string
param location string = 'centralindia'
param skuName string = 'Standard_LRS'
param kind string = 'StorageV2'
param accessTier string = 'Hot'

resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    accessTier: accessTier
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}
