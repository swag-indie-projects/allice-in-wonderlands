extends Control
class_name SavePopupUI

@onready var panel : PanelContainer = $PanelContainer

func show_save_popup() -> void:
	print("save popup...")
	panel.visible = true
	while panel.modulate.a >= 0:
		await get_tree().create_timer(1.0).timeout
		panel.modulate.a -= 0.10
	panel.visible = false
	panel.modulate.a = 1.0
