extends Node2D

enum Type {
	TYPE1,
	TYPE2
}

export (Type) var type1 = Type.TYPE1
export (Type) var type2 = Type.TYPE1
export (Type) var type3 = Type.TYPE1

# Called when the node enters the scene tree for the first time.
func _ready():
	$PlateformeDroite.setType(type3)
	$PlateformeGauche.setType(type1)
	$PlateformeMilieu.setType(type2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
