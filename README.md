# Upload Labs — Balance Tweaks

A configurable balance mod for [Upload Labs](https://store.steampowered.com/app/3606890/Upload_Labs/), built on the [Godot Mod Loader](https://wiki.godotmodding.com/) (which ships inside the game).

## What it does

Rescales the game's balance data the moment it loads, before anything else reads it:

| Setting | Default | Effect |
|---|---|---|
| `boost_duration_multiplier` | `2.0` | Boosts last twice as long |
| `boost_cost_multiplier` | `0.75` | Boosts are 25% cheaper |
| `perk_cost_multiplier` | `1.0` | Perk token costs unchanged |
| `upgrade_cost_multiplier` | `0.9` | Upgrades are 10% cheaper |

Every value is configurable — see below.

## Installation

1. Download `Taylor-BalanceTweaks-x.y.z.zip` from the [latest release](../../releases/latest). Do **not** unzip it.
2. Find your Upload Labs install folder (Steam: right-click the game → Manage → Browse local files).
3. Create a folder named `mods` next to `Upload Labs.exe` if it doesn't exist.
4. Drop the ZIP into that `mods` folder.
5. Launch the game.

To uninstall, delete the ZIP from the `mods` folder.

## Configuration

After running the game once with the mod installed, a config file is created at:

```
%APPDATA%\Upload Labs\mod_configs\Taylor-BalanceTweaks\default.json
```

Edit the multipliers there and restart the game. Values are validated against the mod's schema; if the file is invalid the built-in defaults are used.

## How it works

Upload Labs ships with Godot Mod Loader 7 enabled. This mod installs a
[script extension](https://wiki.godotmodding.com/guides/modding/script_extensions/)
on the game's `Data` autoload (`res://scripts/data.gd`). After the vanilla
`_init()` loads `data/*.json` into dictionaries, the extension multiplies boost
durations/costs, perk costs, and upgrade base costs by the configured factors.
No game files are modified on disk.

## Compatibility

- Game version: 2.2.12 (Godot 4.6.1, Mod Loader 7.0.1)
- Save-safe: the mod only changes runtime balance data. Removing it returns the game to vanilla values; purchases made at modded prices persist, which is the expected behavior for balance mods.

## Building from source

The installable ZIP is just the `mods-unpacked` tree zipped from the repo root:

```powershell
Compress-Archive -Path mods-unpacked -DestinationPath Taylor-BalanceTweaks-1.0.0.zip
```

## License

MIT — see [LICENSE](LICENSE).
