extends Node2D
	
var plateforme = load("res://niveau/Plateforme.tscn")

func _ready():
	var infos = global.infos_niveau
	
	var dir = Directory.new()
	if dir.open(infos.path + "/plateformes") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
				var file = File.new()
				file.open(infos.path + "/plateformes/"+file_name+"/infos.json",file.READ)
				var text = file.get_as_text()
				var infos_plateforme = parse_json(text)
				infos_plateforme["path"] = infos.path + "/plateformes/" + file_name
				var instance = plateforme.instance()
				instance.infos = infos_plateforme
				add_child(instance)
			file_name = dir.get_next()


func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://menus/menu/Menu.tscn")
