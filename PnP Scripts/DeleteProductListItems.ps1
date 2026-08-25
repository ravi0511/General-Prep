Connect-PnPOnline -Url "https://ecolab.sharepoint.com/sites/Products" -UseWebLogin

$products = Get-PnPListItem -List "Products" -PageSize 500

foreach ($product in $products)
{
    $productListItemId = $product.Id

    try {
        Remove-PnPListItem -List "Products" -Identity $productListItemId -Force
        Write-Host "[$productListItemId] Removed item with list ID $productListItemId successfully" -ForegroundColor Green
    } catch {
        Write-Host "[$productListItemId] Error removing product with list item ID: $productListItemId" -ForegroundColor Red
    }
}