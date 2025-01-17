# Ensure the resource group exists
if (-not (Get-AzResourceGroup -Name RG-MISLAV-BICEP -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name RG-MISLAV-BICEP -Location westeurope
}

# Deploy the Bicep file
#New-AzResourceGroupDeployment -ResourceGroupName RG-MISLAV-BICEP -TemplateFile .\main.bicep
New-AzResourceGroupDeployment -ResourceGroupName RG-MISLAV-BICEP -TemplateFile .\main.bicep -TemplateParameterFile .\parameters\main.parameters.json -verbose

# Validate the deployment
#New-AzResourceGroupDeployment -ResourceGroupName RG-MISLAV-BICEP -TemplateFile .\main.bicep  -WhatIf
#New-AzResourceGroupDeployment -ResourceGroupName RG-MISLAV-BICEP -TemplateFile .\main.bicep -TemplateParameterFile .\parameters\main.parameters.json -WhatIf