extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	if (Globals.get_game()):
			Globals.game.cutscene_manager.end_cutscene()
	pass # Replace with function body.
