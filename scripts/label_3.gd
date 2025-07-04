extends Label


func _on_h_slider_value_changed(value: float) -> void:
	set_text("%.0fx%.0f" % [DisplayServer.screen_get_size()[0] * get_viewport().scaling_3d_scale, DisplayServer.screen_get_size()[1] * get_viewport().scaling_3d_scale])
