param (
    [Parameter(Mandatory=$true)]
    [string]$name,
    [Parameter(Mandatory=$true)]
    [string]$location,
    [Parameter(Mandatory=$true)]
    [string]$suffix
)

$GROUP="rg-${name}-${location}-${suffix}"

$confirm = Read-Host -Prompt "WARNING: This will delete all Azure resources in resource group $GROUP. Are you sure? (Y/N): ";

if ($confirm -match "^[yY]([eE][sS])?$") Return;

$linger = Read-Host -Prompt "Would you like the command to wait for operation to complete (otherwise deletion will continue in the background)? (Y/N):";

if ($linger -match "^[yY]([eE][sS])?$")
{
    az group delete --name $GROUP --yes
}
else {
    az group delete --name $GROUP --yes --no-wait
}