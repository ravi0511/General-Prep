#Install-Module PnP.PowerShell -Scope CurrentUser

$SiteURL = "https://ecolab.sharepoint.com/sites/CORE-WaterSafety"
$ListName = "Shared Documents" 

Connect-PnPOnline -Url $SiteUrl

Import-csv -path C:\PNPpowershell\SecondWave\ReviewDate_WaterSafety.csv |
    Foreach-object {

    Write-Host $_.ID

$ListItem = Get-PnPListItem -List $ListName -Id $_.ID -ErrorAction Stop
 

Set-PnPListItem -List $ListName -Identity $ListItem -Values @{"Review_x0020_Date" = ([System.TimeZoneInfo]::ConvertTimeFromUtc((Get-Date).AddMonths(2).ToUniversalTime(), [System.TimeZoneInfo]::FindSystemTimeZoneById('Pacific Standard Time')))}
}


