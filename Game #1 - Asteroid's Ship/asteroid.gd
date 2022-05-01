extends Node2D

var chosen = 0

var hp = 0

onready var velX = rand_range(-30, -200)
onready var velY = rand_range(-50, 50)

var knock_back = 0

signal destroyed(node)

var hps = [
	2 ,
	2 ,
	4 ,
	3 ,
	3
]

func _ready():
	randomize()
	
	for a in $asteroids.get_children():
		a.visible = false
	
	if not chosen:
		chosen = (randi() % $asteroids.get_child_count()) + 1
	
	hp = hps[chosen - 1]
	
	var node = get_node("asteroids/Asteroid-" + str(chosen))
	
	node.visible = true
	
	$area/shape.shape.radius = node.texture.get_width() / 2
	
func _process(delta):
	translate(Vector2(velX - knock_back, velY) * delta)
	
	if global_position.y > 400:
		queue_free()
#		global_position.y = -80
	if global_position.y < -80:
		queue_free()
#		global_position.y = 400
		
	if global_position.x < -400:
		queue_free()
#		global_position.x = 800
	
	if knock_back:
			knock_back = lerp(knock_back, 0, .1)

func _on_area_area_entered(area):
	hp -= 1
	knock_back = -100
	if not hp:
		destroy()
	else:
		get_tree().call_group("camera", "treme", .5)

func destroy():
	get_tree().call_group("camera", "treme", 1)
	emit_signal("destroyed", self)
	queue_free()

func get_hp_inicia():
	return hps[chosen - 1]
