param([string]$Rom, [string]$Bios, [string]$Generator)
. "$PSScriptRoot\common.ps1"
if (-not $Rom) { $Rom = $DefaultRom }
if (-not $Bios) { $Bios = $DefaultBios }
if (-not $Generator) { $Generator = "$ProjectRoot\build\host\framework\gba_recompile.exe" }
Assert-Rom $Rom
Assert-Bios $Bios
New-Item -ItemType Directory -Force -Path "$ProjectRoot\logs" | Out-Null
Invoke-Logged $Generator @('--rom',$Rom,'--config',"$ProjectRoot\game.toml",'--out',"$ProjectRoot\generated\cart",'--max-functions','65536') "$ProjectRoot\logs\regen-cart.log"
Invoke-Logged $Generator @('--bios',$Bios,'--config',"$ProjectRoot\.deps\gbarecomp\bios\gba_bios.toml",'--out',"$ProjectRoot\generated\bios") "$ProjectRoot\logs\regen-bios.log"
$support = "$ProjectRoot\src\codegen_tail_macros.h"
Copy-Item -LiteralPath $support -Destination "$ProjectRoot\generated\bios\codegen_tail_macros.h" -Force
Get-Content -LiteralPath "$ProjectRoot\logs\regen-cart.log" -Tail 8
Get-Content -LiteralPath "$ProjectRoot\logs\regen-bios.log" -Tail 4
