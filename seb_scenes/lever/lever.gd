extends Node3D

# integer normalized float for lever state. -1 is one way, 1 is the other, 0 is vertical
@export var lever_state_inorm: float = 0.0

var time_alive = 0.0

var previous_value = lever_state_inorm;

func map(x,  in_min,  in_max,  out_min,  out_max):
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

func _process(delta: float) -> void:
	$lever_handle.rotation.x = map(lever_state_inorm, -1.0, 1.0, deg_to_rad(-45.0), deg_to_rad(45.0));
	if lever_state_inorm != previous_value and time_alive > 0.0:
		if !$AudioStreamPlayer3D.is_playing():
				$AudioStreamPlayer3D.play()
			
	previous_value = lever_state_inorm;
	
	time_alive += delta;
