extends CharacterBody3D
@onready var sprite := $AnimatedSprite3D
@export var type := "suzunpc_1"

var flip_speed: float = 0.2 #in radians.
var face_right: bool = true #horizontal rotation
var target_rotation_y : float = 0.0


const speed = 10
var current_state = TALK
var dir = Vector2.RIGHT
var 	start_pos


var is_roaming = true
var is_chatting = false


@onready var camera = get_parent().get_node("PaperCharacter/TwistPivot/PitchPivot/SpringArm3D/Camera3D")
@onready var player = get_parent().get_node("PaperCharacter/CollisionShape3D")

var player_in_chat_zone = false

enum 
{
	IDLE,
	TALK
	
}

func _ready() -> void:
	randomize()







func _process(delta: float) -> void:
	


	
	
	look_at(camera.global_transform.origin,Vector3.UP)
	
	#if player_in_chat_zone:
		#sprite.play("talk") 
	#else:
		#sprite.play("idle")
		#
		
	sprite.play(type)
		#
		##Flip animation: Check if facing right
		#if dir.x > 0.0: 
			#face_right = true
		#elif dir.x < 0.0:
			#face_right = false
			#
		#if not face_right: 
			#flip = PI #rotate by 180 degrees if facing right
		#else:
			#flip = 0
#
			##smooth rotation from Paper Mario tutorial
			#var target_rotation =  flip
			#var current_rotation = sprite.rotation.y
			#sprite.rotation.y = lerp_angle(current_rotation, target_rotation, flip_speed)
#


func _on_chat_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true
	
func _on_chat_detection_area_body_exited(body):
	if body.has_method("player"):
		player_in_chat_zone = false
