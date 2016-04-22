Param(
  [string]$deploy_name  = 'solvinity-deploy',
  [string]$rg_name      = 'test1',
  [string]$vmname       = 'solvinity-vm01'
)

Login-AzureRmAccount

$tmp_dir = "c:\temp\solvinity-" + (Get-Date -UFormat %s)
mkdir $tmp_dir
Set-Location $tmp_dir
git clone https://github.com/hazelwood69/solvinity.git

New-AzureRmResourceGroupDeployment  -Name $deploy_name `
                                    -ResourceGroupName $rg_name `
                                    -TemplateFile "$tmp_dir\solvinity\azr_template\azuredeploy_solvinity.json" `
                                    -TemplateParameterFile "$tmp_dir\solvinity\azr_template\azuredeploy_params_solvinity.json"

$publicIP = Get-AzureRMPublicIPAddress -ResourceGroupName $rg_name -Name ($vmname + "-publicIP")
$url = ('http://' + $publicIP.dnsSettings.FQDN)
Write-Host "publicIP: " + $publicIP
Write-Host "url: " + $url

$response = Invoke-WebRequest -Uri $url

if ($response.StatusCode -eq 200) { Start $url }
else { Write-Host "Error! Status code $($response.StatusCode)" -foregroundcolor "red" }
