extends Node

var coins = 0
var directionTouch = 0.0
var jumpTouch = false
var positionPlay_x = 0.0

signal updateHUD()
signal actPanelWin()

func addCoin():
	coins += 1
	emit_signal("updateHUD")
	
func winGame():
	yield(get_tree().create_timer(2.8), "timeout")
	get_tree().paused = true
	emit_signal("actPanelWin")
	
