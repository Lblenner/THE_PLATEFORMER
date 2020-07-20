extends Camera2D

export (int) var myZoom = 2


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var p1 = get_parent().get_node("Perso2")
	position = p1.position
	zoom = Vector2(myZoom,myZoom)

	pass
