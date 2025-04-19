extends Node3D

# integer normalized float for lever state. -1 is one way, 1 is the other, 0 is vertical
@export var lever_state_inorm: float = 0.0
var time_alive = 0.0

func map(x,  in_min,  in_max,  out_min,  out_max):
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;

func _process(delta: float) -> void:
	time_alive += delta;
	lever_state_inorm = fmod(time_alive, 2) - 1.0;
	$lever_handle.rotation.x = map(lever_state_inorm, -1.0, 1.0, deg_to_rad(-45.0), deg_to_rad(45.0));
