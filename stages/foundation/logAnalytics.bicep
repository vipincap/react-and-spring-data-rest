@description('Name of the Log Analytics workspace')
param workspaceName string

@description('Location for the Log Analytics workspace')
param location string 

param retentionInDays int = 30

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: workspaceName
  location: location
  properties: {
    retentionInDays: retentionInDays
  }
  
}
output workspaceId string = logAnalyticsWorkspace.id
output workspaceName string = logAnalyticsWorkspace.name
output workspaceResourceId string = logAnalyticsWorkspace.id
