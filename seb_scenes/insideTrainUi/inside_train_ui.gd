extends Node2D


@export var temperature_gague_normalized: float = 0.0;
@export var pressure_gague_normalized: float = 0.0;
@export var coal_volume: float = 0.0;

func map(x,  in_min,  in_max,  out_min,  out_max):
	return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;



func _process(delta: float) -> void:
	#print("%f %f" % [temperature_gague_normalized , pressure_gague_normalized])
	temperature_gague_normalized = clamp(temperature_gague_normalized, 0.0, 1.0);
	pressure_gague_normalized = clamp(pressure_gague_normalized, 0.0, 1.0);
	coal_volume = clamp(coal_volume, 0.0, 1.0);
	$Temperature/ColorRect.rotation = map(temperature_gague_normalized, 0.0, 1.0, deg_to_rad(45.0), deg_to_rad(330.0));
	$pressure_gague/ColorRect.rotation = map(pressure_gague_normalized, 0.0, 1.0, deg_to_rad(62.0), deg_to_rad(350.0));
