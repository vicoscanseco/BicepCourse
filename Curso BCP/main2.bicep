//Declaracion de parametros

param location string = 'East US'

param sqlserverName string = 'vicosDB'

//SQL databaseName: Nombre de la base de datos SQL
param sqlDBName string = 'db_cepo_qa261'

//SQL userName: Nombre del usuario SQL
param administratorLogin string = 'cepo'
//SQL password: Contraseña del usuario SQL
@description('The administrator password of the SQL logical server.')
param administratorLoginPassword string = 'P@ssw0rd'

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

resource sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' = {
  name: sqlserverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }
}
//9. Azure SQL Database
resource sqlDB 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  parent: sqlServer
  name: sqlDBName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}
