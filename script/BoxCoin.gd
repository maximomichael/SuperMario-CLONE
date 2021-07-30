extends StaticBody2D

onready var OBJECT = preload("res://scenes/Coin.tscn")
onready var spriteBox = load("res://assets/Tiles/boxAlt.png")
export(int, 0, 10) var quantObject = 1

var boxActive = true

func destroyBox():
	if boxActive:
		boxActive = false
		$Sprite.texture = spriteBox
		for value in range(quantObject):
			var instObject = OBJECT.instance()
			instObject.addCoin()
			instObject.processActive = true
			add_child(instObject)
			yield(get_tree().create_timer(.4), "timeout")

