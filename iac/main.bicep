@minLength(1)
@maxLength(20)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param name string
param location string
param uniqueSuffix string
@secure()
param adminUsername string
@secure()
param adminPassword string

var resourceName = '${name}-${uniqueSuffix}'

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'rg-${name}-${location}-${uniqueSuffix}'
  location: location
  tags: {
    'azd-env-name': name
  }
}

module publicIPAddress 'modules/publicIPAddress.bicep' = {
  name: '${deployment().name}--publicIPAddress'
  scope: resourceGroup
  params:{
    name: resourceName
    location: resourceGroup.location
  }
}

module virtualNetwork 'modules/virtualNetwork.bicep' = {
  name: '${deployment().name}--virtualNetwork'
  scope: resourceGroup
  params:{
    name: resourceName
    location: resourceGroup.location
  }
}

module networkSecurityGroup 'modules/networkSecurityGroup.bicep' = {
  name: '${deployment().name}--networkSecurityGroup'
  scope: resourceGroup
  params:{
    name: resourceName
    location: resourceGroup.location
  }
}

module networkInterface 'modules/networkInterface.bicep' = {
  name: '${deployment().name}--networkInterface'
  scope: resourceGroup
  dependsOn: [
    publicIPAddress
    virtualNetwork
    networkSecurityGroup
  ]
  params:{
    name: resourceName
    location: resourceGroup.location
  }
}
module sqlServer 'modules/sqlServer.bicep' = {
  name: '${deployment().name}--sqlServer'
  scope: resourceGroup
  params: {
    name: resourceName
    location: resourceGroup.location
    adminPassword: adminPassword
    adminUsername: adminUsername
  }
}

module virtualMachine 'modules/virtualMachine.bicep' = {
  name: '${deployment().name}--vm'
  scope: resourceGroup
  dependsOn: [
    networkInterface
  ]
  params:{
    name: resourceName
    location: resourceGroup.location
    adminUsername: adminUsername
    adminPassword: adminPassword
  }
}

module storage 'modules/storageAccount.bicep' = {
  name: '${deployment().name}--storage'
  scope: resourceGroup
  params: {
    name: resourceName
    location: location
  }
}

module blob 'modules/storageBlob.bicep' = {
  name: '${deployment().name}--blob'
  scope: resourceGroup
  dependsOn: [
    virtualMachine
    storage
  ]
  params: {
    name: resourceName
    blobName: name
  }
}

module share 'modules/storageFile.bicep' = {
  name: '${deployment().name}--share'
  scope: resourceGroup
  dependsOn: [
    virtualMachine
    storage
  ]
  params: {
    name: resourceName
    shareName: name
  }
}

module shutdown 'modules/shutdownSchedule.bicep' = {
  name: '${deployment().name}--shutdown'
  scope: resourceGroup
  dependsOn: [
    virtualMachine
  ]
  params: {
    name: resourceName
    location: location
  }
}

module command 'modules/runCommand.bicep' = {
  name: '${deployment().name}--command'
  scope: resourceGroup
  dependsOn: [
    virtualMachine
  ]
  params: {
    name: resourceName
    location: location
  }
}
