extends Node2D

var opcao = 0
var blinks = 0

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_down"):
		opcao += 1
		$select.play()
	
	if Input.is_action_just_pressed("ui_up"):
		opcao -= 1
		$select.play()
	
	if opcao < 0:
		opcao = $itens.get_child_count() - 1
	
	if opcao > $itens.get_child_count() - 1:
		opcao = 0
	
	if Input.is_action_just_pressed("ui_accept"):
		match opcao:
			0:
				$timer_blink.start()
				$start.play()
			1:
				$timer_blink.start()
				$start.play()
			2:
				$timer_blink.start()
				$start.play()
	
	$seta.global_position = $itens.get_child(opcao).global_position + Vector2(-50, -18)


func _on_timer_blink_timeout():
	if opcao == 0:
		blinks += 1
		$itens/restart.visible = not $itens/restart.visible
		if blinks > 10:
			get_tree().change_scene("res://scenes/game.tscn")
	if opcao == 1:
		blinks += 1
		$itens/menu.visible = not $itens/menu.visible
		if blinks > 10:
			get_tree().change_scene("res://scenes/start_scene.tscn")
	if opcao == 2:
		blinks += 1
		$itens/quit.visible = not $itens/quit.visible
		if blinks > 10:
			get_tree().quit()
