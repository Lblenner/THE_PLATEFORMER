extends Button

func _on_Button_pressed():
	var txt = get_parent().get_node("Label2").get_node("TextEdit").text

	if (txt == "" or txt == "Entrez un nom pour le niveau"):
		get_parent().get_node("Label2").get_node("TextEdit").text = "Entrez un nom pour le niveau"
		return
		
	var p = get_node("/root/ControlRoot/Node2D")
	var liste = p.get_children()
	
	var i = 0 
	while i < liste.size():
		if not liste[i].is_in_group("plat"):
			liste.remove(i)
		else:
			i += 1

	var file = File.new()
	file.open("user://niveaux/cpt",File.READ)
	var cpt = file.get_as_text()

	var dir = Directory.new()
	dir.open("user://niveaux")
	dir.make_dir(cpt)

	var niveau_infos = File.new()
	niveau_infos.open("user://niveaux/"+cpt+"/infos.json", File.WRITE)
	niveau_infos.store_line(to_json({"name":txt}))

	dir.open("user://niveaux/"+cpt)
	dir.make_dir("plateformes")

	var cpt_plateforme = 1
	for elem in liste:

		var infos = elem.infos
		infos["position"] = str(elem.position.x) + " " + str(elem.position.y)

		dir.open("user://niveaux/"+cpt+"/plateformes")
		dir.make_dir(str(cpt_plateforme))

		niveau_infos.open("user://niveaux/"+cpt+"/plateformes/"+str(cpt_plateforme)+"/infos.json", File.WRITE)
		niveau_infos.store_line(to_json(infos))

		for elem in infos.parts:
			var image = Image.new()
			image.load(infos.path+"/"+elem.image)
			image.save_png("user://niveaux/"+cpt+"/plateformes/"+str(cpt_plateforme)+"/"+elem.image)

		cpt_plateforme += 1


	file.open("user://niveaux/cpt",File.WRITE)
	file.store_string(str(int(cpt)+1))
	file.close()
	niveau_infos.close()
	get_tree().change_scene("res://menus/menu/Menu.tscn")
