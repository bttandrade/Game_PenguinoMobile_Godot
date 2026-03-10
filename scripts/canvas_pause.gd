extends CanvasLayer

var on_menu: bool = false

func _ready() -> void:
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and Globals.can_pause:
		visible = true
		get_tree().paused = true
		on_menu = true

func _on_home_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

func _on_resume_btn_pressed() -> void:
	get_tree().paused = false
	visible = false
