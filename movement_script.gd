extends CharacterBody3D

#This is the script for the first tutorial game, but changed to be for the CharacterBody3D instead.
var mouse_sensitivity:= 0.001
var twist_input:= 0.0
var pitch_input:= 0.0

@onready var twist_pivot :=  $TwistPivot
@onready var pitch_pivot :=  $TwistPivot/PitchPivot


#Acceleration & Speed Variables (ChatGPT)
@export var speed : float = 8.0
@export var acceleration : float = 15.0
@export var deceleration : float = 20.0
var target_velocity : Vector3 = Vector3.ZERO


#Animation Variables (Paper Mario Tutorial)
@onready var sprite := $Sprite
var flip_speed: float = 0.2 #in radians.
var face_right: bool = true #horizontal rotation
var face_up: bool = false #Vertical 
var player : Node3D
var target_rotation_y : float = 0.0

#ChatGPT sprite rotation variable
@onready var camera = $TwistPivot/PitchPivot/Camera3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta:float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.z = Input.get_axis("ui_up", "ui_down")

	velocity = twist_pivot.basis * input * 1200.0 * delta

		# LIMIT the length instead of normalizing
	if input.length() > 1.0:
		input = input.normalized()
#
	## Target velocity based on input
	#target_velocity.x = input.x * speed
	#target_velocity.z = input.z * speed
#
	## Accelerate towards target velocity
	#velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	#velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)
#
	## Apply deceleration if no input
	#if input == Vector3.ZERO:
		#velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		#velocity.z = move_toward(velocity.z, 0, deceleration * delta)
	
	#Move the character
	move_and_slide()


	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -0.5, 0.5)
	twist_input = 0.0
	pitch_input = 0.0




	#Handling of Animations (Paper Mario Tutorial)
	var new_animation : String = "idle"
	var new_suffix : String = "down_"
	
	#Check if facing right
	if input.x > 0.0: 
		face_right = true
	elif input.x < 0.0:
		face_right = false

		# Only show the 'up' animation if walking upwards
	if abs(input.x) > abs(input.z): 
		face_up = false
	else: 
		if input.z < 0.0: 
			face_up = true
		elif input.z > 0.0:
			face_up = false

	#starts walk animations if moving
	if input != Vector3.ZERO: 
		new_animation = "walk"
	else:
		new_animation = "idle"

	# Play 'up' animations if facing up
	if face_up: 
		new_suffix = "up_" 
	else:
		new_suffix = "down_"



	#Making the player sprite always face the camera (ChatGPT)
	var to_camera = camera.global_transform.origin - global_transform.origin
	to_camera.y = 0  # Ignore vertical difference

	if to_camera.length_squared() > 0.001:  # Avoid divide-by-zero
		var base_rotation = atan2(to_camera.x, to_camera.z)
		#Then apply the flip rotation for the Paper Mario tutorial. 
		var flip = 0.0
		if not face_right: 
			flip = PI #rotate by 180 degrees if facing right

		#smooth rotation from Paper Mario tutorial
		var target_rotation = base_rotation + flip
		var current_rotation = sprite.rotation.y
		sprite.rotation.y = lerp_angle(current_rotation, target_rotation, flip_speed)





	#Play animation
	sprite.play(new_suffix + new_animation) 



	#Debugging: checking x and y inputs
	print(input.x)
	print(input.z)



#Mouse Input function
func _unhandled_input(event: InputEvent) -> void:
		if event is InputEventMouseMotion:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
				twist_input = event.relative.x * mouse_sensitivity
				pitch_input = event.relative.y * mouse_sensitivity 
