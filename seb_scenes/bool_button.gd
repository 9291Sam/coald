extends Interactible3D

@export var is_active: bool = false;

var frame_number_active = -1;

func _interact():
	frame_number_active = Engine.get_frames_drawn();
	#print(frame_number_active)
	
	
func _process(delta: float) -> void:
	if Engine.get_frames_drawn() == frame_number_active + 2 && frame_number_active != -1:
		is_active = true;
	else:
		is_active = false;
