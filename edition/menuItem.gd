extends Control

export (String) var text = "Erreur"
export (String) var path = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/List/Label.text = text
	var tex : ImageTexture = ImageTexture.new()
	var image : Image = Image.new()
	image.load(path)
	var size = image.get_size()
	tex.create_from_image(image)
	tex.set_size_override(Vector2(100,(100/size.x)*size.y))
	$MarginContainer/List/CenterContainer/TextureRect.texture = tex
