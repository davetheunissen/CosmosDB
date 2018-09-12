# This module provides helper functions for executing tests
function Get-AzureServicePrincipal
{
    [CmdletBinding()]
    param
    (
        [Parameter()]
        [System.String]
        $SettingsFilePath = (Join-Path -Path $PSScriptRoot -ChildPath 'AzureConnection.user.ps1')
    )

    if ((Test-Path -Path $SettingsFilePath))
    {
        Write-Verbose -Message ('Loading Azure Connection Settings from User File ''{0}''.' -f $SettingsFilePath)
        & $SettingsFilePath
    }
    else
    {
        Write-Verbose -Message 'Getting Azure Connection Settings from Environment Variables.'
    }
}

function Connect-AzureServicePrincipal
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $SubscriptionId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ApplicationId,

        [Parameter(Mandatory = $true)]
        [System.String]
        $ApplicationPassword,

        [Parameter(Mandatory = $true)]
        [System.String]
        $TenantId
    )

    try
    {
        Write-Verbose -Message "Logging in to Azure using Service Principal $ApplicationId"

        # Build platform (AppVeyor) does not offer solution for passing secure strings
        $secureStringPassword = ConvertTo-SecureString `
            -String $ApplicationPassword `
            -AsPlainText `
            -Force
        $azureCredential = New-Object `
            -Typename System.Management.Automation.PSCredential `
            -Argumentlist $ApplicationId, $secureStringPassword

        # Suppress request to share usage information
        $path = "$Home\AppData\Roaming\Windows Azure Powershell\"
        if (-not (Test-Path -Path $Path))
        {
            $null = New-Item -Path $Path -ItemType Directory
        }
        $azureProfileFilename = Join-Path `
            -Path $Path `
            -ChildPath 'AzureDataCollectionProfile.json'
        $azureProfileContent = Set-Content `
            -Value '{"enableAzureDataCollection":true}' `
            -Path $azureProfileFilename

        # Handle login
        $null = Add-AzureRmAccount `
            -ServicePrincipal `
            -SubscriptionId $SubscriptionId `
            -TenantId $TenantId `
            -Credential $azureCredential `
            -ErrorAction SilentlyContinue

        # Validate login
        $loginSuccessful = Get-AzureRmSubscription `
            -SubscriptionId $SubscriptionId `
            -TenantId $TenantId

        if ($null -eq $loginSuccessful)
        {
            throw 'Login to Azure was unsuccessful!'
        }
    }
    catch [System.Exception]
    {
        Write-Error -Message "An error occured while logging in to Azure`n$($_.exception.message)"
    }
}

function New-AzureTestCosmosDbAccount
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AccountName
    )

    try
    {
        Write-Verbose -Message ('Creating Cosmos DB test account {0}.' -f $AccountName)

        # Build hashtable of deployment parameters
        $azureDeployFolder = Join-Path -Path $PSScriptRoot -ChildPath 'AzureDeploy'
        $deployName = ('Deploy_{0}' -f $AccountName)
        $deploymentParameters = @{
            Name                    = $deployName
            ResourceGroupName       = $ResourceGroupName
            TemplateFile            = Join-Path -Path $azureDeployFolder -ChildPath 'AzureDeploy.json'
            TemplateParameterObject = @{
                AccountName = $AccountName
            }
        }

        # Deploy ARM template
        New-AzureRmResourceGroupDeployment `
            @deploymentParameters
    }
    catch [System.Exception]
    {
        Write-Error -Message "An error occured during the deployment of the Cosmos DB test account.`n$($_.exception.message)"
    }
}

function Remove-AzureTestCosmosDbAccount
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter(Mandatory = $true)]
        [System.String]
        $AccountName
    )

    try
    {
        Write-Verbose -Message ('Removing Cosmos DB test account {0}.' -f $AccountName)

        # Remove resource group as
        $null = Remove-AzureRmResourceGroup `
            -Name $ResourceGroupName `
            -Force `
            -AsJob
    }
    catch [System.Exception]
    {
        Write-Error -Message "An error occured during the removal of the Cosmos DB test account.`n$($_.exception.message)"
    }
}

function New-AzureTestCosmosDbResourceGroup
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName,

        [Parameter()]
        [System.String]
        $Location = 'East US'
    )

    try
    {
        Write-Verbose -Message ('Creating test Azure Resource Group {0} in {1}.' -f $ResourceGroupName,$Location)

        $null = New-AzureRmResourceGroup `
            -Name $ResourceGroupName `
            -Location $Location
    }
    catch [System.Exception]
    {
        Write-Error -Message "An error occured during the creation of the Azure Resource Group.`n$($_.exception.message)"
    }
}

function Remove-AzureTestCosmosDbResourceGroup
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $ResourceGroupName
    )

    try
    {
        Write-Verbose -Message ('Removing test Azure Resource Group {0}.' -f $ResourceGroupName)

        $null = Remove-AzureRmResourceGroup `
            -Name $ResourceGroupName `
            -Force `
            -AsJob
    }
    catch [System.Exception]
    {
        Write-Error -Message "An error occured during the removal of the Azure Resource Group.`n$($_.exception.message)"
    }
}

Export-ModuleMember -Function `
    Get-AzureServicePrincipal, `
    Connect-AzureServicePrincipal, `
    New-AzureTestCosmosDbAccount, `
    Remove-AzureTestCosmosDbAccount, `
    New-AzureTestCosmosDbResourceGroup, `
    Remove-AzureTestCosmosDbResourceGroup
