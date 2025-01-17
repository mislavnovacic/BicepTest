# - DEPLOY RESOURCE GROUPS
$resourceGroups = @(
    @{ Name = "RG-MISLAV-BICEP-VNET-WEU"; Location = "westeurope" },
    @{ Name = "RG-MISLAV-BICEP-SA-WEU"; Location = "westeurope" }
)

foreach ($rg in $resourceGroups) {
    if (-not (Get-AzResourceGroup -Name $rg.Name -ErrorAction SilentlyContinue)) {
        Write-Host "Creating Resource Group: $($rg.Name) in location $($rg.Location)"
        New-AzResourceGroup -Name $rg.Name -Location $rg.Location
    } else {
        Write-Host "Resource Group $($rg.Name) already exists. Skipping..."
    }
}

# - DEPLOY THE BICEP TEMPLATE
# - Define parameters
$TemplateFile = ".\main.bicep"
$ParameterFile = ".\parameters\main.parameters.json"
$Location = "westeurope"
# - Deploy the Bicep template
#New-AzDeployment -Location $Location -TemplateFile $TemplateFile -TemplateParameterObject $Parameters -TemplateParameterFile $ParameterFile #-WhatIf -verbose
New-AzDeployment -Location $Location -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -Verbose
