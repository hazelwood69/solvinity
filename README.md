### solvinity
Deploy a standard nginx docker container in Azure Test subscription

# Requisites:
+ Azure Powershell CLI
+ Azure Subscription with azure resource group test1 to test this solution.
+ git

# logic:
ps1 script runs the deployment, 
manages login to Azure, check out the github template and params files and launches a new resource group deployment with template and params file passed as params to it.
Template input params:
    "storageAccountName": {
      "value": "solvinitystorage"
    },
    "adminUsername": {
      "value": "solvinity"
    },
    "adminPassword": {
      "value": "Solvinity_1"
    }
Template Variables:
    "imagePublisher": "Canonical",
    "imageOffer": "UbuntuServer",
    "skuOSVersion": "14.04.2-LTS", 
    "vmName": "solvinity-vm01",
    "OSDiskName": "[concat(variables('imagePublisher'),'-',variables('imageOffer'),'-',variables('skuOSVersion'),variables('vmName'))]",
    "extensionName": "docker-solvinity",
    "storageAccountType": "Standard_LRS",
    "publicIPAddressType": "Dynamic",
    "vmStorageAccountContainerName": "[concat('vhds-',variables('vmName'))]",
    "vmSize": "Standard_D1",
    "storageaccountname": "[toLower(parameters('storageAccountName'))]",
    "addressPrefix" : "192.168.100.0/24",
    "vmnicname": "[concat(variables('vmName'),'-nic')]",
    "vnetname": "[concat(resourceGroup().Name,'-vnet')]",
    "subnetname": "[concat(resourceGroup().Name,'-subnet')]",
    "publicipname": "[concat(variables('vmName'),'-publicIP')]",
    "sgname": "[concat(resourceGroup().Name,'-sg')]",
    "sgID": "[resourceId('Microsoft.Network/networkSecurityGroups',variables('sgname'))]",
    "avSetName": "[concat(resourceGroup().Name,'-avset')]",
    "dnsname":  "[concat(resourceGroup().Name,'-dns')]",

Template Resources:
	storageAccounts:        "Microsoft.Storage/storageAccounts"
	availabilitySets:       "Microsoft.Compute/availabilitySets"
	publicIPAddresses:      "Microsoft.Network/publicIPAddresses"
	virtualNetworks:        "Microsoft.Network/virtualNetworks"
	networkSecurityGroups:  "Microsoft.Network/networkSecurityGroups"
	networkInterfaces:      "Microsoft.Network/networkInterfaces"
	virtualMachines:        "Microsoft.Compute/virtualMachines",
	dockerextensions:       "Microsoft.Compute/virtualMachines/extensions",
	scriptextensions:       "Microsoft.Compute/virtualMachines/extensions",


# Execution:
1- clone repo to local
2- run C:\Users\dan\projects\solvinity [master ≡ +2 ~0 -0 !]> .\solvinity_docker_nginx.ps1


Environment           : AzureCloud
Account               : some@email.address
TenantId              : xxxxxxxx-yyyy-xxxx-yyyy-xxxxxxxxxxxx
SubscriptionId        : yyyyyyyy-xxxx-yyyy-xxxx-yyyyy
CurrentStorageAccount :


PSPath            : Microsoft.PowerShell.Core\FileSystem::C:\temp\solvinity-1461682692.43632
PSParentPath      : Microsoft.PowerShell.Core\FileSystem::C:\temp
PSChildName       : solvinity-1461682692.43632
PSDrive           : C
PSProvider        : Microsoft.PowerShell.Core\FileSystem
PSIsContainer     : True
Name              : solvinity-1461682692.43632
Parent            : temp
Exists            : True
Root              : C:\
FullName          : C:\temp\solvinity-1461682692.43632
Extension         : .43632
CreationTime      : 4/26/2016 2:58:12 PM
CreationTimeUtc   : 4/26/2016 12:58:12 PM
LastAccessTime    : 4/26/2016 2:58:12 PM
LastAccessTimeUtc : 4/26/2016 12:58:12 PM
LastWriteTime     : 4/26/2016 2:58:12 PM
LastWriteTimeUtc  : 4/26/2016 12:58:12 PM
Attributes        : Directory
Mode              : d-----
BaseName          : solvinity-1461682692.43632
Target            : {}
LinkType          :

Cloning into 'solvinity'...
remote: Counting objects: 108, done.
remote: Compressing objects: 100% (91/91), done.
remote: Total 108 (delta 65), reused 52 (delta 9), pack-reused 0
Receiving objects: 100% (108/108), 12.14 KiB | 0 bytes/s, done.
Resolving deltas: 100% (65/65), done.
Checking connectivity... done.
WARNING: The output object type of this cmdlet will be modified in a future release.

DeploymentName          : solvinity-deploy
CorrelationId           : 531790c7-4853-4fb4-adad-f16319f78a74
ResourceGroupName       : test1
ProvisioningState       : Succeeded
Timestamp               : 4/26/2016 12:59:14 PM
Mode                    : Incremental
TemplateLink            :
TemplateLinkString      :
DeploymentDebugLogLevel :
Parameters              : {[storageAccountName, Microsoft.Azure.Commands.Resources.Models.DeploymentVariable],
                          [adminUsername, Microsoft.Azure.Commands.Resources.Models.DeploymentVariable],
                          [adminPassword, Microsoft.Azure.Commands.Resources.Models.DeploymentVariable]}
ParametersString        :
                          Name             Type                       Value
                          ===============  =========================  ==========
                          storageAccountName  String                     solvinitystorage
                          adminUsername    String                     solvinity
                          adminPassword    SecureString

Outputs                 :
OutputsString           :

publicIP:  + Microsoft.Azure.Commands.Network.Models.PSPublicIpAddress
url:  + http://test1-dns.westeurope.cloudapp.azure.com

>>> see browser open


<a href="http://armviz.io/#/?load=https://raw.githubusercontent.com/hazelwood69/solvinity/master/azr_template/azuredeploy_solvinity.json" target="_blank">
  <img src="http://armviz.io/visualizebutton.png"/>
</a>