extends Node

enum GlobalState {FirstState, SecondState, ThirdState}

var global_game_state: GlobalState = GlobalState.SecondState;

func _process(delta: float) -> void:
	#pass
	print("GlobalState: %d" % global_game_state);
