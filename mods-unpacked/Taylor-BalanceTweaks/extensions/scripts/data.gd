extends "res://scripts/data.gd"

# Script extension for the Data autoload. The parent _init() loads every
# data/*.json file into dictionaries; we then rescale the balance values
# before anything else in the game reads them.

const BT_MOD_ID := "Taylor-BalanceTweaks"
const BT_LOG_NAME := BT_MOD_ID + ":Data"

const BT_DEFAULTS := {
	"boost_duration_multiplier": 2.0,
	"boost_cost_multiplier": 0.75,
	"perk_cost_multiplier": 1.0,
	"upgrade_cost_multiplier": 0.9,
}


func _init() -> void:
	super()
	_bt_apply_tweaks()


func _bt_get_settings() -> Dictionary:
	var settings: Dictionary = BT_DEFAULTS.duplicate()
	var config: ModConfig = ModLoaderConfig.get_current_config(BT_MOD_ID)

	if config != null and not config.data.is_empty():
		for key: String in settings.keys():
			if config.data.has(key):
				settings[key] = float(config.data[key])
	else:
		ModLoaderLog.info("No mod config found, using built-in defaults.", BT_LOG_NAME)

	return settings


func _bt_apply_tweaks() -> void:
	var settings: Dictionary = _bt_get_settings()

	for boost: Dictionary in boosts.values():
		if boost.has("duration"):
			boost.duration = maxf(1.0, roundf(float(boost.duration) * settings.boost_duration_multiplier))
		if boost.has("cost"):
			boost.cost = maxf(1.0, roundf(float(boost.cost) * settings.boost_cost_multiplier))

	for perk: Dictionary in perks.values():
		if perk.has("cost"):
			perk.cost = maxf(1.0, roundf(float(perk.cost) * settings.perk_cost_multiplier))

	# Upgrade costs are stored as mantissa ("cost") + exponent ("cost_e"),
	# so scale the mantissa only and skip rounding to preserve precision.
	for upgrade: Dictionary in upgrades.values():
		if upgrade.has("cost"):
			upgrade.cost = float(upgrade.cost) * settings.upgrade_cost_multiplier

	ModLoaderLog.info(
		"Applied balance tweaks to %d boosts, %d perks, %d upgrades. Settings: %s"
		% [boosts.size(), perks.size(), upgrades.size(), JSON.stringify(settings)],
		BT_LOG_NAME
	)
