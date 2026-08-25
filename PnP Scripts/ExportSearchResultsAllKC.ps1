Install-Module PnP.PowerShell -Scope CurrentUser

$CSVFile = "C:\PNPpowershell\Batch 4\In-Person Service Review.csv"
$tenantUrl = "https://ecolab-admin.sharepoint.com"
Connect-PnPOnline -Url $tenantUrl
$Results = @()

Import-csv -path C:\PNPpowershell\KCURLs.csv |
Foreach-object {

    $SiteURL = $_.SiteURL

    Write-Host $SiteURL

    $SearchQuery = '("Service Chexx Report" OR Title:"Service Chexx Report")' +
' AND (ContentType:"Library Document"' +
' OR FileType:docx OR FileType:doc' +
' OR FileType:pptx OR FileType:ppt' +
' OR FileType:xlsx OR FileType:xls' +
' OR FileType:pdf' +
' OR FileType:txt' +
' OR FileType:rtf' +
' OR FileType:odt OR FileType:ods OR FileType:odp' +
' OR FileType:csv' +
' OR FileType:msg' +
' OR FileType:one)' +
' AND Path:' + $SiteURL 

    #Execute Search
    $SearchResults = Submit-PnPSearchQuery -Query $SearchQuery -All -TrimDuplicates $False -SelectProperties Filename, Author, PrimaryKC, Title, LastModifiedTime

    #Collect Data from search results
    ForEach ($ResultRow in $SearchResults.ResultRows)
    {    
        $Results += [pscustomobject] @{
            Filename   = $ResultRow["Filename"]
            Author = $ResultRow["Author"]
            PrimaryKC = $ResultRow["PrimaryKC"]
            LastModified = $ResultRow["LastModifiedTime"]
            Title     = $ResultRow["Title"]
            URL       = $ResultRow["Path"]
        }
    }
}

$Results

#Export results to CSV
$Results | Export-Csv -Path $CSVFile -NoTypeInformation