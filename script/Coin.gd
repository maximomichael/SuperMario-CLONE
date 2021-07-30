extends Area2D

#onready var time = get_tree().create_timer(0.8)

var velocity = 200
var transValue = 1
var time = 0
var processActive = false
func _ready():
	set_process(processActive)

func _process(delta):
	translate(Vector2(0, -1) * velocity * delta)
	transValue -=  delta
	$Sprite.modulate = Color(1,1,1,transValue)
	time += delta
	if time > 0.90:
		queue_free()
	
# warning-ignore:unused_argument
func _on_Coin_body_entered(body):
	addCoin()
	set_process(true)
	
func addCoin():
	$CollisionCoin.disabled = true
	GameControl.addCoin()

	
