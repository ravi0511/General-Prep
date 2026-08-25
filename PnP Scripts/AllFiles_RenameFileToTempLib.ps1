#Install-Module PnP.PowerShell -Scope CurrentUser

$DestSiteUrl = "https://ecolab.sharepoint.com/sites/CORE-lex"
$outputCSV = "C:\PNPpowershell\outputRenamedChemicalKCFile.csv"



Connect-PnPOnline -Url $DestSiteUrl
$results = @()
Import-csv -path C:\PNPpowershell\SecondWave\Unpublished_WaterSafety.csv |
    Foreach-object {
    try{
    $FilePath = $_.FileName
$splitArray = $FilePath.Split("/")

    if($splitArray.Length -eq 2)
    {

$fileDest = Get-PnPFile -Url $_.FileName

$fileServerRelativeUrlDest = Get-PnPProperty -ClientObject $fileDest -Property "ServerRelativeUrl"

$FileName = $splitArray[-1];
#$NewFileName=$FileName.Replace('Temporary_','Temporary_Archive_')
$NewFileName = "Temporary_Archive_"+$FileName;
Rename-PnPFile -ServerRelativeUrl $fileServerRelativeUrlDest -TargetFileName $NewFileName -Force

Write-host "Renamed Item:"$NewFileName
$LogMessege = $NewFileName


$details = @{            
                Date             = get-date              
                LogMessege     = $LogMessege 
                Action = "Rename Item"  
                
        }                           
        $results += New-Object PSObject -Property $details 

}

else
{

$LogMessege1 = "Item ContainsFolder:" + $FilePath
$details1 = @{            
                Date             = get-date              
                LogMessege     = $LogMessege1     
                 Action = "Item Contains Folder"         
                
        }                           
        $results += New-Object PSObject -Property $details1 

Write-host "Item ContainsFolder:"$FilePath



}


}
catch{

write-host -f Red "Error:" $_.Exception.Message

Write-Host "File Not Found" + $FilePath

$LogMessege2 = "File Not Found" + $FilePath
$details2 = @{            
                Date             = get-date              
                LogMessege     = $LogMessege2 
                Action = "File Not Found"                  
        }                           
        $results += New-Object PSObject -Property $details2
}
}

$results | export-csv -Path $outputCSV -NoTypeInformation


