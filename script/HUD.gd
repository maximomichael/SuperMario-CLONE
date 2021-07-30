extends CanvasLayer

func _ready():
	upHUD()
	GameControl.connect("updateHUD", self, "upHUD")
	GameControl.connect("actPanelWin", self, "activePanelWin")


func upHUD():
	$PanelCoin/Label.text = str(GameControl.coins)

func activePanelWin():
	$PanelWin.visible = true
