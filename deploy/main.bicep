// deploy/main.bicep

// Parameters
@description('Azure region to deploy into. Defaults to the resource group location.')
param location string = resourceGroup().location

@description('Storage SKU name. Allowed: Standard_LRS, Standard_GRS, Standard_RAGRS, Standard_ZRS.')
param skuName string = 'Standard_LRS'

@description('Prefix used to build a globally-unique storage account name.')
param saPrefix string = 'prodstorage' // must be letters/numbers only; <= 12 chars recommended

// Build a valid, unique storage account name (3-24 chars, letters/numbers only)
var suffix = toLower(uniqueString(resourceGroup().id, deployment().name))
var saName = toLower('${saPrefix}${substring(suffix, 0, 12)}')

// Storage account
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