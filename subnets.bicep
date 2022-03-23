param snet_name string
param snet_prefix string
//param existing_vnet string
//param parent_vnet string
//param vnet_id string
/*resource hub_vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: existing_vnet
}
*/

resource subnets 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: snet_name
  //parent: existing_vnet
  properties:{
    addressPrefix: snet_prefix
    
    
  }
}

