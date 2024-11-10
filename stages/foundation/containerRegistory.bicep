param acrName string
param location string
param acrSku string
param logAnalyticsWorkspaceId string
resource acrResource 'Microsoft.ContainerRegistry/registries@2023-07-01'= {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true
  }
}

resource acrDiagnostics 'microsoft.insights/diagnosticSettings@2016-09-01' = {
  location:location
  name: 'service'
  scope: acrResource
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'ContainerRegistryLoginEvents'
        enabled: true
      }
      {
        category: 'ContainerRegistryRepositoryEvents'
        enabled: true
      }
    ]
    metrics: [
      {
        enabled:  true
        timeGrain: 'PT1H' 
      }
    ]
  }
  
}
output loginServer string = acrResource.properties.loginServer
