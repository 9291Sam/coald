extends Node2D


@export var temperature_gague_normalized: float = 0.0;
@export var pressure_gague_normalized: float = 0.0;
@export var enable_light: bool = false;

var time_alive = 0.0;


func _process(delta: float) -> void:
	time_alive += delta;
	#print("%f %f" % [temperature_gague_normalized , pressure_gague_normalized])
	temperature_gague_normalized = clamp(temperature_gague_normalized, 0.0, 1.0);
	pressure_gague_normalized = clamp(pressure_gague_normalized, 0.0, 1.0);
	$Temperature/ColorRect.rotation = remap(temperature_gague_normalized, 0.0, 1.0, deg_to_rad(45.0), deg_to_rad(330.0));
	$pressure_gague/ColorRect.rotation = remap(pressure_gague_normalized, 0.0, 1.0, deg_to_rad(62.0), deg_to_rad(350.0));
	
	if enable_light:
		$Ellipse1.visible = fmod(time_alive, 1.0) > 0.5;
	else:
		$Ellipse1.visible = false;
