targetScope = 'subscription'

param objectId string

@allowed([
  'Group'
  'ServicePrincipal'
 ])
param principalType string = 'ServicePrincipal'

resource dataContributorRole 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: 'b7e6dc6d-f1e8-4753-8033-0f276bb0955b'
}

resource assignDataContributorRoleResourceGroup 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(subscription().id, objectId, dataContributorRole.id)
  properties: {
    principalId: objectId
    principalType: principalType
    roleDefinitionId: dataContributorRole.id
  }
}
