# Prompt user for SharePoint site URL
$siteUrl = Read-Host -Prompt "Enter the SharePoint Site URL (e.g. https://ecolab.sharepoint.com/sites/CorePlus)"

# Prompt user for the page name
$pageName = Read-Host -Prompt "Enter the page name (e.g. Home.aspx)"
#$siteUrl = "https://ecolab.sharepoint.com/sites/COREplus_Dev_AdminKC"
#$pageName = "Home.aspx"
# Connect to SharePoint Online
Connect-PnPOnline -Url $siteUrl -Interactive -ClientId 0b2d1e5e-3f9b-4cb3-89f7-4a2a2db7d139

# Prepare Quick Links web part properties JSON
$quickLinksProperties = @{
    "layoutId" = "FilmStrip"
    "shouldShowThumbnail" = $true
    "isTitleEnabled" = $false
    "items" = @(
        @{
          "title" = "CORE+: Analytical and Microbiology"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzAyMzkyMTU2MTYifQ"
              "itemType" = 2
          }
          "thumbnailType" = 3
          "id"=1
          "rawPreviewImageUrl" ="https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Analytical%20and%20Microbiology.png"
          "description" = ""
          "altText" = "CORE+: Analytical and Microbiology"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Core Water"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjM3NTEyOTkwNzIifQ"
              "itemType" = 2
          }
          "thumbnailType" = 3
          "id"=2
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Core%20Water.jpg"
          "description" = ""
          "altText" = "CORE+: Core Water"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Digital"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjQwMzcwOTMzNzYifQ"
              "itemType" = 2
          }
          "id"=3
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Digital.png"
          "description" = ""
          "altText" = "CORE+: Digital"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Learning and Value Delivery"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzAyMzkxMzM2OTYifQ"
              "itemType" = 2
          }
          "id"=4
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Learning%20and%20Value%20Delivery.png"
          "description" = ""
          "altText" = "CORE+: Learning and Value Delivery"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Chemicals"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjk3NDQ5OTIyNTYifQ"
              "itemType" = 2
          }
          "id"=5
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Chemicals.jpg"
          "description" = ""
          "altText" = "CORE+: Chemicals"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+ Hub"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjI3MTQxODM2ODAifQ"
              "itemType" = 2
          }
          "id"=6
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/CORE+%20Hub.jpg"
          "description" = ""
          "altText" = "CORE+ Hub"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Downstream"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzAzNTk5MjQ3MzYifQ"
              "itemType" = 2
          }
          "id"=7
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Downstream.png"
          "description" = ""
          "altText" = "CORE+: Downstream"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Food & Beverage"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjM3NDk1MjE0MDgifQ"
              "itemType" = 2
          }
          "id"=8
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Food%20and%20Beverage.png"
          "description" = ""
          "altText" = "CORE+: Food & Beverage"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: High Tech"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDUyNDAzMjAifQ"
              "itemType" = 2
          }
          "id"=9
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/High%20Tech.jpg"
          "description" = ""
          "altText" = "CORE+: High Tech"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Institutional"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDUwNzY0ODAifQ"
              "itemType" = 2
          }
          "id"=10
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Institutional.jpg"
          "description" = ""
          "altText" = "CORE+: Institutional"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Power"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDUzMTQwNDgifQ"
              "itemType" = 2
          }
          "id"=11
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Power.jpg"
          "description" = ""
          "altText" = "CORE+: Power"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Primary Metals"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDU0MzY5MjgifQ"
              "itemType" = 2
          }
          "id"=12
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Primary%20Metals.jpg"
          "description" = ""
          "altText" = "CORE+: Primary Metals"
          "shouldOpenInNewTab" = $true
        },
        @{
          "title" = "CORE+: Water Safety"
          "sourceItem" = @{
              "url" = "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDQ4ODgwNjQifQ"
              "itemType" = 2
          }
          "id"=13
          "thumbnailType" = 3
          "rawPreviewImageUrl" = "https://ecolab.sharepoint.com/sites/CorePlus/SiteAssets/SearchIcons/Community%20Webpart%20Pictures/Water%20Safety.png"
          "description" = ""
          "altText" = "CORE+: Water Safety"
          "shouldOpenInNewTab" = $true
        }
    )
}

# Add Quick Links web part to the specified page
#Add-PnPPageTextPart -Page $pageName -Text "<h2 style='font-size:28px; text-align:center;'>News Posts</h2>" -Section 2 -Order 0 -Column 1


Add-PnPPageTextPart -Page $pageName -Text "<h2 style='font-size:28px; text-align:center;'>Explore CORE+ Knowledge Communities</h2>" -Section 1 -Order 4 -Column 1
Add-PnPPageTextPart -Page $pageName -Text "<p style='font-size:18px; text-align:left;'>Engage with Knowledge Communities to ask questions, share insights, solve challenges, and discover solutions—from digital tools to chemical and equipment offerings. Choose a Community below to join the conversation.</p>" -Section 1 -Order 5 -Column 1
Add-PnPPageWebPart -Page $pageName -DefaultWebPartType QuickLinks -Section 1 -Column 1 -Order 6 -WebPartProperties $quickLinksProperties



#Add-PnPPageTextPart -Page $pageName -Text "<p>&nbsp;</p><p class='noSpacingAbove spacingBelow' style='margin-left:40px;' data-text-type='withSpacing'><strong>Need help fast?</strong> Start a discussion, toggle to Question and share with global experts in your community.</p><p class='noSpacingAbove spacingBelow' style='margin-left:40px;' data-text-type='withSpacing'><strong>Browse</strong> the most recent threads to learn what's top of mind with your peers.</p><p class='noSpacingAbove spacingBelow' style='margin-left:40px;' data-text-type='withSpacing'><strong>Join the conversation!</strong> Collaborate, share solutions and react to ideas that matter.</p><p>&nbsp;</p>"

#Add-PnPPageTextPart -Page $pageName -Text "<h2 style='font-size:28px; text-align:center; margin:0;'>Chemicals Knowledge Community Is Live!</h2>"
#Add-PnPPageWebPart -Page $pageName -DefaultWebPartType YammerFullFeed -Section 1 -Column 1 -Order 6 -WebPartProperties '{"id":"eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjk3NDQ5OTIyNTYifQ","showHighlights":true,"threadCount":6}'
#$webpart = Get-PnPPageComponent -Page $pageName | Where-Object { $_.Title -eq "PnP - Search Results" }
#Remove-PnPPageComponent -Page $pageName -InstanceId $webpart.InstanceId -Force
#$webpart1 = Get-PnPPageComponent -Page $pageName | Where-Object { $_.Title -eq "PnP - Search Filters" }
#Remove-PnPPageComponent -Page $pageName -InstanceId $webpart1.InstanceId -Force
#$webpart3 = Get-PnPPageComponent -Page $pageName | Where-Object { $_.Title -eq "Highlighted content" }
#Move-PnPPageComponent -Page $pageName -InstanceId $webpart3[0].InstanceId -Section 2 -Column 1 -Position 1

#$webpart2 = Get-PnPPageComponent -Page $pageName | Where-Object { $_.Title -eq "PnP - Search Box" }
#Move-PnPPageComponent -Page $pageName -InstanceId $webpart2[0].InstanceId -Section 2 -Position 2


