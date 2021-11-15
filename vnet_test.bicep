param vnetPrefix string = 'HUB'
param subnetPrefix array = [
  'INFRA'
  'SECURITY'
]

var location = resourceGroup().location
var vnetAddressPrefix = '10.0.0.0/16'
var subnetAddressPrefix = [
  '10.0.0.0/24'
  '10.0.1.0/24'
]

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: '${vnetPrefix}-Net'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
  }

  resource Infra_subnet 'subnets' = {
    name: '${subnetPrefix[0]}-subnet'
    properties: {
      addressPrefix: subnetAddressPrefix[0]
    }
  }

  resource Security_subnet 'subnets' = {
    name: '${subnetPrefix[1]}-subnet'
    properties: {
      addressPrefix: subnetAddressPrefix[1]
    }
  }
}
