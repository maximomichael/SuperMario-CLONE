extends Button

func _ready():
	connect("pressed", self, "_button_pressed")

func _button_pressed():
	yield(get_tree().create_timer(.5), "timeout")
	get_tree().paused = false
	get_tree().reload_current_scene()
