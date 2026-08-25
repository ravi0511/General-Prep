#Install-Module PnP.PowerShell -Scope CurrentUser

$SiteURL = "https://ecolab.sharepoint.com/sites/CORE-Learning"

$DestSiteUrl = "https://ecolab.sharepoint.com/sites/CORE-LEX"

#$SourceLibraryURL = "Shared Documents" 
$TargetLibraryURL = "$DestSiteUrl/CORE KC Document Library Archive"

$outputCSV = "C:\PNPpowershell\outputFileInternalKC.csv"



Connect-PnPOnline -Url $SiteURL 
$results = @()
Import-csv -path C:\PNPpowershell\SecondWave\Unpublished_Learning.csv |
    
Foreach-object {
    Try {
        $FilePath = $_.FileName

        $splitArray = $FilePath.Split("/")
        $fileName = $splitArray[-1] # Get the last element (file name)

        if (-not $fileName.Contains("/")) # Check if the file name doesn't contain any forward slashes
        {
            $file = Get-PnPFile -Url $_.FileName
            $fileServerRelativeUrl = Get-PnPProperty -ClientObject $file -Property "ServerRelativeUrl"
            Write-host "FileName:" + $FilePath
            Move-PnPFile -ServerRelativeUrl $fileServerRelativeUrl -TargetServerRelativeLibrary $TargetLibraryURL -Force
            $LogMessege = $fileServerRelativeUrl

            Write-host "Moved Item:" $fileServerRelativeUrl
            $details = @{
                Date = Get-Date
                LogMessege = $LogMessege
                Action = "Move Item"
            }
            $results += New-Object PSObject -Property $details
        }
        else
        {
            $LogMessege1 = "Item ContainsFolder:" + $FilePath
            $details1 = @{
                Date = Get-Date
                LogMessege = $LogMessege1
                Action = "Item Contains Folder"
            }
            $results += New-Object PSObject -Property $details1
            Write-host "Item ContainsFolder:" $FilePath -ForegroundColor Yellow
        }
    }
    Catch {
        $LogMessege2 = "File Not Found" + $FilePath
        $details2 = @{
            Date = Get-Date
            LogMessege = $LogMessege2
            Action = "File Not Found"
        }
        $results += New-Object PSObject -Property $details2
        Write-host "Error:" $_.Exception.Message + "File Name" + $FilePath -ForegroundColor Yellow
    }
}
$results | Export-Csv -Path $outputCSV -NoTypeInformation