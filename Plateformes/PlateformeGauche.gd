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
			$"1P_SansBordDroit".visible = true
			$"2P_SansBordDroit".visible = false
		Type.TYPE2:
			$"2P_SansBordDroit".visible = true
			$"1P_SansBordDroit".visible = false




