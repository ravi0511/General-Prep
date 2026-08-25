# ----------------------------------------------------------------------
# COREPLUS: CREATE KNOWLEDGE CENTER FROM TEMPLATE
# ----------------------------------------------------------------------
# 1. Run this script
# 2. Wait 3-5 minutes. Not doing so causes the next step to fail
# 3. We need to raise a ticket for admin access in order to add app files to the app catalog.
# 4. URL to raise a SharePoint service ticket: 
#    https://ecolab.service-now.com/myecolab?id=sc_cat_item&sys_id=9f07d38edbdc18d096f83cae7c9619ad&table=sc_cat_item&searchTerm=Sharepoint%20support%20form.
# 5. Once admin access is granted, please complete the following steps within 24 hours.
# 6. Add app files to app catalog and deploy (after uploading the file, wait until the page reloads - do not refresh it yourself)
# 7. Add apps to site contents
# 8. In the Documents Library, enable custom content types and add: Library Document
# 9. In the Site Pages Library, add the content types: Knowledge Center, Knowledge Center Section, Knowledge Center Subsection, General Page, Topic Page, News
# 10. Use ShareGate to perfrom a "Content and Structure" migration to migrate the template KC to the new KC
# 11. Rename the site to the proper name from "Core KC Template"
# 12. In site settings, change the default value for the Primary KC column to the term that matches the site name
# 13. Edit the home page's web parts to reflect the new KC site name
# 14. Edit the Topic and General template pages' web parts to reflect the new KC site name
# 15. In Site Settings -> People and Groups, rename the "CorePlus KC" permissions groups to reflect the new KC site name
# 16. Ensure the "Admin Dashboard" link in the top nav is pointing to the Admin Dashboard page locally in the site collection
# 17. Make an entry in the Configuration list about the newly created document library title and it's site for subscripting to the archival process.
#    https://ecolab.sharepoint.com/sites/CORE-COREplusAdminKC/Lists/Webhook%20Configuration/AllItems.aspx
# ---------------------------------------------------------------------


# Get KC Name
$kcName = Read-Host "Enter the name of the Knowledge Center"
# $kcOwner = Read-Host "Enter the email of the new Knowledge Center owner"
$kcOwner = "svc-spo-coreplus@ecolab.com"

# Remove Spaces from KC Name for URL & Create Destination URL
$kcUrlName = $kcName.Replace(" ","")
$kcUrl = "https://ecolab.sharepoint.com/sites/CORE-" + $kcUrlName
$tenantUrl = "https://ecolab-admin.sharepoint.com"

# Connect to Admin 
Connect-PnPOnline -Url $tenantUrl -Interactive

# Create New Communication Site
try {
    New-PnPTenantSite -Title $kcName -Url $kcUrl -Template "SITEPAGEPUBLISHING#0" -TimeZone 10  -Owner $kcOwner
    Write-Host "SITE: $kcName site created successfully [$kcUrl]" -ForegroundColor Green
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Failed to create new site collection" -ForegroundColor Red
    Write-Host "Error: $errorMessage" -ForegroundColor Red
}

# Wait for New Site Collection to Provision
Write-Host "SITE: Waiting 60 seconds for site collection to create properly..." -ForegroundColor Cyan
Start-Sleep -Seconds 60

# Associate New Communication Site to Hub
$hubSiteUrl = "https://ecolab.sharepoint.com/sites/CorePlus"
try {
    Add-PnPHubSiteAssociation -Site $kcUrl -HubSite $hubSiteUrl
    Write-Host "SITE: $kcName associated to CorePlus hub" -ForegroundColor Green
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Failed to associate new site to CorePlus hub" -ForegroundColor Red
    Write-Host "Error: $errorMessage" -ForegroundColor Red
}

#region TERMS

# Create Terms
$termGroupName = "Core"
$kcTermSetName = "Knowledge Centers"
$kcSectionTermSetName = "KC Sections"
$kcSubsectionTermSetName = "KC Subsections"
$displayTermSetName = "Core Structure"

# KNOWLEDGE CENTER TERM: Add Term to KC Term Set
if (-Not (Get-PnPTerm -Identity $kcName -TermSet $kcTermSetName -TermGroup "Core" -ErrorAction SilentlyContinue))
{
    try {
        New-PnPTerm -Name $kcName -TermSet $kcTermSetName -TermGroup $termGroupName | Out-Null
        Write-Host "TERM: $kcName term created in Knowledge Center term set." -ForegroundColor Green
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Knowledge Center term ($kcName) failed to create in $kcTermSetName Set." -ForegroundColor Red
        Write-Host "Error: $errorMessage" -ForegroundColor Red
    }
} else {
    Write-Host "Knowledge Center term ($kcName) already exists in $kcTermSetName set!" -ForegroundColor Red
}

