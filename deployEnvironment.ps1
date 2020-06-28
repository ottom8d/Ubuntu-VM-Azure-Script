<#
 .SYNOPSIS
    Deploys a template to Azure

 .DESCRIPTION
    Deploys an Azure Resource Manager template

 .EXAMPLE
    ./deploy.ps1 -subscription "Azure Subscription" -resourceGroupName myresourcegroup -resourceGroupLocation centralus

 .PARAMETER Subscription
    The subscription name or id where the template will be deployed.

 .PARAMETER ResourceGroupName
    The resource group where the template will be deployed. Can be the name of an existing or a new resource group.

 .PARAMETER ResourceGroupLocation
    Optional, a resource group location. If specified, will try to create a new resource group in this location. If not specified, assumes resource group is existing.

 .PARAMETER TemplateFilePath
    Optional, path to the template file. Defaults to template.json.

 .PARAMETER ParametersFilePath
    Optional, path to the parameters file. Defaults to parameters.json. If file is not found, will prompt for parameter values based on template.
#>

param(
 [Parameter(Mandatory=$True)]
 [string]
 $Subscription,

 [Parameter(Mandatory=$True)]
 [string]
 $ResourceGroupName,

 [Parameter(Mandatory=$True)]########### Added Mandatory#########################
 [string]
 $ResourceGroupLocation,

 [Parameter(Mandatory=$True)]
 [int]
 $NumberOfDeployments,

 [string]
 $guacTemplateFilePath = "guacTemplate.json",

 [string]
 $guacParametersFilePath = "guacParameters.json",

 [string]
 $kaliTemplateFilePath = "kaliTemplate.json",

 [string]
 $kaliParametersFilePath = "kaliParameters.json",

 [string]
 $windowsTemplateFilePath = "windowsTemplate.json",

 [string]
 $windowsParametersFilePath = "windowsParameters.json"
)

$AzModuleVersion = "2.0.0"

<#
.SYNOPSIS
    Registers RPs
#>
Function RegisterRP {
    Param(
        [string]$ResourceProviderNamespace
    )

    Write-Host "Registering resource provider '$ResourceProviderNamespace'";
    Register-AzResourceProvider -ProviderNamespace $ResourceProviderNamespace;
}

#******************************************************************************
# Script body
# Execution begins here
#******************************************************************************
$ErrorActionPreference = "Stop"

# Verify that the Az module is installed 
if (!(Get-InstalledModule -Name Az -MinimumVersion $AzModuleVersion -ErrorAction SilentlyContinue)) {
    Write-Host "This script requires to have Az Module version $AzModuleVersion installed..
It was not found, please install from: https://docs.microsoft.com/en-us/powershell/azure/install-az-ps"
    exit
} 

# sign in
Write-Host "Logging in...";
Connect-AzAccount; 

# select subscription
Write-Host "Selecting subscription '$Subscription'";
Select-AzSubscription -Subscription $Subscription;

# Register RPs
$resourceProviders = @("microsoft.network","microsoft.compute");
if($resourceProviders.length) {
    Write-Host "Registering resource providers"
    foreach($resourceProvider in $resourceProviders) {
        RegisterRP($resourceProvider);
    }
}

#Create or check for existing resource group
$resourceGroup = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
if(!$resourceGroup)
{
    if(!$ResourceGroupLocation) {
        Write-Host "Resource group '$ResourceGroupName' does not exist. To create a new resource group, please enter a location.";
        $resourceGroupLocation = Read-Host "ResourceGroupLocation";
    }
    Write-Host "Creating resource group '$ResourceGroupName' in location '$ResourceGroupLocation'";
    New-AzResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation
}
else{
    Write-Host "Using existing resource group '$ResourceGroupName'";
}

# Start the deployment
Write-Host "|||STARTING DEPLOYMENT|||";
$StartTime = $(get-date)
Write-Host $StartTime
$OldCount=1
For ($i=1; $i -le $NumberOfDeployments; $i++) {
    Write-Host "Creating Guacamole virtual machine...";
    if(Test-Path $guacParametersFilePath) {
        New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $guacTemplateFilePath -TemplateParameterFile $guacParametersFilePath;
    } else {
        New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $guacTemplateFilePath;
    }
    Write-Host "Guacamole Virtual machine created!";

    Write-Host "Creating Kali virtual machine...";
    if(Test-Path $kaliParametersFilePath) {
        New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $kaliTemplateFilePath -TemplateParameterFile $kaliParametersFilePath;
    } else {
        New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $kaliTemplateFilePath;
    }
    Write-Host "Kali Virtual machine created!";
    
    Write-Host "Creating Windows virtual machine...";
    if(Test-Path $windowsParametersFilePath) {
        New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $windowsTemplateFilePath -TemplateParameterFile $windowsParametersFilePath;
    } else {
        New-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -TemplateFile $windowsTemplateFilePath;
    }
    Write-Host "Windows Virtual machine created!";
    $ElapsedTime = $(get-date) - $StartTime
    Write-Host "Elapsed Time = $ElapsedTime"
    
    $NewCount = $OldCount+1
    ##### Then find and replace the template count variable with the current instance number incremented by 1
    $InputFiles = Get-Item *
    $OldString  = "`"count`": `"$OldCount`""
    $NewString  = "`"count`": `"$NewCount`""
    $InputFiles | ForEach-Object {
        (Get-Content -Path $_.FullName).Replace($OldString,$NewString) | Set-Content -Path $_.FullName
    }
    $OldCount = $NewCount
}
$ResetIterationCount = $NumberOfDeployments+1
$InputFiles = Get-Item *
$OldString  = "`"count`": `"$ResetIterationCount`""
$NewString  = "`"count`": `"1`""
$InputFiles | ForEach-Object {
    (Get-Content -Path $_.FullName).Replace($OldString,$NewString) | Set-Content -Path $_.FullName
}
Write-Host "|||DEPLOYMENT COMPLETE|||"
$ElapsedTime = $(get-date) - $StartTime
Write-Host "|||Total Elapsed Time = $ElapsedTime|||";
