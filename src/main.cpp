#include "runtime.h"
#include <filesystem>
#include <iostream>
#include <string>
#include <vector>

int game_launcher_preboot(std::vector<std::string>&, const gbarecomp::RunOptions&);
int game_validate_inputs(std::vector<std::string>&, const gbarecomp::RunOptions&);

int main(int argc, char** argv) {
    for (int i = 1; i < argc; ++i) {
        const std::string arg = argv[i];
        if (arg == "--help" || arg == "-h") {
            std::cout << "Klonoa: Empire of Dreams — v0.1.0-preview\n"
                         "Run without arguments for the launcher, or --launcher to reopen it.\n"
                         "Developer CLI: --rom FILE --bios FILE --config FILE --save FILE\n"
                         "               --window | --no-window --frames N\n";
            return 0;
        }
    }
    gbarecomp::RunOptions options;
    options.builtin_game_name = "Klonoa: Empire of Dreams";
    options.builtin_rom_sha1 = "a0a298d9dba1ba15d04a42fc2eb35893d1a9569b";
    options.launcher_region = "USA";
    options.launcher_game_config = "player.toml";
    options.launcher_expose_widescreen = false;
    options.launcher_expose_adaptive_view = false;
    options.launcher_save_path = "saves/klonoa_eod_usa.sav";
    std::vector<std::string> args(argv, argv + argc);
    std::error_code error;
    const auto exe = std::filesystem::absolute(argv[0], error);
    const bool player_launch = argc == 1 || (argc == 2 && args[1] == "--launcher");
    if (player_launch) {
        if (!error) std::filesystem::current_path(exe.parent_path(), error);
    }
    if (game_launcher_preboot(args, options)) return 0;
    if (game_validate_inputs(args, options)) return 1;
    // This framework pin configures EEPROM size through TOML, not CLI flags.
    // Keep explicit developer configs; otherwise use the path-free player one.
    bool explicit_config = false;
    for (const auto& arg : args) if (arg == "--config") explicit_config = true;
    if (!explicit_config) {
        args.emplace_back("--config");
        args.emplace_back((exe.parent_path() / "player.toml").string());
    }
    if (player_launch) {
        args.emplace_back("--save");
        args.emplace_back(options.launcher_save_path);
        args.emplace_back("--window");
    }
    std::vector<char*> native_args;
    for (auto& arg : args) native_args.push_back(arg.data());
    return gbarecomp::run_game(static_cast<int>(native_args.size()), native_args.data(), options);
}
