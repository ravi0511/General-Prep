#The following scripts are to replace the duplicate contentType with original contentType

#For the below 5000 records:

$SiteURL = "https://ecolab.sharepoint.com/sites/CorePlus_Dev_Products"
$UserName = "SVC-SPO-CorePlus@ecolab.com"
$Password = "S#wT2tTy6jJ&q!27E"
$Encpassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credentials = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $UserName, $Encpassword
$ListName = "Products"
$OldContentTypeName = "ProductDuplicate"
$NewContentTypeName = "Product"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Credentials $Credentials
 
#Get the New Content Type from the List
$NewContentType = Get-PnPContentType -List $ListName | Where {$_.Name -eq $NewContentTypeName}
 
#Get List Items of Old content Type
$ListItems = Get-PnPListItem -List $ListName -Query "<View><Query><Where><Eq><FieldRef Name='ContentType'/><Value Type='Computed'>$OldContentTypeName</Value></Eq></Where></Query></View>"
Write-host "Total Number of Items with Old Content Type:"$ListItems.count
 
ForEach($Item in $ListItems)
{
    Set-PnPListItem -List $ListName -Identity $Item -ContentType $NewContentType
}

#For the above 5000 records:

$SiteURL = "https://ecolab.sharepoint.com/sites/CorePlus_Dev_Products"
$UserName = "SVC-SPO-CorePlus@ecolab.com"
$Password = "S#wT2tTy6jJ&q!27E"
$Encpassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
$Credentials = New-Object -typename System.Management.Automation.PSCredential -ArgumentList $UserName, $Encpassword
$ListName = "Products"
$OldContentTypeName = "ProductDuplicate"
$NewContentTypeName = "Product"
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Credentials $Credentials
$List =  Get-PnPList -Identity $ListName
 
#Get the Old and New Content Types from the List
$OldContentType = Get-PnPContentType -List $ListName | Where {$_.Name -eq $OldContentTypeName}
$NewContentType = Get-PnPContentType -List $ListName | Where {$_.Name -eq $NewContentTypeName}
 
#Get List Items of old content type from the list
$global:counter = 0;
$ListItems = Get-PnPListItem -List $List -PageSize 500 -Fields ContentTypeId -ScriptBlock { Param($items) $global:counter += $items.Count; Write-Progress -PercentComplete `
              ($global:Counter / ($List.ItemCount) * 100) -Activity "Getting Items from List" -Status "Checking Items $global:Counter to $($List.ItemCount)"} | Where {$_.FieldValues.ContentTypeId.ToString() -eq $OldContentType.StringId}
 
Write-host "Total Number of Items with Old Content Type Found:"$ListItems.count
#Loop through List Items
ForEach($Item in $ListItems)
{
    Set-PnPListItem -List $ListName -Identity $Item -ContentType $NewContentType | Out-Null
    Write-host "Content Type Updated for List Item ID $($Item.ID)!" -f Green
}
