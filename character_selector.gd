extends Control

@onready var rat_button: Button = $RATRATRATRAT
@onready var pen_button: Button = $PENPENPENPEN

var rat
var pen

func setup() -> void:
	# Connect button presses
	rat_button.pressed.connect(_on_rat_pressed)
	pen_button.pressed.connect(_on_pen_pressed)

	# Highlight and focus logic
	rat_button.mouse_entered.connect(func(): rat_button.grab_focus())
	pen_button.mouse_entered.connect(func(): pen_button.grab_focus())

	# Default focus on PEN
	pen_button.grab_focus()

	# Add hover scaling
	_scale_buttons()

func _on_rat_pressed() -> void:
	_on_character_selected("RAT")

func _on_pen_pressed() -> void:
	_on_character_selected("PEN")

func _on_character_selected(character_name: String) -> void:
	print("Selected character:", character_name)

	# Instantiate both characters
	var rat_scene = preload("res://char/rato.tscn")
	var pen_scene = preload("res://char/pinguim.tscn")

	rat = rat_scene.instantiate()
	pen = pen_scene.instantiate()
	PlayerManager.rat = rat
	PlayerManager.pen = pen

	# Assign who starts active based on button
	if character_name == "RAT":
		PlayerManager.active_player = rat
		PlayerManager.follower_player = pen
	else:
		PlayerManager.active_player = pen
		PlayerManager.follower_player = rat

	# Optional: hide UI
	visible = false

	# Switch to game scene
	get_tree().change_scene_to_file("res://scenes/outside.tscn")

func _scale_buttons() -> void:
	for button in [rat_button, pen_button]:
		button.connect("focus_entered", func(): button.scale = Vector2(1.2, 1.2))
		button.connect("focus_exited", func(): button.scale = Vector2(1, 1))
