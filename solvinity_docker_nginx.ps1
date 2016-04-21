Param(
  [string]$deploy_name  = 'solvinity-deploy',
  [string]$rg_name      = 'solvinity-rg',
  [string]$location     = 'West Europe',
  [string]$vnet_cidr    = '10.10.0.0/24',
  [string]$vmname       = 'solvinity-vm01',
  [string]$dnsname      = 'solvinity-dns'
)

Login-AzureRmAccount
$credentials = Get-Credential -Message "Username and Password for the account to be created on the Docker Host"
$storageaccountname = ($rg_name -creplace '[^a-zA-Z0-9]').toLower()
$params_hash = @{ "vmname" = $($vmname);
     "adminUsername"       = $($credentials.Username);
     "adminPassword"       = $($credentials.Password);
     "addressPrefix"       = $($addressPrefix);
     "dnsname"             = $($dnsname);
     "storageaccountname"  = $($storageaccountname)
}

$tmp_dir = "c:\temp\solvinity-" + (Get-Date -UFormat %s)
mkdir $temp_dir
Set-Location $temp_dir
git clone https://github.com/hazelwood69/solvinity.git

$rg_list = Get-AzureRmResourceGroup
$existing_resource_groups = @()
foreach ($rg in $rg_list) { $script:existing_resource_groups += $rg.ResourceGroupName }
if    ($existing_resource_groups.Contains($rg_name)) { Write-Host "Resource Group already exists, skipping creation of" $rg_name  "in"  $rg.Location -foregroundcolor "yellow" }
else  {
  Write-Host "Resource Group $rg_name not found, creating it now" -foregroundcolor "yellow"
  New-AzureRmResourceGroup -Name $rg_name -Location $location -Force
}

New-AzureRmResourceGroupDeployment  -Name ("$rg_name-" + (Get-Date -UFormat "%A.%d.%m.%Y-%H-%M")) `
                                    -ResourceGroupName  $rg_name `
                                    -TemplateFile       "$temp_dir\azr_template\azuredeploy_solvinity.json" `
                                    -TemplateParameterObject  $parameters

$publicIP = Get-AzureRMPublicIPAddress -ResourceGroupName $rg_name -Name ($dnsname + "_publicIP")
$url = ('http://' + $publicIP.dnsSettings.FQDN)
$response = Invoke-WebRequest -Uri $url

if ($response.StatusCode -eq 200) { Start $url }
else { Write-Host "Oops! We received a status code of $($response.StatusCode) while expecting a 200" -foregroundcolor "red" }
