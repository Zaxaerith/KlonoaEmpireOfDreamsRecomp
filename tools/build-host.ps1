param([int]$Jobs = 4, [switch]$GeneratorOnly, [string]$ToolchainRoot, [string]$SdlSdk)
. "$PSScriptRoot\common.ps1"
if ($ToolchainRoot) { $Toolchain = $ToolchainRoot }
if ($SdlSdk) { $SdlRoot = $SdlSdk }
if (-not $Toolchain -or -not $SdlRoot) { throw 'Configure Toolchain/SdlRoot in private .local.ps1.' }
New-Item -ItemType Directory -Force -Path "$ProjectRoot\logs" | Out-Null
$env:PATH = "$Toolchain/bin;$env:PATH"
$configure = @('-S',$ProjectRoot,'-B',"$ProjectRoot\build\host",'-G','Ninja','-DCMAKE_BUILD_TYPE=Release',
    "-DCMAKE_MAKE_PROGRAM=$Ninja","-DCMAKE_C_COMPILER=$Toolchain/bin/gcc.exe","-DCMAKE_CXX_COMPILER=$Toolchain/bin/g++.exe",
    "-DSDL2_INCLUDE_DIR=$SdlRoot/include/SDL2","-DSDL2_LIBRARY=$SdlRoot/lib/libSDL2.dll.a","-DSDL2_DLL=$SdlRoot/bin/SDL2.dll",
    "-DGBARECOMP_MINGW_RUNTIME_BIN=$Toolchain/bin")
Invoke-Logged $CMake $configure "$ProjectRoot\logs\host-configure.log"
$target = 'KlonoaEmpireOfDreamsRecomp'
if ($GeneratorOnly) { $target = 'gba_recompile' }
Invoke-Logged $CMake @('--build',"$ProjectRoot\build\host",'--target',$target,'--parallel',"$Jobs") "$ProjectRoot\logs\host-build.log"
Get-Content -LiteralPath "$ProjectRoot\logs\host-build.log" -Tail 4
