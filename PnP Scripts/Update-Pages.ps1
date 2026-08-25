$userName = "SVC-SPO-CorePlus@ecolab.com"
$password = ConvertTo-SecureString "S#wT2tTy6jJ&q!27E" -AsPlainText -Force
$credentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName,$password

$data = Import-Excel "C:\Users\spadmin\Desktop\PowerShell\Page-Changes.xlsx"
foreach($row in $data) {
    Connect-PnPOnline -Url $row.Site -Credentials $credentials
    
    $templatePage = Get-PnPClientSidePage -Identity $row.Page
    $pageItem = Get-PnPListItem -List "Site Pages" -Id $templatePage.PageId
    $templateSections = $templatePage.Sections
    $templateWebparts = $templatePage.Controls
    #$templateWebpart = @() #New-Object System.Collections.Generic.List[PnP.Core.Model.SharePoint.ICanvasControl]
    for($i = ($templateWebparts.Count - 1); $i -ge 0; $i--) {
        try {
            $uniqueWebPartId = $templateWebparts[$i].Properties.GetProperty("uniqueWebPartId")
        }
        catch {
            $templateWebparts.RemoveAt($i)
        }
    }
    $templateWebparts.Count
    $query = "<View><Query><Where><Eq><FieldRef Name='ContentTypeId'/><Value Type='Text'>" + $pageItem.FieldValues.ContentTypeId + "</Value></Eq></Where></Query></View>"
    $pages = Get-PnPListItem -List "Site Pages" -Query $query
    foreach($page in $pages) {
        Write-Host "Updating page -" $page.FieldValues.FileLeafRef
        $sitePage = Get-PnPPage -Identity $page.FieldValues.FileLeafRef
        $removeWebparts = $sitePage.Controls
        for($i = 0; $i -lt $templateWebparts.Count; $i++) {
            $templateWebpart = Get-PnPPageComponent -Page $templatePage -InstanceId $templateWebparts[$i].InstanceId
            Write-Host "Adding" $templateWebpart.Title
            
            if($removeWebparts.Count -gt 0) {
                for($j = ($removeWebparts.Count - 1); $j -ge 0; $j--) {
                    try {
                        $uniqueWebPartId1 = $removeWebparts[$j].Properties.GetProperty("uniqueWebPartId")
                        $uniqueWebPartId2 = $templateWebpart.Properties.GetProperty("uniqueWebPartId")
                        if($uniqueWebPartId1.ToString() -eq $uniqueWebPartId2.ToString()) {
                            Write-Host "Removing Webpart:" $removeWebparts[$j].InstanceId
                            Remove-PnPPageComponent -Page $sitePage -InstanceId $removeWebparts[$j].InstanceId -Force
                        }
                    }
                    catch { }
                }
            }

            Write-Host "Section:" $templateWebpart.Section.Order " & Column:" $templateWebpart.Column.Order " & Order:" $templateWebpart.Order
            if($templateWebparts[$i].Type.toString() -eq "PnP.Core.Model.SharePoint.PageText") {
                Add-PnPPageTextPart -Page $sitePage -Text $templateWebpart.Text -Section $templateWebpart.Section.Order -Column $templateWebpart.Column.Order -Order $templateWebpart.Order
            }
            elseif($templateWebparts[$i].Type.toString() -eq "PnP.Core.Model.SharePoint.PageWebPart") {
                try {
                    Write-Host "Adding as Component"
                    Add-PnPPageWebPart -Page $sitePage -Component $templateWebpart.Title -WebPartProperties $templateWebpart.PropertiesJson -Section $templateWebpart.Section.Order -Column $templateWebpart.Column.Order -Order $templateWebpart.Order
                }
                catch {
                    Write-Host "Adding as Default"
                    Add-PnPPageWebPart -Page $sitePage -DefaultWebPartType $templateWebpart.Title -WebPartProperties $templateWebpart.PropertiesJson -Section $templateWebpart.Section.Order -Column $templateWebpart.Column.Order -Order $templateWebpart.Order
                }
            }
        }
        
        Set-PnPPage -Identity $page.FieldValues.FileLeafRef -Publish
    }

    Disconnect-PnPOnline 
}