extends Node2D


func _on_h_slider_value_changed(value: float) -> void:
	get_viewport().scaling_3d_scale = value


func _on_option_button_item_selected(index: int) -> void:
	get_viewport().msaa_3d = Viewport.MSAA_DISABLED
	get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
	get_viewport().use_taa = false
	
	if index == 1:
		get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
	elif index == 2:
		get_viewport().msaa_3d = Viewport.MSAA_2X
	elif index == 3:
		get_viewport().msaa_3d = Viewport.MSAA_4X
	elif index == 4:
		get_viewport().msaa_3d = Viewport.MSAA_8X
	elif index == 5:
		get_viewport().use_taa = true


func _on_option_button_2_item_selected(index: int) -> void:
	get_viewport().scaling_3d_mode = index
