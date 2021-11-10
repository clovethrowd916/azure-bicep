@allowed([
  'nonprod'
  'prod'
])
param environmentType string
param location string = resourceGroup().location
param storageAccountName string = 'toylauch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylauch${uniqueString(resourceGroup().id)}'


var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


//Create Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

//App Service Module

module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}

output appServiceAppHostname string = appService.outputs.appServiceHostName






