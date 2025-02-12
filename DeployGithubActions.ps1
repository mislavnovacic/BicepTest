# Ensure Azure Login with GitHub Actions Credentials
if (-not (Get-AzContext)) {
    Write-Host "Logging in to Azure using Service Principal..."
    $azCredentials = $env:AZURE_CREDENTIALS | ConvertFrom-Json
    Connect-AzAccount `
        -ServicePrincipal `
        -TenantId $azCredentials.tenantId `
        -ApplicationId $azCredentials.clientId `
        -CertificateThumbprint $azCredentials.clientSecret `
        -SubscriptionId $azCredentials.subscriptionId
}

# - Define Resource Groups
$resourceGroups = @(
    @{ Name = "RG-MISLAV-BICEP-VNET-WEU"; Location = "westeurope" },
    @{ Name = "RG-MISLAV-BICEP-SA-WEU"; Location = "westeurope" }
)

# - Deploy Resource Groups if they do not exist
foreach ($rg in $resourceGroups) {
    if (-not (Get-AzResourceGroup -Name $rg.Name -ErrorAction SilentlyContinue)) {
        Write-Host "Creating Resource Group: $($rg.Name) in location $($rg.Location)"
        New-AzResourceGroup -Name $rg.Name -Location $rg.Location
    } else {
        Write-Host "Resource Group $($rg.Name) already exists. Skipping..."
    }
}

# - Define Deployment Parameters
$TemplateFile = "./main.bicep"
$ParameterFile = "./parameters/main.parameters.json"
$Location = "westeurope"

# - Check if Bicep & Parameter Files Exist
if (!(Test-Path $TemplateFile)) {
    Write-Host "Error: Bicep file not found at $TemplateFile"
    exit 1
}
if (!(Test-Path $ParameterFile)) {
    Write-Host "Error: Parameter file not found at $ParameterFile"
    exit 1
}

# - Deploy the Bicep Template
Write-Host "Deploying Bicep template: $TemplateFile with parameters from $ParameterFile"
New-AzDeployment -Location $Location -TemplateFile $TemplateFile -TemplateParameterFile $ParameterFile -Verbose

Write-Host "✅ Deployment completed successfully."