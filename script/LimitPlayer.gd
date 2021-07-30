extends KinematicBody2D



# warning-ignore:unused_argument
func _process(delta):
	global_transform.origin.x = GameControl.positionPlay_x 
