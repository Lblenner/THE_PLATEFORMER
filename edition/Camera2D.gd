extends Camera2D

var myZoom = 1

func _ready():
	zoom = Vector2(2,2)

func _process(delta):
	if (Input.is_action_pressed("ui_right")):
		position.x = position.x + 30
	if (Input.is_action_pressed("ui_left")):
		position.x = position.x - 30
	if (Input.is_action_pressed("ui_down")):
		position.y = position.y + 30
	if (Input.is_action_pressed("ui_up")):
		position.y = position.y - 30
	if (Input.is_action_pressed("zoom")):
		zoom = Vector2(zoom.x-0.1,zoom.x-0.1)
	if (Input.is_action_pressed("unzoom")):
		zoom = Vector2(zoom.x+0.1,zoom.x+0.1)

