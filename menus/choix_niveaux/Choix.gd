extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var liste = []
	var dir = Directory.new()
	if dir.open("res://niveau/niveaux") == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir() and file_name != "." and file_name != "..":
				liste.append({"path":"res://niveau/niveaux/"+file_name+"/"+file_name+".tscn","name":file_name})
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
		
	print(liste)
	for item in liste:
		var button = Button.new()
		button.text = item["name"]
		button.connect("pressed",self,"pressed",[item["path"]])
		add_child(button)
		
	$ItemList.add_item("salut")
	$ItemList.add_item("salut")
	$ItemList.add_item("salut")
	$ItemList.add_item("salut")

func pressed(path):
	var root = load("res://niveau/Root.tscn")
	global.path_niveau = path
	get_tree().change_scene_to(root)
