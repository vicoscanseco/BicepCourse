@description('Name of the App Service')
param nameAppService string

@description('Location of the resource')
param location string

@description('Service Plan Id')
param servicePlanID string

@description('AppSttings')
param appSettings array = [
  {
    name: 'WEBSITE_TIME_ZONE'
    value: 'Current UTC'
  }
]

//AppService
resource appService 'Microsoft.Web/sites@2021-03-01' =  {
  name: nameAppService
  location: location
  properties: {
    serverFarmId: servicePlanID
    httpsOnly: true
    siteConfig: {
      appSettings: appSettings
      cors: {
        allowedOrigins: [
          '*'
        ]
      }
    }
  }
}
