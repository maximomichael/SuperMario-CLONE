extends KinematicBody2D

export var snap := false
export var move_speed := 250
export var jump_force := 500
export var gravity := 900
export var slope_slide_threshold := 50

var quantJump = 2
var velocity := Vector2()
var playerDied = false
var deathAnime = 0
var positionPlayer 
var diretionDeath = -1
var velocityDeath = 600
var movePlayer = 0
var playerWin = false

func _ready():
	set_process(false)

func _process(delta):
	if global_transform.origin.y < positionPlayer:
		diretionDeath = 1
		velocityDeath = 300		
	transform.origin.y += diretionDeath * velocityDeath * delta
	
func _physics_process(delta: float) -> void: 
	if !playerWin:
		var direction_x := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		
		if GameControl.directionTouch != 0:
			velocity.x = GameControl.directionTouch * move_speed 
		else:
			velocity.x = direction_x * move_speed
		
		if GameControl.jumpTouch or Input.is_action_just_pressed("Jump"):
			if quantJump > 0:
				velocity.y = -jump_force
				snap = false
				quantJump -= 1
	else:
		velocity.x = 0
		translate(Vector2(1, 0) * move_speed * delta)
			
	velocity.y += gravity * delta
	
	var snap_vector = Vector2(0, 32) if snap else Vector2()
	velocity = move_and_slide_with_snap(velocity, snap_vector, Vector2.UP, slope_slide_threshold)
	
	if is_on_floor() and (Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left")) or GameControl.directionTouch != 0:
		velocity.y = 0
		
	var just_landed := is_on_floor() and not snap
	if just_landed:
		snap = true
		quantJump = 2
	
	GameControl.positionPlay_x = global_transform.origin.x
	animationControl(velocity)
	
func animationControl(vectorVelocity : Vector2) -> void:
	if abs(velocity.x) > 0:
		$Sprite.flip_h  = false if velocity.x > 0 else true
		
#	$Sprite.playing = false
#	$Sprite.frame = 7

func diedPlayer():
	positionPlayer = global_transform.origin.y - 150
	playerDied = true
	$CollisionPlayer.queue_free()
	$AreaHead.queue_free()
	$AreaBody.queue_free()
	$AreaFoot.queue_free()
	set_physics_process(false)
	set_process(true)
	yield(get_tree().create_timer(2.5), "timeout")
	get_tree().reload_current_scene()

func _on_AreaHead_body_entered(body):
	if body.collision_layer == 8:
		body.destroyBox()
		
	if body.collision_layer == 64:
		playerWin = true
		GameControl.winGame()
		

func _on_AreaBody_body_entered(body):
	if body.collision_layer == 2:
		diedPlayer()

func _on_AreaFoot_body_entered(body):
	if body.collision_layer == 2:
		body.diedEnemy()
