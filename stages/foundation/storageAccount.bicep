param storageAccountName string 

param location string 

param storageAccountContainerNames string

// Create the storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: toLower(storageAccountName) // Storage account names must be lowercase
  location: location
  sku: {
      name: 'Standard_LRS' // Standard performance tier with locally redundant storage
  }
  kind: 'StorageV2' // Specifies the storage account type
  properties: {
      accessTier: 'Hot' // Hot access tier for frequently accessed data
      isHnsEnabled: false // Hierarchical namespace not enabled
      minimumTlsVersion: 'TLS1_2' // Minimum TLS version
      allowBlobPublicAccess: false // Disable public access to blobs
      supportsHttpsTrafficOnly: true // HTTPS traffic only
      allowCrossTenantReplication: false // Cross-tenant replication disabled
      allowSharedKeyAccess: false // Shared key access disabled
      encryption: {
          services: {
              file: {
                  keyType: 'Account'
                  enabled: true
              }
              blob: {
                  keyType: 'Account'
                  enabled: true
              }
          }
          keySource: 'Microsoft.Storage' // Key source for encryption
      }
  }
}

// Configure blob services properties
resource blobServicesProperties 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default' // Default blob service
  parent: storageAccount // Set parent to the storage account
  properties: {
      changeFeed: {
          enabled: true // Enable change feed
          retentionInDays: 180 // Retain change feed data for 180 days
      }
      containerDeleteRetentionPolicy: {
          allowPermanentDelete: false // Disallow permanent delete
          days: 180 // Retain deleted containers for 180 days
          enabled: true // Enable retention policy
      }
      isVersioningEnabled: true // Enable blob versioning
      restorePolicy: {
          days: 179 // Retain restore policy for 179 days
          enabled: false // Disable restore policy
      }
  }
}

// Create blob containers from the provided array of names
resource storageAccountContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' =  {
  
      name: storageAccountContainerNames // Name of the container
      parent: blobServicesProperties // Set parent to the blob service properties
      properties: {
          publicAccess: 'None' // No public access to containers
      }
  }


// Output the ID of the created storage account
output storageAccountId string = storageAccount.id
