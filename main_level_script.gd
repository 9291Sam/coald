extends Node3D

func _ready():
	GlobalGameState.global_game_state = GlobalGameState.GlobalState.FirstState;
	$Player.footstep_noise = 0;

func _process(delta: float) -> void:
	if $GoToTrainButton.is_active:
		get_tree().change_scene_to_file("res://seb_scenes/insideTrain/InsideTrain.tscn")
 
