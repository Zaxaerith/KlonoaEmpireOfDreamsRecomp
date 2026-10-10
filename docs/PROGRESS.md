# Windows v0.1.0-preview RC — 2026-10-10 (Asia/Hong_Kong)

已制作本地独立 Windows x64 ZIP，集成固定版本 recomp-ui，包含完整英文 README、
第三方许可证、文件清单和 SHA-256。详见 [RELEASE_CANDIDATE.md](RELEASE_CANDIDATE.md)。
Release 编译、启动器显示/输入校验/配置持久化、包排除审计和一次 900 帧零输入
标题 Smoke 已通过；512 字节存档副本正常读入且退出后哈希不变。
Play 自动检查曾创建游戏窗口但为 0 游戏帧，后续驱动不可靠，因此最终 ZIP 的
人工 Play 交接验收仍为 PENDING，不伪称 PASS。未开展新的 AI 关卡试玩或通关测试。
原生成 C++、六份原存档和已有证据均保留。没有 Push、Tag 或 Release，
公开发布条件尚未确认，等待用户亲自运行 ZIP 并下达下一步指令。

---

# 第二轮阶段记录 — 2026-10-10 (Asia/Hong_Kong)

用户要求停止追加试玩，并报告人工试玩没有问题。当前 EXE 已通过正常 TCP
`quit` 退出；以下验收以实际观察为准，不把三颗星星等同于关卡完成。

| 项目 | 状态与证据 |
| --- | --- |
| 人工试玩 | PASS：用户明确报告人工试玩没有问题 |
| Vision 1-1 自然通关 | PENDING：三颗星星已全部取得；停在第三房间下层出口通路，尚未进入出口门 |
| 正常场景切换（通关后） | PENDING：尚未观察通关结果、返回世界地图或下一场景；第一至第二、第二至第三房间的自然切换已通过 |
| 解锁下一关 | PENDING：未观察 Vision 1-2 解锁 |
| 关卡完成后 EEPROM 保存 | PENDING：没有通关，不能把本次存档哈希变化认作已完成进度保存 |
| 全新进程恢复已完成进度 | PENDING：首轮普通存档冷读已通过，本轮未执行通关进度冷读 |
| 当前唯一技术 blocker | 无已确认的运行或保存技术故障；剩余验收为出口进入、自然通关保存和新进程读回。用户已要求停止试玩 |
| 游戏代码 / 编译 | 未修改游戏代码、配置或 AOT 输出；未重新编译，维持 AOT + Interpreter |
| 成果保护 | 首轮基线本地提交 bf475e6；私人 .local.ps1、ROM/BIOS、generated/、日志和存档保持忽略；六份原存档哈希全部未变 |

## 本轮实际路线与证据

`tools/vision-1-1-round2-input.csv` 记录成功实验 `round2-attempt03` 从启动到
7495 帧的原始按键变化，初始存档为 `saves/tcp-acceptance.sav` 的独立副本。
不使用 Save State、Guest RAM/PC 注入或直接修改 EEPROM；所有运行记录和截图
保存在忽略目录 `logs/`，失败实验也完整保留。

- 前两房间通过抓取敌人及二段跳取得第一颗星星；自然场景切换：
  `logs/round2-attempt01/room-arrival-f4483.png`、`room3-arrival-f5172.png`。
- 第二颗星星：`logs/round2-attempt02/star2-hud-f5590.png`；同一路线在
  `logs/round2-attempt03/two-stars-held-f5919.png` 再次确认。
- 第三房间桥旁二段跳登桥，向左抓取飞行敌人，然后只用一次普通跳跃
  分别跨过两段尖刺，保留敌人用于末端高台二段跳：
  `logs/round2-attempt03/bridge-flyer-for-star3-f6302.png`、
  `carried-star3-bridge-f6546.png`、`star3-doublejump-pickup-f6598.png`。
