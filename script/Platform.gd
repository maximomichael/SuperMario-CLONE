extends KinematicBody2D

var target 
var raio
var area
var pong = 0

var x = 0
var y = 0

func _ready():
	target = transform.origin
	raio = 90
	transform.origin.x = raio
	
func _process(delta):
	pong += delta

	x = cos(pong) * raio
	y = sin(pong) * raio
	
	transform.origin = Vector2(x, y)

func positionPlatform():
	return global_transform.origin

