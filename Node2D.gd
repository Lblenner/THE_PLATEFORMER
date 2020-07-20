extends Node2D

func _ready():
	var niveau = load("res://niveau1.tscn")
	var instance = niveau.instance()
	add_child(instance)
	pass 

