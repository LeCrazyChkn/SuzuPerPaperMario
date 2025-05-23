# health_bar.gd
extends TextureProgressBar

func set_health(new_value: float):
	var tween = create_tween()
	tween.tween_property(self, "value", new_value, 0.3).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
