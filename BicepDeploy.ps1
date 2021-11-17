$tenant = '95cc0f02-7f0c-47bf-8acf-afee06e890ea'
$hub_subscription = '1ba5c8d8-4d9e-453f-b8b3-4797d10e6697'

Connect-AzAccount -Subscription $hub_subscription -Tenant $tenant
New-AzResourceGroupDeployment -TemplateFile vm_test.bicep -ResourceGroupName AZ-LAB-COMPUTE -TemplateParameterFile parameters.json 
Test-AzDeployment -Name test -TemplateParameterFile parameters.json -TemplateFile vm_test.bicep


#az deployment group create --resource-group AZ-LAB-COMPUTE --template-file vm_test.bicep --parameters @parameters.json
$vnet = Get-AzVirtualNetwork -Name HUB-Net
$subnet = Get-AzVirtualNetworkSubnetConfig -Name INFRA-SUBNET -VirtualNetwork $vnet


New-AzResourceGroupDeployment -TemplateFile vm_test.bicep -ResourceGroupName AZ-LAB-COMPUTE
az deployment group create --resource-group AZ-LAB-COMPUTE --template-file vm_test.bicep --name test1 --parameters parameters.json --parameters vmName=DC01
az deployment group create --resource-group AZ-LAB-COMPUTE --template-file vm_test.bicep --name test1 --parameters vmName=DC01