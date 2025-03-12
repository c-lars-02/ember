extends Label

func _process(delta: float) -> void:
	set_text(Time.get_datetime_string_from_system())
