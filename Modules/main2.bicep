
//Parametro: Localizacion del recurso, puede quedar vacio 
param location string = 'westus3'


var appServicesNames = [for i in range(1, 5): 'vicosAppService${i}' ]


resource appServicePlan 'Microsoft.Web/serverFarms@2021-03-01' = {
  name: 'AppPlanService'
  location: location
  sku: {
    name: 'D1'
  }
}

module appService 'modules/webapp.bicep' = [for name in appServicesNames : {
  name: name 
  params: {
    location: location
    nameAppService: name
    servicePlanID: appServicePlan.id
    appSettings: [
      {
        name: 'ConnectionStringAppConfiguration'
        value: 'Endpoint=https://settingsgeneral.azconfig.io;Id=LOks-l4-s0:6oW14q0hXsRrtYh3Hq06;Secret=MhvjgGelLR8AB0jMqaabLbjCmgFCH8vcVnhcvABchTY='
      }
      {
        name: 'EnvironmentAppConfiguration'
        value: 'vicospruebas'
      }
      {
        name: 'WEBSITE_TIME_ZONE'
        value: 'Current UTC'
      }
    ]
  }
}]


