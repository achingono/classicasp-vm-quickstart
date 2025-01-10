# Classic ASP VM Quickstart

This repository provides a quickstart guide for setting up a Virtual Machine (VM) to run a Classic ASP application.

## VM Configuration

This repository includes a Bicep template (`runCommand.bicep`) and a PowerShell script (`runCommand.ps1`) to automate the configuration of the VM to run Classic ASP.

### Bicep Template

The `runCommand.bicep` file defines the infrastructure and configuration for the VM. It includes the necessary resources and settings to ensure the VM is ready to run Classic ASP applications.

### PowerShell Script

The `runCommand.ps1` script is executed on the VM to install IIS, enable Classic ASP, and configure the server. This script performs the following actions:

1. Installs the IIS web server.
2. Enables the Classic ASP feature in IIS.
3. Configures IIS settings to optimize the server for Classic ASP applications.

To deploy and configure the VM using these files, follow these steps:

1. Deploy the VM using the Bicep template:

    ```bash
    az deployment group create --resource-group myResourceGroup --template-file runCommand.bicep
    ```

2. After the VM is deployed, run the PowerShell script to configure the VM:

    ```bash
    az vm run-command invoke --command-id RunPowerShellScript --name myVM --resource-group myResourceGroup --scripts @runCommand.ps1
    ```

These steps will ensure that your VM is fully configured to run Classic ASP applications.

## Prerequisites

Before you begin, ensure you have the following:

- An Azure subscription
- Azure CLI installed
- Basic knowledge of Classic ASP and Virtual Machines

## Getting Started

### Step 1: Clone the Repository

Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/achingono/classicasp-vm-quickstart.git
cd classicasp-vm-quickstart
```

### Step 2: Create a Resource Group

Create a resource group in Azure where all resources will be deployed:

```bash
az group create --name myResourceGroup --location eastus
```

### Step 3: Deploy the VM

Deploy the VM using the provided ARM template:

```bash
az deployment group create --resource-group myResourceGroup --template-file azuredeploy.json
```

### Step 4: Configure the VM

After deployment, connect to the VM and configure it to run Classic ASP:

1. Connect to the VM using RDP.
2. Install IIS and enable Classic ASP.
3. Deploy your Classic ASP application to the IIS server.

### Step 5: Access the Application

Once the application is deployed, access it via the public IP address of the VM.

## Cleanup

To remove all resources created during this quickstart, use the following command:

```bash
az group delete --name myResourceGroup --yes --no-wait
```

## Contributing

If you would like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

Special thanks to all contributors and the community for their support.
