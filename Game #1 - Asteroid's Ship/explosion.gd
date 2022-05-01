extends Node2D


func _ready():
	$particles.emitting = true
	$sparks.emitting = true
#
func _process(delta):
	if not $particles.emitting and not $sparks.emitting:
		queue_free()
