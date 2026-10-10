# Third-party notices — v0.1.0-preview

Exact source revisions are in docs/FRAMEWORK_PIN.json. Full component license
texts accompany the ZIP under licenses/.

| Component | Pin / version | Terms |
| --- | --- | --- |
| GBARecomp | e3c834d399b66f5a823c2f0f9d878b62dc05d25a | PolyForm Noncommercial 1.0.0, Copyright 2026 Matthew Stanley; file exceptions below |
| recomp-ui | 6374aae201b930c97425718249f5d39b2275ca13 | MIT, Copyright 2026 Matthew Stanley |
| arm-recomp-core | c626f4e53fcdca0c72d2a7d34d41663d87c7e175 | MIT |
| recomp-net / rbengine | Pinned framework dependencies | MIT; not a multiplayer compatibility claim |
| Dear ImGui | UI-vendored source | MIT |
| SDL2 | 2.32.8 | zlib |
| toml++ | 30172438cee64926dc41fdd9c11fb3ba5b2ba9de | MIT; build dependency |
| GCC / MinGW runtime | GCC 16.1.0, x64 SEH | GPL/LGPL and GCC Runtime Library Exception; MinGW notices |
| Lato / Noto Sans Symbols 2 | UI fonts | SIL OFL 1.1 |
| OpenMoji black font | UI font | CC BY-SA 4.0, OpenMoji Project |
| flags.png | UI rendering from Noto Color Emoji | SIL OFL 1.1, Noto Project Authors |
| Kirby integration | Local launcher/build/package reference | PolyForm Noncommercial 1.0.0, Copyright 2026 Zaxaerith |
| Metroid Fusion integration patterns | Earlier generic reference | MIT, Copyright 2026 MetroidFusionRecomp contributors |

GBARecomp THIRD_PARTY_ATTRIBUTION.md is retained. JRickey/gba-recomp-derived
MP2K detection/offsets, color simulation, RTC and audio portions retain
MIT OR Apache-2.0 terms; the MIT option and Copyright 2026 JRickey are included.

Framework bios_hle.cpp and bios_hle.h derive from mGBA by Jeffrey Pfau and
contributors under MPL-2.0. Their exact unmodified pinned source and MPL text
are bundled under licenses/mpl-source/. Retail BIOS LLE remains the default;
libmgba is not linked. Generic framework source is available at
https://github.com/mstan/gbarecomp/tree/e3c834d399b66f5a823c2f0f9d878b62dc05d25a.
UI source: https://github.com/mstan/recomp-ui/tree/6374aae201b930c97425718249f5d39b2275ca13.

GCC GPL/LGPL, runtime exception and MinGW notices accompany the DLLs.
Applicable corresponding-source availability for the exact separately
distributed toolchain libraries remains a public release prerequisite.
The exception is not a game-content license.

No Kirby, Metroid or Golden Sun game code/assets were reused. No matching
decompilation implementation was copied into this project. Original Klonoa
and GBA BIOS rights remain with their respective owners. See LICENSE.md and
docs/PUBLICATION.md for unresolved publication conditions.
