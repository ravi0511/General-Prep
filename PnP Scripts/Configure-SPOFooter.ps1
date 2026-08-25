$footerNavigation = @(
    "https://ecolab.sharepoint.com/sites/CorePlus_Dev"
    "https://ecolab.sharepoint.com/sites/CorePlus_Dev_Chemicals",
    "https://ecolab.sharepoint.com/sites/CorePlus_Dev_InternalKC",
    "https://ecolab.sharepoint.com/sites/COREplus_Dev_AdminKC",
    "https://ecolab.sharepoint.com/sites/CorePlus_Dev_Products",
    "https://ecolab.sharepoint.com/sites/Dev_SearchAllKCs",
    "https://ecolab.sharepoint.com/sites/CorePlus_Dev_LEX",
    "https://ecolab.sharepoint.com/sites/PrivateKC",
    "https://ecolab.sharepoint.com/sites/coreplus_qa",
    "https://ecolab.sharepoint.com/sites/CorePlus_QA_InternalKC",
    "https://ecolab.sharepoint.com/sites/CorePlus_QA_Chemicals",
    "https://ecolab.sharepoint.com/sites/CorePlus_QA_COREplusAdminKC",
    "https://ecolab.sharepoint.com/sites/Coreplus_QA_SearchAllKCs",
    "https://ecolab.sharepoint.com/sites/CorePlus_QA_Products",
    "https://ecolab.sharepoint.com/sites/privatecore-qa"
)

forEach ($link in $footerNavigation) {
    # Add-PnPNavigationNode -Title "Post a Question" -Url $link -Location Footer

    Connect-PnPOnline -Url $link -Interactive -ClientID 0b2d1e5e-3f9b-4cb3-89f7-4a2a2db7d139

    Set-PnPFooter -Enabled:$false

    $TemplateXML = "C:\Users\arra\Downloads\FooterConfiguration.xml"

    Invoke-PnPSiteTemplate -path $TemplateXML

    Write-Host "Footer navigation configured successfully for $link"
}
