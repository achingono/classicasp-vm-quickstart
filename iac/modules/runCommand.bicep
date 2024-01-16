param name string
param location string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' existing = {
  name: 'vm-${name}'
}

resource deploymentscript 'Microsoft.Compute/virtualMachines/runCommands@2022-03-01' = {
  parent: virtualMachine
  name: 'RunPowerShellScript'
  location: location
  properties: {
    source: {
      script: loadTextContent('runCommand.ps1')
    }
  }
}
