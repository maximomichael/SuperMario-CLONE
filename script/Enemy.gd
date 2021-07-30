extends KinematicBody2D

var pointEnemy
export var pointLess = 50
export var pointMore = 60
var positionEnemy = 1
export var velocity = 50

func _ready():
	pointEnemy = global_transform.origin.x
	pointMore += pointEnemy
	pointLess = abs(pointEnemy - pointLess)
	
func _process(delta):
	translate(Vector2(positionEnemy, 0) * velocity * delta)
	monitorDirection()

func monitorDirection():
	if global_transform.origin.x > pointMore:
		positionEnemy = -1
	if global_transform.origin.x < pointLess: 
		positionEnemy = 1
		
	$SpriteEnemy.flip_h = true if positionEnemy == 1 else false
	

func diedEnemy():
	$CollisionEnemy.queue_free()
	set_process(false)
	$SpriteEnemy.visible = false
	$SpriteDeath.visible = true
	
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()
	
