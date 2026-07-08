extends Node

const MOD_NAME := "Taylor-BalanceTweaks"
const LOG_NAME := MOD_NAME + ":Main"

var mod_dir_path := ""
var extensions_dir_path := ""


func _init() -> void:
	ModLoaderLog.info("Initializing", LOG_NAME)
	mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(MOD_NAME)
	extensions_dir_path = mod_dir_path.path_join("extensions")

	ModLoaderMod.install_script_extension(extensions_dir_path.path_join("scripts/data.gd"))


func _ready() -> void:
	ModLoaderLog.info("Ready", LOG_NAME)
