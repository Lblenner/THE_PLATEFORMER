extends VBoxContainer

var itemLoad = load("res://menus/choix_niveaux/ItemList.tscn")

func _ready():
		
	var liste = []
	var dir = Directory.new()
	if dir.open("user://niveaux") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
				var file = File.new()
				file.open("user://niveaux/"+file_name+"/infos.json",file.READ)
				var text = file.get_as_text()
				var dict = parse_json(text)
				dict["path"] = "user://niveaux/"+file_name
				liste.append(dict)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

	for item in liste:
		var instance = itemLoad.instance()
		instance.text = item["name"]
		instance.connect("gui_input",self,"pressed",[item])
		add_child(instance)


func pressed(event,infos):
	if event is InputEventMouseButton and event.pressed and Input.is_action_pressed("Left"):
		var root = load("res://niveau/Root.tscn")
		global.infos_niveau = infos
		get_tree().change_scene_to(root)
