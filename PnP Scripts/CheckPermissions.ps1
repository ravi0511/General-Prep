$sites = @(
"https://ecolab.sharepoint.com/sites/CORE-GAM",
"https://ecolab.sharepoint.com/sites/CORE-GAH",
"https://ecolab.sharepoint.com/sites/CORE-Chemicals",
"https://ecolab.sharepoint.com/sites/CORE-COREplusAdminKC",
"https://ecolab.sharepoint.com/sites/CORE-KCTemplate",
"https://ecolab.sharepoint.com/sites/CORE-Digital",
"https://ecolab.sharepoint.com/sites/CORE-Downstream",
"https://ecolab.sharepoint.com/sites/CORE-Equipment",
"https://ecolab.sharepoint.com/sites/CORE-CoreWater",
"https://ecolab.sharepoint.com/sites/CORE-FoodandBeverage",
"https://ecolab.sharepoint.com/sites/CORE-HighTech",
"https://ecolab.sharepoint.com/sites/CORE-Institutional",
"https://ecolab.sharepoint.com/sites/CORE-InternalKC",
"https://ecolab.sharepoint.com/sites/CORE-LEX",
"https://ecolab.sharepoint.com/sites/CORE-Learning",
# "https://ecolab.sharepoint.com/sites/Products",
"https://ecolab.sharepoint.com/sites/CORE-Manufacturing",
"https://ecolab.sharepoint.com/sites/CORE-Paper",
"https://ecolab.sharepoint.com/sites/CORE-Power",
"https://ecolab.sharepoint.com/sites/CORE-PrimaryMetals",
"https://ecolab.sharepoint.com/sites/CORE-Transportation",
"https://ecolab.sharepoint.com/sites/CORE-WaterPurity",
"https://ecolab.sharepoint.com/sites/Core-Pest",
"https://ecolab.sharepoint.com/sites/Core-Mining",
"https://ecolab.sharepoint.com/sites/CORE-WaterSafety"
# "https://ecolab.sharepoint.com/sites/SearchAllKCs",
# "https://ecolab.sharepoint.com/sites/CorePlus",
# "https://ecolab.sharepoint.com/sites/CORE-ArchiveKC",
# "https://ecolab.sharepoint.com/sites/CORE-PowerDemo",
# "https://ecolab.sharepoint.com/sites/PRIVATECORE-InternalKC/",
# "https://ecolab.sharepoint.com/sites/PRIVATECORE-KCTemplate"
)

$users = @(
    "industrialknowledgemgmnt.tr-coregeneral@ecolab.com",
    "industrialknowledgemgmt.tr-coreelevated@ecolab.com",
    "fbfttestam14@nalco.com",
    "fbfttestam15@nalco.com",
    "fbfttestam16@nalco.com"
)

forEach ($link in $sites) {

    Connect-PnPOnline -Url $link -Interactive -ClientID 0b2d1e5e-3f9b-4cb3-89f7-4a2a2db7d139
    Write-Host "Report for Site: $($link)"
    #Get-PnPUserEffectivePermissions -User "industrialknowledgemgmt.tr-coreelevated@ecolab.com"

    # Set-PnPFooter -Enabled:$false

    # $TemplateXML = "C:\Users\arra\Downloads\FooterConfiguration.xml"

    # Invoke-PnPSiteTemplate -path $TemplateXML

    #Write-Host "Completed successfully for $link"

    $groups = Get-PnPGroup
    foreach( $user in $users) {
        Write-Host "Report for User: $($user)"
        foreach ($group in $groups) {
            # Write-Host "Group Title: $($group.Title)
            # $users = Get-PnPGroupMembers -Identity $group.Title
            # foreach ($user in $users) {
            #     Write-Host "  User: $($user.LoginName)"
            # }


                # $isMember = Get-PnPGroupMember -Group $group.Title -User $user -ErrorAction SilentlyContinue
                # if ($isMember) {
                #     Write-Host "User '$user' is a member of group '$($group.Title)'"
                # }


            $isexists = Get-PnPGroupMember -Group $group.Title -User $user

            if($isexists){
                Write-Host "    Member of Group: $($group.Title)"
                $permissions = Get-PnPGroupPermissions -Identity $group.Title
                foreach ($permission in $permissions) {
                    if($permission.Name -ne "Limited Access") {
                        Write-Host "        Permission: $($permission.Name)"
                    }
                }
            }
        }
    }
}