
// Set variables and parameters


param adminLogin string
@secure()
param adminPw string

param vmName string

var location = resourceGroup().location
var nicName = '${vmName}-NIC'
var nicIpConfigName = '${nicName}-ipconfig'
param subnet_id string  = resourceId('AZ-LAB-NETWORKING','Microsoft.Network/virtualNetworks/subnets', 'HUB-NET', 'INFRA-SUBNET')
var vm_size = 'Standard_B2ms'
var os_disk_type = 'StandardSSD_LRS'
var os_version = '2019-Datacenter'



/*Set Admin Creds for VM
resource sc_kv 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = {
  name: 'azlab-kv-SC'

  resource admin_secret 'secrets' existing = {
    name: 'adminPassword'

  }

  resource admin_user 'secrets' existing = {
    name: 'adminUsername'

  }

}
*/
// Bring in VNet Details




//Create NIC
 resource vm_nic 'Microsoft.Network/networkInterfaces@2021-03-01' = {
   name: nicName
   location: location
   extendedLocation: {
  
   }
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
resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vm_size
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: os_disk_type
        }
      }
      imageReference: {
        sku: os_version
        version: 'latest'
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'

      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vm_nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
    osProfile: {
      adminPassword: adminPw
      adminUsername: adminLogin
      computerName: vmName

    }
  }
  dependsOn: [
    vm_nic
  ]
}

