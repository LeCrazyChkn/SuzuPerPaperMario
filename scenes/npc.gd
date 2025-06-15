extends CharacterBody3D
@onready var sprite := $AnimatedSprite3D


func _process(delta: float) -> void:
	sprite.play("walk")
