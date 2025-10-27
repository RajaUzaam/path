extends Node

# Persistent Data on Load
func _ready():
	DataHandler.new().Load()

# Highest Stats
var high_score: int = 0
var high_stopwatch_time: int = 0

# Current Stats
var score: int = 0
var stopwatch_time: int = 0

# Currency Stats
var stars: int = 0

# Player Configuration & Settings
var player_name: String = ""
