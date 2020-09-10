extends PanelContainer


export (String) var text = "Erreur"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
