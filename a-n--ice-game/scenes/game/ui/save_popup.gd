extends Control

@onready var text = $PanelContainer/TextEdit

func _ready():
	pass;

func _process(delta):
	text.text = text.text + "."
	if (len(text.text) >= 5):
		text.text = "Saving"
