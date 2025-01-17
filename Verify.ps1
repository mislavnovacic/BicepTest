# Validate the deployment
#New-AzResourceGroupDeployment -ResourceGroupName RG-MISLAV-BICEP -TemplateFile .\main.bicep  -WhatIf
#New-AzResourceGroupDeployment -ResourceGroupName RG-MISLAV-BICEP -TemplateFile .\main.bicep -TemplateParameterFile .\parameters\main.parameters.json -WhatIf -verbose

# - VERIFY THE BICEP TEMPLATE DEPLOYMENT
# - Define parameters
$TemplateFile = ".\main.bicep"
$ParameterFile = ".\parameters\main.parameters.json"
$Location = "westeurope"
# - Deploy the Bicep template
#New-AzDeployment -Location $Location -TemplateFile $TemplateFile -TemplateParameterObject $Parameters -TemplateParameterFile $ParameterFile #-WhatIf -verbose
New-AzDeployment -Location $Location -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -WhatIf