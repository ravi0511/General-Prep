Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\SharePoint Online Management Shell\Microsoft.Online.SharePoint.PowerShell\Microsoft.SharePoint.Client.Runtime.dll"


$tenantUrl = "https://ecolab-admin.sharepoint.com"
$kcOwner = "svc-spo-coreplus@ecolab.com"
#$kcOwnerPassword = ConvertTo-SecureString -String 'zW57oZ$Bz6' -AsPlainText -Force
#$credential = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $kcOwner, $kcOwnerPassword
$kcUrl = "https://ecolab.sharepoint.com/sites/CorePlus_Dev_Products"

#Connect-SPOService -Url $tenantUrl
#Set-SPOSite -Identity $kcUrl -DenyAddAndCustomizePages $false
#Write-Host "SITE: Custom scripting enabled. Site is ready for template application" -ForegroundColor Green


# Connect to Admin 
$htmlCDonnecion = Connect-PnPOnline -Url $kcUrl -Interactive

$site = Get-PnPSite -Includes CustomScriptSafeDomains -Connection $htmlCDonnecion
$object = [PSCustomObject]@{
       DomainName = "ecolab.kzoplatform.com"
} 
$site.CustomScriptSafeDomains.Create($object)
Invoke-PnPQuery