
Connect-PnPOnline -Url "https://ecolab.sharepoint.com/sites/CORE-InternalKC"-Interactive -ClientID 0b2d1e5e-3f9b-4cb3-89f7-4a2a2db7d139


Add-PnPApp -Path "C:\Users\arra\Downloads\ecolab-core-plus.sppkg" -Scope Site -Publish -Overwrite


#########

param(
    [Parameter(Mandatory = $true)]
    [string]$SiteUrl,

    [string]$ProjectPath = (Join-Path $PSScriptRoot "..\Ecolab-CorePlus"),

    [string]$PackagePath,

    [switch]$SkipBuild,

    [switch]$SkipAppCatalogCreation,

    [bool]$SkipFeatureDeployment = $true
)

$ErrorActionPreference = "Stop"

function Resolve-FullPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return $Path
    }

    return (Join-Path (Get-Location) $Path)
}

$resolvedProjectPath = Resolve-FullPath -Path $ProjectPath

if (!(Test-Path $resolvedProjectPath)) {
    throw "Project path not found: $resolvedProjectPath"
}

if (!$PackagePath) {
    $PackagePath = Join-Path $resolvedProjectPath "sharepoint\solution\*.sppkg"
}

if (!$SkipBuild) {
    Write-Host "Packaging SPFx solution from $resolvedProjectPath" -ForegroundColor Cyan
    Push-Location $resolvedProjectPath
    try {
        npx gulp bundle --ship
        npx gulp package-solution --ship
    }
    finally {
        Pop-Location
    }
}

$resolvedPackagePath = Resolve-FullPath -Path $PackagePath
$packageFiles = @(Get-ChildItem -Path $resolvedPackagePath -File)

if ($packageFiles.Count -eq 0) {
    throw "No .sppkg file found at: $resolvedPackagePath"
}

if ($packageFiles.Count -gt 1) {
    throw "Multiple .sppkg files found at: $resolvedPackagePath. Pass -PackagePath with the exact package file."
}

$packageFile = $packageFiles[0]

Write-Host "Connecting to $SiteUrl" -ForegroundColor Cyan
Connect-PnPOnline -Url $SiteUrl -Interactive

if (!$SkipAppCatalogCreation) {
    try {
        Write-Host "Ensuring site collection app catalog exists" -ForegroundColor Cyan
        Add-PnPSiteCollectionAppCatalog -Site $SiteUrl
        Write-Host "Site collection app catalog is available" -ForegroundColor Green
    }
    catch {
        $message = $_.Exception.Message
        if ($message -match "already|exist") {
            Write-Host "Site collection app catalog already exists" -ForegroundColor Yellow
        }
        else {
            throw "Failed to create site collection app catalog for $SiteUrl. $message"
        }
    }
}

Write-Host "Uploading and publishing $($packageFile.FullName) to the site collection app catalog" -ForegroundColor Cyan
Add-PnPApp -Path $packageFile.FullName -Scope Site -Publish -Overwrite -SkipFeatureDeployment:$SkipFeatureDeployment

Write-Host "SPFx solution deployed to the site collection app catalog for $SiteUrl" -ForegroundColor Green