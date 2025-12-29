extends Node

# they are both in db
var background_music_volume: float = -10.0
var sound_effect_volume: float = -5.0

const MININUM_VOLUME: float = -10.0
const MAXIMUM_VOLUME: float = 10.0

func _ready() -> void:
	if background_music_volume <= MININUM_VOLUME:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"background music"), -999)

func set_background_music_volume(volume: float) -> void:
	background_music_volume = volume
	
	if volume <= MININUM_VOLUME:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"background music"), -999)
		return
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"background music"), background_music_volume)

func set_sound_effect_volume(volume: float) -> void:
	sound_effect_volume = volume
	
	if volume <= MININUM_VOLUME:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"sound effect"), -999)
		return
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"sound effect"), sound_effect_volume)

func percent_to_db(volume_in_percentage: float) -> float:
	volume_in_percentage = clampf(volume_in_percentage, 0.0, 100.0)
	return lerp(MININUM_VOLUME, MAXIMUM_VOLUME, volume_in_percentage / 100.0)

func db_to_percent(volume_in_db: float) -> float:
	volume_in_db = clampf(volume_in_db, MININUM_VOLUME, MAXIMUM_VOLUME)
	return (volume_in_db - MININUM_VOLUME) / (MAXIMUM_VOLUME - MININUM_VOLUME) * 100.0
