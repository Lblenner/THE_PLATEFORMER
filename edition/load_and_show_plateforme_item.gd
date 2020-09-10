extends VBoxContainer

var itemLoad = load("res://edition/menuItem.tscn")

func _ready():
	var liste = []
	var plateformeDir = Directory.new()
	
	if plateformeDir.open("user://plateformes/") == OK:
		plateformeDir.list_dir_begin()
		var file_name = plateformeDir.get_next()
		while file_name != "":
			if plateformeDir.current_is_dir() and file_name != "." and file_name != "..":
				var file = File.new()
				file.open("user://plateformes/"+file_name+"/infos.json",file.READ)
				var text = file.get_as_text()
				var dict = parse_json(text)
				dict["path"] = "user://plateformes/"+file_name
				liste.append(dict)
			file_name = plateformeDir.get_next()
	
	
	for item in liste:
		var instance = itemLoad.instance()
		instance.text = item["name"]
		instance.path = item["path"] + "/" + item["image"]
		instance.connect("gui_input",self,"pressed",[item])
		add_child(instance)

var plat = load("res://niveau/Plateforme.tscn")

func pressed(event,infos):
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_pressed("Left"):
			var n_plat = plat.instance()
			n_plat.edition = true
			n_plat.drag = true
			var n_infos = infos
			n_infos["position"] = str(get_global_mouse_position().x) + " " + str(get_global_mouse_position().y)
			n_plat.infos = infos
			var p = get_node("/root/ControlRoot/Node2D")
			p.add_child(n_plat)
