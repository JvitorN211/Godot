extends Sprite

var time = 0.0

func _process(delta):
	time += delta
	material.set_shader_param("time", time)
