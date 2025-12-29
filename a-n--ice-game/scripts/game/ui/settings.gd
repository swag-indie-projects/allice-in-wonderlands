extends Control

class_name Settings

@export var background_music_slider: HSlider
@export var sound_effect_slider: HSlider
signal quit

func _ready() -> void:
	background_music_slider.value = Volumes.db_to_percent(Volumes.background_music_volume)
	sound_effect_slider.value = Volumes.db_to_percent(Volumes.sound_effect_volume)

func _on_button_pressed() -> void:
	quit.emit()

func _on_background_music_h_slider_value_changed(value: float) -> void:
	Volumes.set_background_music_volume(Volumes.percent_to_db(value))

func _on_sound_effect_h_slider_value_changed(value: float) -> void:
	Volumes.set_sound_effect_volume(Volumes.percent_to_db(value))
