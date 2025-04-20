extends CSGBox3D

func _process(delta: float) -> void:
	if GlobalGameState.global_game_state >= GlobalGameState.GlobalState.ThirdState:
		self.visible = true
	else:
		self.visible = false;
