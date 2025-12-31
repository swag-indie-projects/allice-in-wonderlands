extends Control
class_name SavePopupUI

@onready var panel : PanelContainer = $PanelContainer

func show_save_popup() -> void:
	$AnimationPlayer.stop()
	$AnimationPlayer.play("show")
