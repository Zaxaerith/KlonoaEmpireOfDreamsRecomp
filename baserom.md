# Required original inputs

| Input | Required identity |
| --- | --- |
| USA ROM | 4,194,304 bytes; title KLONOA; code AKLE; maker AF |
| ROM SHA-1 | a0a298d9dba1ba15d04a42fc2eb35893d1a9569b |
| ROM CRC32 | F74E1036 |
| Retail GBA BIOS | 16,384 bytes |
| BIOS SHA-1 | 300c20df6731a33952ded8c436f7f186d25d3492 |

Both originals were found locally and verified. The ROM was not duplicated;
the BIOS is referenced through ignored `.local.ps1`. No ROM/BIOS download.
The ROM contains EEPROM_V121. `game.toml` configures 512-byte EEPROM; the
selected runtime uses six address bits and 64 eight-byte blocks for this size.
Real game-created data and cold save-slot loading were observed. Completion
and unlocking of later Visions have not been validated.
