extends Node2D

var positionHome = Vector2()
var positionEnd = Vector2()
var directMove = 0
var nowJump = false
var pressTouch = false


func _ready():
	set_process_input(true)

func _process(delta):

	if pressTouch:
		var distance_x = 0
		var distance_y = 0
		
		distance_x = positionEnd.x - positionHome.x
		distance_y = positionEnd.y - positionHome.y
		
		if abs(distance_x) > 100:
			directMove = clamp(distance_x + delta, -1, 1)
			
		if distance_y < -100 and !nowJump:
			nowJump = true
	else:
		nowJump = false
		GameControl.jumpTouch = nowJump	
		directMove = 0
		
	GameControl.directionTouch = directMove

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			pressTouch = true
			positionHome = event.position
		else:
			pressTouch = false
			positionHome = Vector2()
			positionEnd = Vector2()

	if pressTouch:
		positionEnd = event.position

