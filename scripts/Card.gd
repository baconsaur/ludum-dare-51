extends TextureButton

onready var sprite = $AnimatedSprite


func set_type(type_dict):
	sprite.play(type_dict["image_name"])
