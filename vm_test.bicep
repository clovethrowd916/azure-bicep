
// Set variables and parameters
param vmName string
var location = resourceGroup().location
var nicName = '${vmName}-NIC'
var nicIpConfigName = '${nicName}-ipconfig'
var subnet_id  = resourceId('Microsoft.Network/virtualNetworks/subnets', 'INFRA-SUBNET')



//Set Admin Creds for VM
resource sc_kv 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: 'azlab-kv-SC'

  resource admin_secret 'secrets' existing = {
    name: 'adminPassword'

  }

  resource admin_user 'secrets' existing = {
    name: 'adminUsername'

  }

}



// Bring in VNet Details
resource hub_vnet 'Microsoft.Network/virtualNetworks@2021-03-01' existing = {
  name: 'HUB-NET'

  resource infra_subnet 'subnets' existing = {
    name: 'INFRA-SUBNET'
  }
}



//Create NIC
 resource vm_nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
   name: nicName
   location: location
   properties: {
     ipConfigurations: [
       {
         name: nicIpConfigName
         properties: {
           subnet: {
             id: subnet_id
           }
           privateIPAllocationMethod: 'Dynamic'
         }
       }
     ]
   }
 }

// Create VM 
