extends Node2D

var opcao = 0
var blinks = 0

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_left"):
		opcao += 1
		$select.play()
	
	if Input.is_action_just_pressed("ui_right"):
		opcao -= 1
		$select.play()
	
	if opcao < 0:
		opcao = $itens.get_child_count() - 1
	
	if opcao > $itens.get_child_count() - 1:
		opcao = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		match opcao:
			0:
				get_tree().change_scene("res://scenes/start_scene.tscn")
			1:
				get_tree().quit()
	
	$seta.global_position = $itens.get_child(opcao).global_position + Vector2(-50, -18)
