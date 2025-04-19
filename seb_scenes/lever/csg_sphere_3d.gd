extends CSGSphere3D

@export var should_blink: bool = true;

var time_alive = 0.0;

func _process(delta: float) -> void:
	time_alive += delta;
	
	if should_blink:
		self.visible = fmod(time_alive, 1.0) > 0.5;
	else:
		self.visible = false;
	
