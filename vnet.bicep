param owner string = 'alex'
param costCenter string = '12345'
param vnetAddressPrefix string 
param mainSubnetAddressPrefix string 
param vnet_name string
param mainSubnet_name string




resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnet_name
#disable-next-line no-loc-expr-outside-params
  location: resourceGroup().location
  tags: {
    Owner: owner
    CostCenter: costCenter
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: mainSubnet_name
        properties: {
          addressPrefix: mainSubnetAddressPrefix
        }
      }
    ]
  }
}

output vnetId string = vnet.id
