extends Node3D

func _process(delta: float) -> void:
	if $GoToTrainButton.is_active:
		get_tree().change_scene_to_file("res://seb_scenes/insideTrain/InsideTrain.tscn")
 
