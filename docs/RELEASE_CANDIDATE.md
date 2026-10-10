# Windows x64 v0.1.0-preview local candidate — 2026-10-10

Candidate prepared for owner ZIP testing. No Push, Tag or GitHub Release.
Baseline commits: bf475e6 (first playable), cc45c46 (three-star route preserved).
Full generated cartridge/BIOS C++ and earlier evidence remain local and intact.
Only superseded packages produced during this RC were removed; original saves,
generated output, logs and dependency snapshots were preserved.

## Deliverables

- ZIP: release-stage/KlonoaEmpireOfDreamsRecomp-windows-x64-v0.1.0-preview.zip
- ZIP size: 11,704,045 bytes.
- ZIP SHA-256: `0c54f8c0b839e083b23e38f9ae261ee69132744808209f84a5a57e13cfc71331`.
- Player EXE: release-stage/KlonoaEmpireOfDreamsRecomp-windows-x64-v0.1.0-preview/KlonoaEmpireOfDreamsRecomp.exe
- Build EXE: build/host/KlonoaEmpireOfDreamsRecomp.exe, Release x64.
- Inventory: docs/RELEASE_MANIFEST.json and ZIP manifest.json; 45 files total.
- Exact checks: docs/RELEASE_TEST_RESULT.json.

## Integration and bounded acceptance

| Item | Result |
| --- | --- |
| Release build | PASS: pinned GBARecomp/recomp-ui, existing complete AOT translations, SDL2/MinGW; no shared source changed |
| Inputs | PASS: actual linked launcher model rejects wrong/missing ROM/BIOS and recovers with valid inputs; direct CLI rejects same-size invalid inputs before replacing valid caches |
| Launcher | PASS: real first-run and cached dashboard/settings/controller rendering; correct Klonoa name/hash; settings and path persistence contract |
| Play to game window | One scripted attempt created the actual game window but closed before guest execution (0 frames). Further UI driver activation was unreliable. Final interactive Play acceptance is PENDING owner testing; no full handoff PASS claimed |
| Standalone boot | PASS: EXE extracted from final ZIP, outside working directory, developer tools removed from PATH; one 900-frame zero-input title smoke |
| EEPROM compatibility | PASS: public player.toml fixes 512-byte EEPROM; same relative player path; original 512-byte copy loaded and retained identical SHA-256 after normal process exit; all six original saves unchanged |
| Dependencies | PASS: all five PE binaries AMD64; imports use staged SDL2/MinGW and standard Windows/UCRT libraries |
| Package boundary | PASS: 45-file allowlist, per-file hashes, raw ROM/BIOS/save/generated/log/cache/private-path exclusion audit |
| Documentation/licenses | Complete English README and dependency/inherited integration notices included; unresolved publication rights disclosed |

UI/model/invalid-input checks were retained after the player TOML and help-only
corrections because their implementations did not change; successful tests were
not repeated. The final ZIP itself ran the valid-input title/EEPROM smoke.
Scripted GUI attempts did not provide game button input. No stage exploration,
completion testing, full replay, instruction tracing or broad coverage scan ran.

The fixed framework configures save capacity through TOML and otherwise defaults
EEPROM to 8 KiB. The standalone package therefore includes a public path-free
player.toml with type=eeprom, size=512. Explicit developer game.toml remains
supported. Save device implementation was not modified. Host --help now exits
before launcher/runtime work so help cannot replace input caches.

Native save remains saves/klonoa_eod_usa.sav beside the player EXE. Back up/copy
the existing player save to that location when installing the ZIP. No test saves
or preset personal paths are packaged. ROM/BIOS selection uses recomp-ui's
native file picker and exact identity gates. No standalone UI framework was built.

## Limits and publication status

Existing playable evidence and owner manual gameplay acceptance remain valid,
but complete-stage completion, Vision 1-2 unlock and completed-progress cold read
remain unverified. Interpreter fallback stays enabled. The final ZIP's manual
Play/controller/settings acceptance is pending. Public publication is **not
cleared**: compiled game/BIOS derivative rights, newly authored source license
scope, component obligations and owner authorization remain open in
docs/PUBLICATION.md. Packaging audit does not establish those rights.

Stop at this candidate; do not resume AI gameplay or publish without owner input.
