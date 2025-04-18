extends Interactible3D

#var time_alive: float

#func _process(delta: float) -> void:
	#pass
	#time_alive += delta;
	#get_parent().get_node("SubViewport/InsideTrainUi").temperature_gague_normalized = fmod(time_alive, 1.0);
	#get_parent().get_node("SubViewport/InsideTrainUi").pressure_gague_normalized = fmod(time_alive, 1.0);

func _interact():
	get_parent().get_node("SubViewport/InsideTrainUi").temperature_gague_normalized -= randf_range(0.001, 0.01);
