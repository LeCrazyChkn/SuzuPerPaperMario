extends TextureProgressBar

@onready var flash = Color(2.0, 2.0, 2.0) # White glow flash
@onready var normal = Color(1, 1, 1) # Normal color
@export_multiline var text : String = "" 
@export
var previous_value := value

func set_health(new_value: float):
	# Animate bar
	var tween = create_tween()
	tween.tween_property(self, "value", clamp(new_value, 0, 100), 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# Pulse effect	
	var pulse = create_tween()
	modulate = flash
	pulse.tween_property(self, "modulate", normal, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Update stored value
	previous_value = clamp(new_value, 0, 100)
	
	#debug
	#print("Prev is " + str(previous_value))
	#print("Current is " + str(new_value))
	
		
	
