param([Parameter(Mandatory=$true)][string]$FrameworkSource,
      [Parameter(Mandatory=$true)][string]$TomlSource)
$ErrorActionPreference = 'Stop'
$projectDir = Split-Path -Parent $PSScriptRoot
$pins = Get-Content -LiteralPath "$projectDir\docs\FRAMEWORK_PIN.json" -Raw | ConvertFrom-Json
function Export-Pinned([string]$Source, [string]$Commit, [string]$Name, [string]$Destination) {
    $archive = "$projectDir\.deps\$Name.tar"
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
    & git -C $Source archive --format=tar "--output=$archive" $Commit
    if ($LASTEXITCODE -ne 0) { throw "Pinned local commit unavailable: $Name $Commit" }
    & tar -xf $archive -C $Destination
    if ($LASTEXITCODE -ne 0) { throw "Cannot extract $Name" }
}
# Use clean local repository objects, never alter the source checkout.
# Replacing an existing snapshot is deliberately not part of this helper.
if (Test-Path -LiteralPath "$projectDir\.deps\gbarecomp") {
    throw 'Dependency snapshot already exists. Keep it for the current build.'
}
New-Item -ItemType Directory -Force -Path "$projectDir\.deps" | Out-Null
Export-Pinned $FrameworkSource $pins.gbarecomp 'framework' "$projectDir\.deps\gbarecomp"
foreach ($name in @('arm-recomp-core','recomp-net','rbengine')) {
    Export-Pinned "$FrameworkSource\external\$name" $pins.$name $name "$projectDir\.deps\gbarecomp\external\$name"
}
Export-Pinned $TomlSource $pins.tomlplusplus 'tomlplusplus' "$projectDir\.deps\tomlplusplus"
