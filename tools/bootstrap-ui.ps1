param([Parameter(Mandatory=$true)][string]$UiSource)
$ErrorActionPreference = 'Stop'
$projectDir = Split-Path -Parent $PSScriptRoot
$pin = (Get-Content "$projectDir/docs/FRAMEWORK_PIN.json" -Raw | ConvertFrom-Json).'recomp-ui'
$destination = "$projectDir/.deps/recomp-ui"
if (Test-Path -LiteralPath $destination) { throw 'UI snapshot exists; preserve it.' }
New-Item -ItemType Directory -Force -Path $destination | Out-Null
& git -C $UiSource archive --format=tar "--output=$projectDir/.deps/recomp-ui.tar" $pin
if ($LASTEXITCODE -ne 0) { throw 'Pinned UI commit unavailable in source checkout.' }
& tar -xf "$projectDir/.deps/recomp-ui.tar" -C $destination
if ($LASTEXITCODE -ne 0) { throw 'UI snapshot extraction failed.' }
