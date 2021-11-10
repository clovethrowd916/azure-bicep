$tenant = '95cc0f02-7f0c-47bf-8acf-afee06e890ea'
$hub_subscription = '1ba5c8d8-4d9e-453f-b8b3-4797d10e6697'

Connect-AzAccount -Subscription $hub_subscription -Tenant $tenant
New-AzResourceGroupDeployment -TemplateFile main.bicep -environmentType nonprod