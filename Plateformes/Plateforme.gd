extends StaticBody2D

enum Type {
	TYPE1,
	TYPE2
}
export (Type) var type = Type.TYPE1

# Called when the node enters the scene tree for the first time.
func _ready():
	match(type):
		Type.TYPE1:
			$Plateforme1.visible = false
		Type.TYPE2:
			$Plateforme2.visible = false

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
