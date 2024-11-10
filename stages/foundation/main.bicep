targetScope = 'subscription'

// Parameters for the deployment
param location string
param objectId string
param resourceGroupName string
param storageAccountName string 
param storageAccountContainerNames string
param workspaceName string


// parameter for acr
param acrName string
param acrSku string

// Deploy the resource group
resource backendResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
    name: resourceGroupName
    location: location
}

// Deploy the storage account module
module storageAccount 'storageAccount.bicep' = {
    name: 'storageAccount'
    scope: backendResourceGroup
    params: {
        location: location
        storageAccountName: storageAccountName
        storageAccountContainerNames: storageAccountContainerNames
    }

}

// Deploy the role mapping module
module roleMapping 'roleMapping.bicep' = {
    name: 'roleMapping'
    params: {
        objectId: objectId
    }
}

// Deploy Azure container registory
module containerRegistory 'containerRegistory.bicep' = {
    name: 'containerRegistory'
    scope: backendResourceGroup
    params:{
        acrName:acrName
        location: location
        acrSku: acrSku
        logAnalyticsWorkspaceId: logAnalytics.outputs.workspaceId
    }
}

module logAnalytics 'logAnalytics.bicep' = {
    name: 'logAnalytics'
    scope: backendResourceGroup
    params:{
        location: location
        workspaceName: workspaceName
        retentionInDays:30
    }
}
