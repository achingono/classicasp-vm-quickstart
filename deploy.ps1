param (
    [Parameter(Mandatory=$true)]
    [string]$name,
    [Parameter(Mandatory=$true)]
    [string]$location,
    [Parameter(Mandatory=$true)]
    [string]$suffix,
    [Parameter(Mandatory=$true)]
    [string]$adminUsername,
    [Parameter(Mandatory=$true)]
    [string]$adminPassword
)

# Run deployment
az deployment sub create --name $name --location $location --template-file ./iac/main.bicep `
    --parameters name=$name `
    --parameters location=$location `
    --parameters uniqueSuffix=$suffix `
    --parameters adminUsername=$adminUsername `
    --parameters adminPassword=$adminPassword;
