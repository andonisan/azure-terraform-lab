[CmdletBinding()]
param(
    [Parameter(Position=0,Mandatory,ValueFromPipeline)]
    [ValidateNotNullOrEmpty()]
    [string]$SubscriptionId
)

function Main ([string]$SubscriptionId) {
    CreateServicePrincipals $SubscriptionId.ToLower()
}

function CreateServicePrincipals([string]$SubscriptionId) {    

    Write-Host "Setting Azure subscription..."
    az account set --subscription $SubscriptionId 

    # We create the main service for access from Azure DevOps
    $SERVICE_PRINCIPAL_AZURE_DEVOPS = az ad sp create-for-rbac --name "sp-workshop-test" --role contributor  | ConvertFrom-Json

    [Console]::ResetColor()    
    Write-Host "Subscription Id"
    Write-Host ($SubscriptionId | Format-List | Out-String)
    Write-Host "Service Principal Id"
    Write-Host ($SERVICE_PRINCIPAL_AZURE_DEVOPS.appId | Format-List | Out-String)
    Write-Host "Service Principal Key"
    Write-Host ($SERVICE_PRINCIPAL_AZURE_DEVOPS.password | Format-List | Out-String)
    Write-Host "Tenant Id"
    Write-Host ($SERVICE_PRINCIPAL_AZURE_DEVOPS.tenant | Format-List | Out-String)
}

# Main function
Main $SubscriptionId