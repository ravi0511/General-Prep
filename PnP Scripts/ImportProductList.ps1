# Get Products from SharePoint
Connect-PnPOnline -Url "https://ecolab.sharepoint.com/sites/Products" -Interactive
$productListItems = Get-PnPListItem -List "Products" -Fields "Title", "Product_x0020_Name", "Product_x0020__x0023_" -PageSize 500

# Create Log File
$date = Get-Date -Format MM-dd-yyyy
$desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
$logFileName = "ProductAddLog_$date"
$logFilePath = "$desktopPath\$logfileName.csv"


# Establish Products CSV Path
$productListFilePath = "C:\Users\Ryanw\Desktop\ES_Documents_RK.csv"

# Import Products CSV
$csv = Import-Csv $productListFilePath

# Iterate Through Products CSV
$csv | ForEach-Object {
    $productNumber = $_.ProductNo
    $productName = $_.ProductName

    # Check if Product Exists in SharePoint (By Product Number)
    if (!($productListItems | Where-Object {$_.FieldValues.Product_x0020__x0023_ -eq $productNumber}))
    {
        # Add Product to SharePoint List
        try {
            Add-PnPListItem -List "Products" -Values @{
                "Product_x0020__x0023_" = $productNumber;
                "Product_x0020_Name" = $productName
            } | Out-Null

            Write-Host "[$productNumber] Added successfully" -ForegroundColor Green
            $exportItem = New-Object PSObject
            $exportItem | Add-Member -Type NoteProperty -Name "Added?" -Value "Y"
            $exportItem | Add-Member -Type NoteProperty -Name "ProductNumber" -Value $productNumber
            $exportItem | Add-Member -Type NoteProperty -Name "ProductName" -Value $productName
            $exportItem | Add-Member -Type NoteProperty -Name "Error" -Value ""
            $exportItem | Export-Csv $logFilePath -NoTypeInformation -Append
        } catch {
            Write-Host "[$productNumber] Failed to add to the products list" -ForegroundColor Red
            $errorMessage = $_.Exception.Message
            $exportItem = New-Object PSObject
            $exportItem | Add-Member -Type NoteProperty -Name "Added?" -Value "N"
            $exportItem | Add-Member -Type NoteProperty -Name "ProductNumber" -Value $productNumber
            $exportItem | Add-Member -Type NoteProperty -Name "ProductName" -Value $productName
            $exportItem | Add-Member -Type NoteProperty -Name "Error" -Value $errorMessage
            $exportItem | Export-Csv $logFilePath -NoTypeInformation -Append
        }
    }
    else {
        Write-Host "[$productNumber] Already exists in the products list" -ForegroundColor Cyan
        $exportItem = New-Object PSObject
        $exportItem | Add-Member -Type NoteProperty -Name "Added?" -Value "N"
        $exportItem | Add-Member -Type NoteProperty -Name "ProductNumber" -Value $productNumber
        $exportItem | Add-Member -Type NoteProperty -Name "ProductName" -Value $productName
        $exportItem | Add-Member -Type NoteProperty -Name "Error" -Value "Product already exists in list"
        $exportItem | Export-Csv $logFilePath -NoTypeInformation -Append
    }
}


