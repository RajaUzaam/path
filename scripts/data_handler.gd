extends Node
class_name DataHandler

const save_path: String = 'user://data.cfg'

# Primary Save/Load [NEEDED]
func Save() -> void:
	pass
	
func Load() -> void:
	var config: ConfigFile = ConfigFile.new()
	
	var err = config.load(save_path)
	if err != OK:
		return

	PD.high_score = config.get_value("Stats", "Highscore", 0)
	PD.high_stopwatch_time = config.get_value("Stats", "HighStopwatchTime", 0)
	PD.stars = config.get_value("Currency", "Stars", 0)

# Save Functions for User Configuration, Statistics and Setting [NEEDED]
func SettingsSave() -> void:
	pass

func StatsSave() -> void:
	var config: ConfigFile = ConfigFile.new()
	
	var err = config.load(save_path)
	if err != OK:
		config = ConfigFile.new()
		
	config.set_value("Stats", "Highscore", max(PD.score, PD.high_score))
	config.set_value("Stats", "HighStopwatchTime", PD.stopwatch_time if (max(PD.score, PD.high_score) == PD.score) else PD.high_stopwatch_time)
	config.set_value("Currency", "Stars", PD.score+PD.stars)
	err = config.save(save_path)
	if err != OK:
		return
		

# Load Functions for User Configuration, Settings and, Stats [MIGHT NOT BE NEEDED]
func SettingsLoad() -> void:
	pass

func StatsLoad() -> void:
	pass
