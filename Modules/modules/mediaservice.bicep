@description('Nombre del media service')
param medianame string

@description('Region donde se creara el recuro')
param location string

@description('Identidad Administrada')
param managedIdentity object

@description('Id del storage account')
param storageaccountId string

resource mediaServices 'Microsoft.Media/mediaServices@2021-06-01' = {
  name: medianame
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: { '${subscription().id}/resourceGroups/${resourceGroup().name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${managedIdentity.name}' : {} }
  }
  properties: {
    encryption: {
      type: 'SystemKey'
    }
    storageAccounts: [
      {
        id: storageaccountId
       identity: {
          userAssignedIdentity: managedIdentity.Id
          useSystemAssignedIdentity: false
        }
        type: 'Primary'
      }
    ]
    storageAuthentication: 'ManagedIdentity'
  }
}

