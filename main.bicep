

param vnet_specs object = {
  vnet_name: 'hub'
  vnet_address_space: '10.0.0.0/16'
  
}

param snet_specs object = {
  core_services_subnet_name: 'core_services'
  core_services_subnet_space: '10.0.0.0/24'
  mgmt_subnet_name: 'management'
  mgmt_subnet_space: '10.0.1.0/24'
  ops_subnet_name: 'operations'
  ops_subnet_space: '10.0.2.0/24'
  trusted_subnet_name: 'trusted'
  trusted_subnet_space: '10.0.3.0/24'
  untrusted_subnet_name: 'untrusted'
  untrusted_subnet_space: '10.0.4.0/24'
}



targetScope = 'subscription'

param region string = 'eastus'

resource hubrg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'hub-rg'
  location: region
}

resource spokerg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'spoke-rg'
  location: region
}



module testVnet 'vnet.bicep' = {
  scope: hubrg
  name: 'hubNetwork'
  params: {
    mainSubnetAddressPrefix: snet_specs['core_services_subnet_space']
    mainSubnet_name: snet_specs['core_services_subnet_name']
    vnet_name: vnet_specs['vnet_name']
    vnetAddressPrefix: vnet_specs['vnet_address_space']
    
  }
}

/*module testsnet 'subnets.bicep' = {
  scope: hubrg
  name: 'hub_mgmt_subnets'
  params:{
    snet_name: snet_specs['mgmt_subnet_name']
    //vnet_id: testVnet.outputs.vnetId
    snet_prefix: snet_specs['mgmt_subnet_space']
  }
}
*/








