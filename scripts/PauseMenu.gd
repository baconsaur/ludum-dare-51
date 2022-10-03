extends Control

export var menu_scene = "res://scenes/MainMenu.tscn"

onready var music_toggle = $MenuContainer/ButtonContainer/MusicToggle
onready var sound_toggle = $MenuContainer/ButtonContainer/SoundToggle
onready var music_bus = AudioServer.get_bus_index("Music")
onready var sounds_bus = AudioServer.get_bus_index("Sounds")


func _ready():
	set_sound_label()
	set_music_label()
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		unpause()

func _on_ResumeButton_pressed():
	unpause()

func _on_MainMenuButton_pressed():
	unpause()
	get_tree().change_scene(menu_scene)

func unpause():
	get_tree().paused = false
	queue_free()

func set_sound_label(toggle_audio=false):
	var muted = AudioServer.is_bus_mute(sounds_bus)
	if toggle_audio:
		muted = not muted
		AudioServer.set_bus_mute(sounds_bus, muted)
	sound_toggle.text = "Sound effects " + ("ON" if muted else "OFF")

func set_music_label(toggle_audio=false):
	var muted = AudioServer.is_bus_mute(music_bus)
	if toggle_audio:
		muted = not muted
		AudioServer.set_bus_mute(music_bus, muted)
	music_toggle.text = "Music " + ("ON" if muted else "OFF")

func _on_SoundToggle_pressed():
	set_sound_label(true)

func _on_MusicToggle_pressed():
	set_music_label(true)
