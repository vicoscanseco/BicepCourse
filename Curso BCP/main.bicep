//Declaracion de parametros

param location string = resourceGroup().location


resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'vicos1'
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource vicoswebapp1 'Microsoft.Web/sites@2021-01-15' = {
  name: 'vicoswebapp1'
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
}

resource vicoswebapp2 'Microsoft.Web/sites@2021-01-15' = {
  name: 'vicoswebapp2'
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
}


