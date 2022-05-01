extends CanvasLayer

var score = 0

func _ready():
	pass 


func _process(delta):
	pass

func asteroid_destroyed(ast):
	var points = (6 - ast.chosen) * 10
	score += points
	$score.text = str(score)
