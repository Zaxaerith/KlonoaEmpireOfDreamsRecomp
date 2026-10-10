param([string]$Rom, [string]$Bios)
. "$PSScriptRoot\common.ps1"
if (-not $Rom) { $Rom = $DefaultRom }
if (-not $Bios) { $Bios = $DefaultBios }
Assert-Rom $Rom
Assert-Bios $Bios
Push-Location $ProjectRoot
try { & "$ProjectRoot\build\host\KlonoaEmpireOfDreamsRecomp.exe" --rom $Rom --bios $Bios --config "$ProjectRoot\game.toml" --save "$ProjectRoot\saves\klonoa_eod_usa.sav" --window }
finally { Pop-Location }