# KNOWLEDGE CENTER SECTION TERM: Add Term to KC Section Term Set
if (-Not (Get-PnPTerm -Identity $kcName -TermSet $kcSectionTermSetName -TermGroup "Core" -ErrorAction SilentlyContinue))
{
    try {
        New-PnPTerm -Name $kcName -TermSet $kcSectionTermSetName -TermGroup $termGroupName | Out-Null
        Write-Host "TERM: $kcName term created in Knowledge Center Section term set." -ForegroundColor Green
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Knowledge Center Section term ($kcName) failed to create in $kcSectionTermSetName term set." -ForegroundColor Red
        Write-Host "Error: $errorMessage" -ForegroundColor Red
    }
} else {
    Write-Host "Knowledge Center Section term ($kcName) already exists in $kcSectionTermSetName term set!" -ForegroundColor Red
}

# KNOWLEDGE CENTER SUBSECTION TERM: Add Term to KC Subsection Term Set
if (-Not (Get-PnPTerm -Identity $kcName -TermSet $kcSubsectionTermSetName -TermGroup "Core" -ErrorAction SilentlyContinue))
{
    try {
        New-PnPTerm -Name $kcName -TermSet $kcSubsectionTermSetName -TermGroup $termGroupName | Out-Null
        Write-Host "TERM: $kcName term created in Knowledge Center Subsection term set." -ForegroundColor Green
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Knowledge Center Subsection term ($kcName) failed to create in $kcSubsectionTermSetName term set." -ForegroundColor Red
        Write-Host "Error: $errorMessage" -ForegroundColor Red
    }
} else {
    Write-Host "Knowledge Center Subsection term ($kcName) already exists in $kcSubsectionTermSetName term set!" -ForegroundColor Red
}

# DISPLAY TERM: Add Term to Display Term Set
if (-Not (Get-PnPTerm -Identity $kcName -TermSet $displayTermSetName -TermGroup "Core" -ErrorAction SilentlyContinue))
{
    try {
        New-PnPTerm -Name $kcName -TermSet $displayTermSetName -TermGroup $termGroupName | Out-Null
        Write-Host "TERM: $kcName term created in Display term set." -ForegroundColor Green
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Knowledge Center Display term ($kcName) failed to create in $displayTermSetName term set." -ForegroundColor Red
        Write-Host "Error: $errorMessage" -ForegroundColor Red
    }
} else {
    Write-Host "Knowledge Center Display term ($kcName) already exists in $displayTermSetName term set!" -ForegroundColor Red
}
#endregion

#region APPCATALOG

# Create App Catalog & Add Apps
try {
    Add-PnPSiteCollectionAppCatalog -Site $kcUrl
    Write-Host "SITE: Site collection scoped app catalog created" -ForegroundColor Green
} catch {
    Write-Host "Failed to create site collection scope app catalog" -ForegroundColor Red
    Write-Host "Error: $errorMessage" -ForegroundColor Red
}

#endregion

#region CUSTOMSCRIPTING
try {
    Connect-SPOService -Url $tenantUrl
    Set-SPOSite -Identity $kcUrl -DenyAddAndCustomizePages $false
    Write-Host "SITE: Custom scripting enabled. Site is ready for template application" -ForegroundColor Green
} catch {
    Write-Host "Failed to enable custom scripting on new KC. This is required for template application." -ForegroundColor Red
    Write-Host "Error: $errorMessage" -ForegroundColor Red
}
#endregion

#region Add HTML Field Security
try {
    $htmlCDonnecion = Connect-PnPOnline -Url $kcUrl -Interactive
    $site = Get-PnPSite -Includes CustomScriptSafeDomains -Connection $htmlCDonnecion
    $object = [PSCustomObject]@{
        DomainName = "ecolab.kzoplatform.com"
    } 
    $site.CustomScriptSafeDomains.Create($object)
    Invoke-PnPQuery
} catch {
    Write-Host "Failed to Add HTML Field Security domain KZO" -ForegroundColor Red
    Write-Host "Error: $errorMessage" -ForegroundColor Red
}
#endregion