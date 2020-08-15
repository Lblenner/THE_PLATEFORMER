extends Node2D

func _ready():
	var niveau = load(global.path_niveau)
	var instance = niveau.instance()
	add_child(instance)
	pass 

