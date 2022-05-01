extends Node2D

export(NodePath) var nave 

func _ready():
	if nave:
		nave = get_node(nave)
	else:
		set_process(false)

# warning-ignore:unused_argument
func _process(delta):
	
	global_position.y = (nave.global_position.y - 80) * 0.002 * -160
