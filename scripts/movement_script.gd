extends CharacterBody3D

#Interaction bubble
@onready var interaction_bubble := $TwistPivot/InteractBubble

#This is the script for the first tutorial game, but changed to be for the CharacterBody3D instead.
var mouse_sensitivity:= 0.0005
var twist_input:= 0.0
var pitch_input:= 0.0
@export var gravity_force := 0.5
@onready var twist_pivot :=  $TwistPivot
@onready var pitch_pivot :=  $TwistPivot/PitchPivot


#Acceleration & Speed Variables (ChatGPT)
@export var speed : float = 10.0
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
@onready var camera = $TwistPivot/PitchPivot/SpringArm3D/Camera3D

#dialog variables
@onready var actionable_finder: Area3D = $Sprite/Direction/ActionableFinder

#Health Bar Variables (ChatGPT)
signal stats_changed(phys: float, soc: float, ment: float, emo: float, ecstasy: float)

var phys := 70.0
var soc := 70.0
var ment := 70.0
var emo := 70.0
var ecstasy := 90.0

#Health bar function
func update_stats(new_phys: float, new_soc: float, new_ment: float, new_emo: float, new_ecstasy: float):
	phys = clamp(new_phys, 0, 100)
	soc = clamp(new_soc, 0, 100)
	ment = clamp(new_ment, 0, 100)
	emo = clamp(new_emo, 0, 100)
	ecstasy = clamp(new_ecstasy, 0, 100)
	
	emit_signal("stats_changed", phys, soc, ment, emo, ecstasy)





func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	



func _process(delta:float) -> void:
	
	#gravity
	velocity.y = velocity.y - gravity_force
	
	
	#movement
	var input := Vector3.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.z = Input.get_axis("ui_up", "ui_down")

		# LIMIT the length instead of normalizing
	if input.length() > 1.0:
		input = input.normalized()

	#add the rotated input
	var rotated_input = Vector3.ZERO
	rotated_input = twist_pivot.basis * input
#
	# Target velocity based on input
	target_velocity.x = rotated_input.x * speed
	target_velocity.z = rotated_input.z * speed

	velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)
##
	## Apply deceleration if no input
	if input == Vector3.ZERO:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)
	
	
	#Check if not talking to an NPC, then move the character 
	if State.is_talking == false:
		move_and_slide()


	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, -0.7, 0.7)
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
	#to_camera.y = 0  # Ignore vertical difference

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

	#Play animation if not talking to NPC
	if State.is_talking == false:
		sprite.play(new_suffix + new_animation + "S") 
	#debug
	#sprite.play("default")



	#Debugging: checking x and y inputs
	#print(input.x)
	#print(input.z)
	
	#Show interaction bubble 
	var actionables = actionable_finder.get_overlapping_areas()
	if actionables.size() > 0:
		interaction_bubble.show()
	else:
		interaction_bubble.hide()









#Mouse Input function
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			twist_input = event.relative.x * mouse_sensitivity
			pitch_input = event.relative.y * mouse_sensitivity 
	
	
	#Function to increase all health for 1 ecstasy
	if event.is_action_pressed("camera_rotate_right"):
		Game.update_stats({"phys": 5, "emo":5, "soc": 5, "ment": 5, "ecstasy": -10 })
		
		#debug
	#if event.is_action_pressed("camera_rotate_right"):
		#Game.update_stats({ "phys": -10, "emo": -15 })
	#if event.is_action_pressed("ui_focus_next"):
		#Game.update_stats({ "ecstasy": 10})
		
	#if event.is_action_pressed("ui_cancel"):
		#print(QuestManager.get_active_quests())
		#var delta = QuestManager.advance_quest("Fix Tower")
		#Game.update_stats(delta)
	#if event.is_action_pressed("ui_filedialog_show_hidden"):
		#print(QuestManager.get_active_quests())
		#var delta = QuestManager.advance_quest("Collect Mushrooms")
		#Game.update_stats(delta)

	#Function that call the Actionable to create a dialogue bubble
	#Works when in range of an Actionable area. 
	if event.is_action_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
		
		
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
