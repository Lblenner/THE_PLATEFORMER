extends Node

export var a = 1

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://menus/menu/Menu.tscn")

