Connect-PnPOnline -Url "https://ecolab.sharepoint.com/sites/CORE-FoodandBeverage/"-Interactive -ClientID 0b2d1e5e-3f9b-4cb3-89f7-4a2a2db7d139


Add-PnPNavigationNode -Title "Featured Content" -Url "https://ecolab.sharepoint.com/sites/CORE-FoodandBeverage/SitePages/Food%20and%20Beverage%20Featured%20Content.aspx" -Location QuickLaunch
$ParentLink = Add-PnPNavigationNode -Title "Post a Question" -Url "http://linkless.header/" -Location QuickLaunch
Add-PnPNavigationNode -Title "This Community" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjM3NDk1MjE0MDgifQ" -Location QuickLaunch -Parent $ParentLink.Id
$ParentLink2 = Add-PnPNavigationNode -Title "CORE+ Communities" -Url "http://linkless.header/" -Location QuickLaunch -Parent $ParentLink.Id


Add-PnPNavigationNode -Title "Analytical & Microbiology" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzAyMzkyMTU2MTYifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Chemicals" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjk3NDQ5OTIyNTYifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Core Water" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjM3NTEyOTkwNzIifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "CORE+ Knowledge Communities Hub" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjI3MTQxODM2ODAifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Digital" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjQwMzcwOTMzNzYifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Downstream" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzAzNTk5MjQ3MzYifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Food & Beverage" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjM3NDk1MjE0MDgifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "High Tech" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDUyNDAzMjAifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Institutional" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDUwNzY0ODAifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Learning and Value Delivery" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzAyMzkxMzM2OTYifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Manufacturing" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyNTU0MjQ2MjY2ODgifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Paper" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMTA0NzYxOTc1ODgxNzI4In0" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Pest" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIxMjg0NDExMzkyMDAifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Power" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDUzMTQwNDgifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Primary Metals" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDU0MzY5MjgifQ" -Parent $ParentLink2.Id -Location QuickLaunch
Add-PnPNavigationNode -Title "Water Safety" -Url "https://engage.cloud.microsoft/main/org/nalco.microsoftonline.com/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMzc4MDQ4ODgwNjQifQ" -Parent $ParentLink2.Id -Location QuickLaunch


Add-PnPNavigationNode -Title "Knowledge Center Support" -Url "https://ecolab.sharepoint.com/sites/CORE-FoodandBeverage/SitePages/Connect%20to%20Support.aspx" -Location QuickLaunch