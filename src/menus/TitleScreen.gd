extends MarginContainer

onready var _continue_button = $MenuLayer/MarginContainer/VBoxContainer/Buttons/Continue
onready var _quit_button = $MenuLayer/MarginContainer/VBoxContainer/Buttons/Quit

var Bar = preload ("res://src/menus/TitleScreenBar.tscn")

func _init():
	OS.min_window_size = OS.window_size
	
func _ready():
	Global.load_game()
	
	var player = get_node("/root/MusicPlayer")
	player.play_titlescreen_bgm()
	
	if (OS.get_name() == 'HTML5'):
		_quit_button.visible = false
	if not Global.does_save_file_exist():
		_continue_button.visible = false

func _on_BarTimer_timeout():
	var e = Bar.instance()
	var pos = Vector2(-(get_viewport().size.x / 2), randi() % int(get_viewport().size.y))

	if randf() < 0.5:
		# On the left
		pos.x -= rand_range(50.0, 200.0)
		pos.y -= rand_range(-50.0, 60.0)
	else:
		# On the right
		pos.x += rand_range(50.0, 200.0)
		pos.y += rand_range(-50.0, 60.0)

	e.position = pos
	e.modulate.a = rand_range(0.1, 1.0)
	add_child(e)
	
func _on_NewGame_pressed():
	var _ret = get_tree().change_scene("res://src/cutscenes/intro/Intro.tscn")

func _on_Quit_pressed():
	get_tree().get_root().notification(NOTIFICATION_WM_QUIT_REQUEST)
	get_tree().quit()


func _on_Continue_pressed():
	var _ret = get_tree().change_scene("res://src/menus/LevelSelect.tscn")
