extends Control
class_name ShopUI

@export var clickable_buttons : Array[Control]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	print("IM READY")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setup() -> void:
	self.visible = true
	for node in clickable_buttons:
		node.disabled = false
	get_tree().paused = true



func _on_maxhpplus_button_pressed() -> void:
	print("CLICKED!")
	# check price
	if (Globals.game.save_manager.current_save.coins >= 20):
		Globals.game.save_manager.current_save.coins -= 20;
		# increase global hp
		Globals.game.player.HP_changed.emit(Globals.game.player.HP+1, Globals.game.player.MAX_HP+1)
		Globals.game.save_manager.current_save.MAX_HP += 1;
		Globals.game.player_ui._on_coin_update(Globals.game.save_manager.current_save.coins)
		# play sound
		


func _on_maxrangeplus_button_pressed() -> void:
	print("CLICKED!")
	if (Globals.game.save_manager.current_save.coins >= 20):
		Globals.game.save_manager.current_save.coins -= 20
		var new_scale = Globals.game.player.sword_swipe.scale.y + 1
		Globals.game.player.sword_swipe.update_range(new_scale)
		Globals.game.save_manager.current_save.sword_scale = new_scale
		Globals.game.player_ui._on_coin_update(Globals.game.save_manager.current_save.coins)

	pass # Replace with function body.

func _on_exit_button_pressed() -> void:
	self.visible = false
	get_tree().paused = false
	
