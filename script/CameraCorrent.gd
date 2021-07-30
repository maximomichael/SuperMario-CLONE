extends Camera2D

onready var player = get_node("../Player")

export(int, 200, 600) var distance = 400
func _ready():
	pass # Replace with function body.

func _process(delta):
	
	if player.playerDied:
		set_process(false)
		
	var valueReturn = 0
	if player.velocity.x > 0 and player.transform.origin.x > transform.origin.x + distance:
		translate(Vector2(1, 0) * player.velocity.x * delta) 
	
	translate(Vector2(0, 1) * player.velocity.y * delta)
	
	valueReturn = player.transform.origin.y
		
	if valueReturn > 0:
			valueReturn -= delta
			transform.origin.y = valueReturn - 400
		
