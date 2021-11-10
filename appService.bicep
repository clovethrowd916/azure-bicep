@allowed([
  'nonprod'
  'prod'
])
param environmentType string
param location string = resourceGroup().location
param appServiceAppName string = 'toylauch${uniqueString(resourceGroup().id)}'


var appServicePlanName = 'toy-product-launch-plan'
var appServiceSkuName = (environmentType == 'prod') ? 'P2_v3' : 'F1'


//Create AppService Plan

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServiceSkuName
  }
}

//Create AppService

resource appServiceApp 'Microsoft.Web/sites@2021-02-01' = {

  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output appServiceHostName string = appServiceApp.properties.defaultHostName



