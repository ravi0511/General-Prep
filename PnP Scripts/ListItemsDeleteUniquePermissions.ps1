#Set Variables
$SiteURL = "https://ecolab.sharepoint.com/sites/Products"
$ListName = "Product Documents"
  
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive

#Get all list items in batches
$ListItems = Get-PnPListItem -List $ListName -PageSize 500
$ListCount = $ListItems.Count
$Counter = 1
 
#Iterate through each list item
ForEach($ListItem in $ListItems)
{
    #Check if the Item has unique permissions
    $HasUniquePermissions = Get-PnPProperty -ClientObject $ListItem -Property "HasUniqueRoleAssignments"
    If($HasUniquePermissions)
    {       
        $Msg = "[$Counter/$ListCount] Deleting Unique Permissions on {0} '{1}' at {2} " -f $ListItem.FileSystemObjectType,$ListItem.FieldValues["FileLeafRef"],$ListItem.FieldValues["FileRef"]
        Write-host $Msg
        #Delete unique permissions on the list item
        Set-PnPListItemPermission -List $ListName -Identity $ListItem.ID -InheritPermissions
    }

    $Counter++
}