extends StaticBody2D

enum Type {
	TYPE1,
	TYPE2
}

export (Type) var type = Type.TYPE1

# Called when the node enters the scene tree for the first time.
func _ready():
	setType(type)
	pass
	
	
func setType(newType):
	type = newType
	match(type):
		Type.TYPE1:
			$"2P_SansBords".visible = false
			$"1P_SansBords".visible = true
		Type.TYPE2:
			$"1P_SansBords".visible = false
			$"2P_SansBords".visible = true



