@description('Azure region. Defaults to the RG location.')
param location string = resourceGroup().location

@description('Storage SKU: Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS.')
param skuName string = 'Standard_LRS'

@description('Prefix for storage account name (letters/numbers only).')
param saPrefix string = 'prodstorage' // keep short; SA names must be <= 24 chars

// Build a globally-unique storage account name (3–24 chars, alphanumeric only)
var suffix = toLower(uniqueString(resourceGroup().id, deployment().name))
var saName = toLower('${saPrefix}${substring(suffix, 0, 12)}')

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: saName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

output storageAccountName string = storageAccount.name
output storageAccountId string   = storageAccount.id