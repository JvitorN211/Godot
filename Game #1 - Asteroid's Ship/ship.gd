extends Node2D

const PRE_LASER = preload("res://scenes/laser.tscn")

export var vel = 120.0

var shield = 20.0

onready var shiel_size = $escudo/Sprite.material.get_shader_param("size")

onready var shape_size = $area/shape.shape.radius

export(NodePath) var lasers 

#Posicao min da nave cima 21
#Posicao max da nave baixo 139
#Posicao min da nave esquerda 24
#Posicao max da nave direita 268

#Executa uma única vez assim que a nave entra no cenário.
func _ready():
	
	if lasers:
		lasers = get_node(lasers)
	else:
		lasers = get_parent()

#Executa o processo 60 vezes por segundo.
func _process(delta):
	
	var dirX = 0
	var dirY = 0
	
	#Move para a esquerda
	if Input.is_action_pressed("ui_left"):
		dirX += -1
	
	#Move para a direita
	if Input.is_action_pressed("ui_right"):
		dirX += 1
	
	#Move para cima
	if Input.is_action_pressed("ui_up"):
		dirY += -1
	
	#Move para baixo
	if Input.is_action_pressed("ui_down"):
		dirY += 1
	
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().get_nodes_in_group("lasers").size() < 5:
			var laser = PRE_LASER.instance()
			lasers.add_child(laser)
			laser.global_position = $blaster1.global_position
			
			#laser = PRE_LASER.instance()
			#lasers.add_child(laser)
			#laser.global_position = $blaster2.global_position
	
	translate(Vector2(dirX,dirY) * vel * delta)
	pass
	
	global_position.y = clamp(global_position.y, 21, 139)
	global_position.x = clamp(global_position.x, 24, 268)


func _on_area_area_entered(area):
	
	if area.get_parent().has_method("destroy"):
		area.get_parent().destroy()
	
	if [4].find(area.collision_layer) >= 0:
		get_tree().call_group("camera", "treme", 1)
		shield -= 1.0
		var proporcao = shield / 20.0
		$area/shape.shape.radius = shape_size * proporcao
		$escudo/Sprite.material.set_shader_param("size", shiel_size * proporcao)


func _on_dead_area_area_entered(area):
	visible = false
	set_process(false)
	get_tree().change_scene("res://scenes/game_over.tscn")
