extends Node

enum GlobalState {FirstState, SecondState, ThirdState, FourthState}

var global_game_state: GlobalState = GlobalState.FirstState;

func _process(delta: float) -> void:
	print("GlobalState: %d" % global_game_state);