- 三星 HUD：`logs/round2-attempt03/all-stars-collected-f6733.png`。
- 返回时从桥沿起跳，完整落到下一块桥面；在第一座桥左侧下行，随后向右
  到出口下层通路。停止画面：`logs/round2-attempt03/below-spike-bridges-f7495.png`。
- 首轮所谓“出口标志”实际是 INFO 教学牌：原游戏说明抓敌后二段跳，
  `logs/round2-attempt01/double-jump-help-f3673.png`。末端取星凹槽也不是出口。
- `round2-attempt02` 在尖刺处死亡、回程坠落后进入 VISION OVER；Continue
  后敌人时序与旧回放不同，因此停止套用旧路线。最终使用新的独立存档
  `attempt03.sav` 恢复已验证检查点，再执行上述修正路线。

出口路线曾只读参考 [Vision 1-1 玩家攻略](https://gamefaqs.gamespot.com/gba/472541-klonoa-empire-of-dreams/faqs/13958)，
提示从上层平台左侧下行、向右找门并按 Up。该线索不作为通关证据；
未复制反编译实现。

## 保存与运行记录

最终实验 PID 21356，原始 Windows EXE 进程已正常退出。独立存档
`saves/round2/attempt03.sav` 为 512 字节，退出后 SHA-256：
`3C05FC0264A7C50A0241082590EF251D0F4DBFBE5003F150C7ACF2C12D862700`。
这是未通关实验存档，不是已完成进度验收。

原始 `tcp-acceptance.sav` 仍为
`91EACD9523965873F70931BAC7EF59D60D5C47B2C5D9200EB96F649C6FF0712B`。
EXE 未改动，SHA-256：
`DE732BABFB4FE0CC122C2E2E7872A500B8101A63D71731FBC6EB42E72647DEE8`。
最终运行统计：26 个 dispatch misses、72,691,857 条 interpreted instructions，
`healed_native=0`、`failed=0`，未发生失败的自修复。
未开展全 ROM 扫描、架构重构、启动器、发行包、Push 或 Release。

---

# 首轮历史记录 — 2026-10-10 (Asia/Hong_Kong)

以下保留首轮当时的状态，最新状态以上方第二轮记录为准。

| Item | Observed result |
| --- | --- |
| ROM | PASS: 4,194,304 B, KLONOA / AKLE / AF, SHA-1 a0a298d9dba1ba15d04a42fc2eb35893d1a9569b, CRC32 F74E1036 |
| BIOS | PASS: 16,384 B, SHA-1 300c20df6731a33952ded8c436f7f186d25d3492; real LLE intro and recompiled retail BIOS |
| Toolchain | CMake 4.4.4, Ninja 1.13.2, MinGW-w64 GCC 16.1.0 (x86_64 win32 SEH), existing SDL2 2.32.8 |
| Framework | e3c834d399b66f5a823c2f0f9d878b62dc05d25a; own generator built from the same archived snapshot as runtime; full dependency pins in FRAMEWORK_PIN.json |
| Generation | PASS: 8,436 cart functions (44 ARM / 8,392 Thumb), 16 shards, 79,327,929 B cart output; 770 BIOS functions, 4,023,790 B BIOS output |
| Native EXE | PASS: build/host/KlonoaEmpireOfDreamsRecomp.exe, PE x86-64, 19,345,837 B; SDL2 and three MinGW DLLs staged alongside |
| P0 Boot | PASS: actual Namco logo at 360 guest frames; BIOS/ROM identities logged in logs/boot.log; no unmapped/IO-unhandled accesses in this smoke |
| P1 Title / Menu | PASS: title in normal SDL window (900 presentations), Start -> New Game -> file selection / confirmation -> World Map |
| P2 First stage | PASS: original Vision 1-1 terrain, directional motion and visible A-button jump |
| P3 Core mechanic | PASS: B wind bullet captured enemy, held it overhead, then B threw it forward; visible screenshot evidence below |
| EEPROM | ROM marker EEPROM_V121, configured 512 B / 6 address bits. Real game writes produced 368 non-FF bytes. After normal process exit, a new process loaded 512/512 B and showed the actual Vision 1-1 slot with two lives |
| P4 Progress | PENDING: first stage not cleared, no later Vision unlock or natural room transition verified. Save-slot roundtrip does not establish completed-stage progress saving |
| P5 Human use | PENDING: human keyboard/controller feel, audio listening and extended play |
| Interpreter | Enabled Stage-1 fallback; runtime compilation disabled. 5,975-frame TCP session: 62 distinct dispatch misses, 75,764,585 interpreted instructions, failed=0; no FULLY_STATIC claim |
| Input checks | PASS after host fix: same-size wrong ROM and same-size wrong BIOS both reject with SHA-1 mismatch and exit 1 |
| Git | New local repository, new files untracked, no commit/push/tag/release. Private inputs/output verified ignored. Original prompt and ROM preserved |
| Current blocker | No build/startup/core-mechanic blocker. Remaining acceptance is natural traversal, completed-stage save/readback and human play |

## Evidence

All images below are real PPU output. Testing used ordinary GBA buttons only:
no PC/guest-memory writes, save states, fabricated progression or imported decomp
game code. `logs/checkpoints/commands.jsonl` records every TCP request without
framebuffer payloads. `tools/vision-1-1-input.csv` preserves the observed button
changes from an initially erased save. Each advance was bounded, typically
120 frames or fewer; actual frame counters were recorded, including occasional
overshoot in a runtime frame-step call. This input trace is evidence, not a
claim of exact replay synchronization across runtimes.

- Boot: `logs/boot.png`; normal SDL title: `logs/title-window.png`.
- Menu/save flow: `logs/checkpoints/menu-f1100.png`, `save-select-f1500.png`, `confirm-f1800.png`.
- Stage entry: `logs/checkpoints/level-f4771.png`.
- Move: `logs/checkpoints/level-move-f4796.png`; jump: `level-jump-f4806.png`.
- Grab: `logs/checkpoints/grab-f4950.png`; carry: `carry-f4965.png`; throw: `throw-f4976.png`.
- Cold save slot: `logs/eeprom-cold-slot.png` and `logs/eeprom-cold-slot.log`.
- Final gameplay statistics: `logs/tcp-acceptance.log`.

Natural continuation reached the first staircase and exit-sign area; collisions
with an enemy caused a death, followed by a normal respawn with one life spent.
That life count persisted in the cold save-slot screen. The next room and
completed Vision progress were not reached.

## Local integration notes

Dependencies were exported from clean local pinned Git objects into `.deps/`,
without changing any shared checkout or other game's project. The retail BIOS
remains at its existing input path; the ROM remains its single original copy.
Cart and BIOS translations are kept locally in ignored `generated/`.

The first negative-input test exposed the framework accepting an invalid BIOS
input. Project-owned `src/main.cpp` now checks both originals independently of
the runtime's loader before starting. Shared runtime source was not changed.

Local TCP required the host and client to run outside the shell sandbox's
network isolation; ordinary smoke, replay and Play.cmd require no TCP. The
TCP process ended with the runtime's normal quit command before cold startup.
Logs remain bounded; no instruction trace or frame dump sequence was enabled.


## Source publication housekeeping — 2026-10-10

Full pre-publication project and Git history are preserved in
`KlonoaEmpireOfDreamsRecomp_prepub_20261010.7z` outside the project.
Archive integrity: PASS. SHA-256:
`43563a1894b6ccd20e603f1f685463a440c318280be381a3fdfd7f1f13327e7f`.
Older raw screenshots, TCP logs, temporary package tests and replay scripts
referenced above now live in that archive. Their acceptance conclusions remain
in this document and RELEASE_TEST_RESULT.json; no game tests were repeated.
Current executables, dependency snapshots, generated cartridge/BIOS sources,
private input locations and every existing save are retained unchanged.
Public main starts from a clean root commit; local development history is kept
on `local/pre-publication-20261010` and in the archive because the historical
startup prompt contains machine-specific paths. No runtime/game code changed.
