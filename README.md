# KlonoaEmpireOfDreamsRecomp — v0.1.0-preview

An unofficial Windows x64 native recompilation of **Klonoa: Empire of Dreams
(USA, AKLE)** using [GBARecomp](https://github.com/mstan/gbarecomp) and
[recomp-ui](https://github.com/mstan/recomp-ui). **Experimental Preview:** full
completion and later-game compatibility are unverified. Supply your own legally
obtained cartridge ROM and retail GBA BIOS. No raw game assets are distributed.
This project is not affiliated with Namco/Bandai Namco or Nintendo.

## Actual verified scope

Retail BIOS/Namco boot, title, menus and Vision 1-1 have been verified, including
movement, jumping, grabbing, carrying and throwing enemies. The original
512-byte EEPROM was written by the game and read in a new Windows process.
The owner reports that manual gameplay has no problems. A subsequent ordinary
button trace collected all three Vision 1-1 stars and reached the lower exit
route, but **did not enter the exit door or establish stage completion, Vision
1-2 unlock, or completed-stage persistence**. Later stages, bosses, long sessions
and complete audio accuracy remain unverified. See docs/PROGRESS.md.

This RC adds the player launcher and independent package. It does not repeat
stage exploration or gameplay acceptance. RC results and remaining manual ZIP
acceptance are recorded in docs/RELEASE_CANDIDATE.md.

## How it works

The generator translates discovered GBA ARM/Thumb cartridge routines and the
retail BIOS into C++, then compiles them into a Windows x64 executable. The
current output has 8,436 cartridge functions across 16 shards and 770 BIOS
functions. GBARecomp models the bus, PPU, APU, DMA, timers, interrupts and save
chip; SDL2 provides host video, input and audio. CPU execution combines AOT code
with ARMv4T interpreter fallback for uncovered paths. This is **not FULLY_STATIC**.
Runtime self-heal compilation is disabled: players need no compiler. Original
240 × 160 rendering and game logic are retained; no matching-decompilation
implementation or guest-memory progression shortcuts are integrated.

## Source repository and Windows installation

Public source: https://github.com/Zaxaerith/KlonoaEmpireOfDreamsRecomp.

The local candidate is **KlonoaEmpireOfDreamsRecomp-windows-x64-v0.1.0-preview.zip**.
There is no public download or hosted Release yet. When an owner-approved
release is published, obtain that exact archive and its SHA-256 from the
project's release channel; do not infer a published asset from this README.

1. Extract the ZIP into a writable folder on Windows 10/11 x64. Keep the EXE,
   four DLLs, assets and license files together. Do not run inside the ZIP.
2. Run **KlonoaEmpireOfDreamsRecomp.exe**. No PowerShell, Python, GCC, CMake,
   development checkout or code generation is needed by players.
3. Select your own ROM and BIOS. Exact SHA-1 validation blocks missing, wrong,
   modified or unsupported inputs. Valid paths are remembered for later launches.
4. Review controls, display and volume in the launcher, then press **Play**.

The launcher requires a desktop graphics driver supporting OpenGL. The EXE is
unsigned. Re-select files if remembered paths move. Run the EXE with
`--launcher` to reopen a launcher previously skipped in settings. No game box
art is included.

## Required private inputs

| Input | Identity | Bytes | SHA-1 |
| --- | --- | ---: | --- |
| ROM | Klonoa: Empire of Dreams USA, header KLONOA, AKLE/AF | 4,194,304 | a0a298d9dba1ba15d04a42fc2eb35893d1a9569b |
| BIOS | Original retail GBA BIOS | 16,384 | 300c20df6731a33952ded8c436f7f186d25d3492 |

ROM CRC32 is F74E1036. Other regions, revisions, modifications and replacement
BIOS images are unsupported. Renaming files does not change their identity.
No ROM or BIOS download is supplied.

## Controls, display and sound

recomp-ui provides editable keyboard/gamepad bindings, window scale/fullscreen,
display presentation/filter settings and volume. Controller conventions vary;
the configured mapping is authoritative. Standard SDL2-compatible controllers
are supported. Widescreen/adaptive view is not exposed in this preview.

| GBA button | Default keyboard | Typical gamepad |
| --- | --- | --- |
| D-pad | Arrow keys | D-pad / left stick |
| A, jump | X | Bottom face button |
| B, wind bullet / throw | Z | Right face button |
| Start | Enter | Start |
| Select | Right Shift | Back / Select |
| L / R | C / V | Shoulder buttons |

Manual gameplay acceptance predates launcher integration; the owner should
check the final ZIP's chosen controller and settings before publication.

## EEPROM and player configuration

Normal double-click and `--launcher` launches use the executable directory.
Native EEPROM remains **saves/klonoa_eod_usa.sav beside the EXE**, exactly
512 bytes, compatible with the existing project player save. It is not a Save
State. Wait for the game's save operation to finish and close normally; forced
termination may lose pending changes. Back up the entire saves directory.
When moving to this package, copy your existing player save to that same
relative path before playing. The launcher does not migrate, erase or overwrite
it with test data. Preserve saves and settings when updating.

`rom.cfg`, `bios.cfg`, `config.ini` and `keybinds.ini` beside the EXE remember
private input paths and settings. Do not publish them. The pristine ZIP includes
none of these files, no EEPROM, and no developer game.toml. A public path-free
player.toml fixes the original 512-byte EEPROM size; keep it beside the EXE.
Explicit developer
CLI runs retain working-directory behavior and accept `--save FILE`.

## Build and regenerate from source

Development requires Git, native PowerShell, CMake 3.20+, Ninja, Python 3,
MinGW-w64 x64 GCC and the SDL2 MinGW development SDK. The RC uses GCC 16.1.0,
CMake 4.4.4, Ninja 1.13.2 and SDL2 2.32.8. Put CMake/Ninja/Git on PATH. No WSL,
Docker, agbcc or ARM cross-compiler is required. Player installation needs none
of these tools.

Exact dependency commits are in docs/FRAMEWORK_PIN.json. The bootstrap helpers
export clean pinned Git objects into project-local ignored .deps snapshots;
they do not change their source checkouts or download game inputs. Obtain
GBARecomp and its pinned arm-recomp-core/recomp-net/rbengine submodules,
tomlplusplus and recomp-ui from their upstream repositories. Ensure the recorded
commits exist locally. For a fresh checkout, use the following acquisition steps
in a separate dependency-source directory (the example paths below are placeholders):

```powershell
git clone https://github.com/mstan/gbarecomp.git C:/sources/gbarecomp
git -C C:/sources/gbarecomp checkout e3c834d399b66f5a823c2f0f9d878b62dc05d25a
git -C C:/sources/gbarecomp submodule update --init external/arm-recomp-core external/recomp-net external/rbengine
git -C C:/sources/gbarecomp/external/arm-recomp-core checkout c626f4e53fcdca0c72d2a7d34d41663d87c7e175
git -C C:/sources/gbarecomp/external/recomp-net checkout d3524c6fef49dcfd511d2de7df4ba5a6e7900732
git -C C:/sources/gbarecomp/external/rbengine checkout 2a03e73693acee0fb78076ea058642c931bef12e
git clone https://github.com/marzer/tomlplusplus.git C:/sources/tomlplusplus
git -C C:/sources/tomlplusplus checkout 30172438cee64926dc41fdd9c11fb3ba5b2ba9de
git clone https://github.com/mstan/recomp-ui.git C:/sources/recomp-ui
git -C C:/sources/recomp-ui checkout 6374aae201b930c97425718249f5d39b2275ca13
```

Then run from this project:

```powershell
./tools/bootstrap-deps.ps1 -FrameworkSource C:/sources/gbarecomp -TomlSource C:/sources/tomlplusplus
./tools/bootstrap-ui.ps1 -UiSource C:/sources/recomp-ui
python ./tools/verify-deps.py
./tools/build-host.ps1 -GeneratorOnly -ToolchainRoot C:/sdk/mingw64 -SdlSdk C:/sdk/SDL2/x86_64-w64-mingw32
./tools/regen.ps1 -Rom C:/private/klonoa.gba -Bios C:/private/gba_bios.bin
./tools/build-host.ps1 -Jobs 4 -ToolchainRoot C:/sdk/mingw64 -SdlSdk C:/sdk/SDL2/x86_64-w64-mingw32
./build/host/KlonoaEmpireOfDreamsRecomp.exe
```

ToolchainRoot contains bin/gcc.exe and bin/g++.exe. SdlSdk contains
include/SDL2, lib/libSDL2.dll.a and bin/SDL2.dll. Optional ignored .local.ps1
can set DefaultBios, Toolchain, SdlRoot, CMake and Ninja for local convenience.
Generated cartridge/BIOS C++ is retained in generated/ and excluded from Git
and player packages. The BIOS helper header is supplied by src/codegen_tail_macros.h.
No full cold regeneration was repeated for this RC; the existing complete
translation was used with the pinned sources.

```powershell
./tools/make-release.ps1 -SkipBuild -Toolchain C:/sdk/mingw64 -SdlRoot C:/sdk/SDL2/x86_64-w64-mingw32
python ./tools/audit-release.py ./release-stage/KlonoaEmpireOfDreamsRecomp-windows-x64-v0.1.0-preview.zip
```

Packaging checks dependency archive identities, requires Release configuration,
strips debug information from staged binaries, copies an explicit allowlist,
creates per-file hashes in manifest.json and a ZIP .sha256 companion. Existing
candidate outputs are preserved rather than overwritten. manifest.json excludes
its own hash. No extensive replay is part of packaging.

## Credits and licenses

Thanks to Matthew Stanley for GBARecomp, recomp-ui and arm-recomp-core; SDL,
Dear ImGui, toml++, GCC/MinGW, the font authors and upstream contributors.
KirbyNightmareInDreamLandRecomp supplied the established generic launcher and
package workflow. MetroidFusionRecomp and GoldenSunTheBrokenSealRecomp supplied
integration/documentation references; no game-specific code or assets from
those games were copied.

See LICENSE.md, THIRD_PARTY_NOTICES.md, docs/licenses/ and licenses/ in the ZIP. GBARecomp and
inherited Kirby integration use PolyForm Noncommercial 1.0.0; recomp-ui,
arm-recomp-core and ImGui use MIT; SDL2 uses zlib. mGBA-derived BIOS HLE files
are MPL-2.0 and their exact source is included. Fonts and GCC/MinGW libraries
retain separate terms. No blanket MIT/GPL license covers the combined EXE.
A source license for newly authored Klonoa integration remains an owner decision.

Original game, BIOS and trademarks belong to their respective owners. Excluding
raw private inputs does not establish rights to publish compiled game/BIOS
translations. Public distribution requires separate rights assessment and
applicable corresponding-source arrangements. docs/PUBLICATION.md lists those
open binary-publication prerequisites. Public source visibility grants no new rights
in the game, BIOS or separately licensed components.

## Known limitations

- Complete Vision 1-1 clear, next-stage unlock and completed-progress cold read
  remain unverified; ordinary EEPROM read/write has passed.
- Later content, bosses, multiplayer, long sessions and full sound accuracy are
  unverified. Interpreter fallback is expected and performance may vary.
- No widescreen, signing, updater or commercial distribution permission is promised.
- Final ZIP manual launcher/controller acceptance awaits the owner.
- This repository publishes source only; no hosted binary Release is provided.
