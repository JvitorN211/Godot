extends Node2D

const PRE_ASTEROID = preload("res://scenes/asteroid.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")
const PRE_CRISTAL = preload("res://scenes/cristal.tscn")

export(NodePath) var nave 

func _ready():
	restartTimer()

# warning-ignore:unused_argument
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	
	var ast = create_asteroid()
	add_child(ast)
	ast.global_position = Vector2(300, rand_range(40, 120))
	restartTimer()

func restartTimer():
		$spawn_timer.wait_time = rand_range(.5, 3)
		$spawn_timer.start()

func on_asteroid_destroyed(ast):
	if ast.chosen >= 3:
# warning-ignore:unused_variable
		for a in range((randi() % 2) + 2):
			var new_ast = create_asteroid()
			new_ast.chosen = (randi() % 2) + 1
			add_child(new_ast)
			new_ast.global_position = ast.global_position
	
	get_tree().call_group("hud", "asteroid_destroyed", ast)
	
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = ast.global_position
	
# warning-ignore:unused_variable
	for a in range(ast.get_hp_inicia()):
		var c = PRE_CRISTAL.instance()
		add_child(c)
		c.global_position = ast.global_position
	
func create_asteroid():
	var ast = PRE_ASTEROID.instance()
	ast.connect("destroyed", self, "on_asteroid_destroyed")
	return ast
