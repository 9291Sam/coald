extends Interactible3D

func _interact():
	get_parent().get_node("SubViewport/InsideTrainUi").pressure_gague_normalized += randf_range(0.001, 0.01);
