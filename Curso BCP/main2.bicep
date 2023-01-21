//Declaracion de parametros

param location string = 'East US'

var webappNames = [
  'vicosweb1'
  'vicosweb2'
  'vicosweb3'
  'vicosweb4'
] 

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'vicos1'
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource vicoswebapp 'Microsoft.Web/sites@2021-01-15' =[ for name in webappNames: {
  name: name
  location: location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig:{
      cors: {
        allowedOrigins:['*']
      }
      netFrameworkVersion:'v6.0'
      appSettings: [
        {
          name: 'ConnectionString'
          value: 'serverbd.microsoft.com'
        }
        {
          name: 'WEBSITE_TIME_ZONE'
          value: 'Current UTC'
        }
      ]
    }
  }
}]
