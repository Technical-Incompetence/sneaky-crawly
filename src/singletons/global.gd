extends Node

var game_state = {
	"levels_unlocked": 0
}

var levels = [
	{
		"text": "Learning the Basics",
		"path": "res://src/levels/CameraIntro.tscn"
	},
	{
		"text": "Moving Along",
		"path": "res://src/levels/SentryIntro.tscn"
	},
	{
		"text": "Blocked Off",
		"path": "res://src/levels/GateIntro.tscn"
	},
]

var current_level = -1

func save_game():
	var save_file = File.new()
	save_file.open("user://bug_sneak_game.save", File.WRITE)
	
	save_file.store_line(to_json(game_state))

func does_save_file_exist():
	var save_file = File.new()
	return save_file.file_exists("user://bug_sneak_game.save")

func load_game():
	var save_file = File.new()
	if not does_save_file_exist():
		return
	
	save_file.open("user://bug_sneak_game.save", File.READ)
	game_state = parse_json(save_file.get_line())

# If we beat the current level, unlock the next one (level select screen prevents overflows)
func beat_level():
	if (current_level + 1) == game_state["levels_unlocked"]:
		game_state["levels_unlocked"] += 1
	save_game()
	
func did_win_game():
	if (current_level + 1) == len(levels):
		return true
	return false