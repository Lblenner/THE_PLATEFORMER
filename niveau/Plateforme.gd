extends StaticBody2D

export var infos = {
	"name": "Ma plateforme !",
	"image": "1P_SansBordDroit.bmp",
	"path": "user://plateformes/plateforme1",
	"position": "600 0",
	"parts": [
		{   
			"position": "0 0",
			"image_scale": "1 1",
			"body_size": "94 17",
			"image": "1P_SansBordDroit.bmp"
		}
	]
}

export var edition = false
export var drag = false
var first = true
var sprite: Sprite

func _process(delta):
	
	if edition:
		var mouse_pos = get_global_mouse_position()
		if Input.is_action_just_pressed("Left") and isIn(mouse_pos,position,sprite.get_rect().size):
			drag = !drag
		
		if drag:
			position = mouse_pos

func isIn(position, positionRec, size):
	if position.x > positionRec.x - size.x/2 and position.x < positionRec.x + size.x/2: 
		if position.y > positionRec.y - size.y/2 and position.y < positionRec.y + size.y/2:
			return true
	return false
	
	
func _ready():
	
	position = getVector(infos.get("position"))
	
	for item in infos.get("parts"):

		var pos = getVector(item.get("position"))
		var size_to = getVector(item.get("body_size"))
		var scale = getVector(item.get("image_scale"))
		var texture_path = infos.get("path") + "/" + item.get("image")
	
		var col = CollisionShape2D.new()
		col.shape= RectangleShape2D.new()
		col.shape.set_extents(size_to)
		col.position = pos
		add_child(col)
		
		sprite = Sprite.new()
		var image_texture = ImageTexture.new()
		
		var image = Image.new()
		var err = image.load(texture_path)
		if(err != 0):
			print(err)
			print("error loading the image: " + texture_path)

		image_texture.create_from_image(image)
		sprite.texture = image_texture
		sprite.scale = scale
		sprite.position = pos
		add_child(sprite)


func getVector(msg: String):
	var l = msg.split(" ")
	return Vector2(l[0],l[1])

func _on_Plateforme_input_event(viewport, event, shape_idx):
	pass
