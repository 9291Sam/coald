extends Node3D

var time_alive = 0.0;


func fract(x: float) -> float:
	return x - float(floor(x))

func my_hash(x1: float) -> float:
	return float(fract(float(abs(sin(x1 * 12.9898) * 43758.5453))))
	
# Smoothstep interpolation
func interp(a: float, b: float, t: float) -> float:
	var smooth_t = t * t * (3.0 - 2.0 * t) # smoothstep
	return a * (1.0 - smooth_t) + b * smooth_t


# Clean 1D Perlin-like smooth noise function for Godot
func smooth_noise_1d(t: float, frequency: float = 4.0) -> float:
	var t0: float = float(floor(t * frequency))
	var t1: float = float(t0 + 1.0)
	var frac: float = (t * frequency) - t0
	
	return interp(my_hash(t0), my_hash(t1), frac);
	
var temp_velocity = 0.0;
var pressure_velocity = 0.0;

var normalization_factor = 0.90;

func _ready():
	temp_velocity = randf_range(-0.5, 0.5);
	pressure_velocity = randf_range(-0.5, 0.5);
	

func _process(delta: float) -> void:
	time_alive += delta;
	
	var p = smooth_noise_1d(time_alive + 93942.3, 0.03)
	var p2 = smooth_noise_1d(time_alive - 83849.3, 0.03)
	
	var random_smooth_add_normalized = smooth_noise_1d(time_alive, p / 6); # 16
	var random_smooth_add_normalized2 = smooth_noise_1d(time_alive, p2 / 6); # 16
	
	const pressure_normal_base = 0.1 - 0.06;
	const pressure_normal_peak = 0.65 + 0.23;
	
	const temperature_normal_base = 0.17 - 0.12;
	const temperature_normal_peak = 0.54 + 0.32;
	
	var green_zone_rand_temoerature = remap(random_smooth_add_normalized, 0.0, 1.0, temperature_normal_base, temperature_normal_peak);
	var green_zone_rand_pressure = remap(random_smooth_add_normalized2, 0.0, 1.0, pressure_normal_base, pressure_normal_peak);
	$SubViewport/InsideTrainUi.pressure_gague_normalized = green_zone_rand_temoerature + pressure_velocity;
	$SubViewport/InsideTrainUi.temperature_gague_normalized = green_zone_rand_pressure + temp_velocity;
	
	pressure_velocity += randf_range(-0.03, 0.03) * delta;
	temp_velocity += randf_range(-0.03, 0.03) * delta;
	
	print("Pressure: %f | Temp: %f" % [pressure_velocity, temp_velocity]);
	
	temp_velocity *= pow(normalization_factor, delta);
	pressure_velocity *= pow(normalization_factor, delta);
	
	#temp_velocity *= (temp_velocity * normalization_factor * delta);
	#pressure_velocity *= (pressure_velocity * normalization_factor * delta);
	
	if $temp_up_button.is_active:
		temp_velocity += randf_range(0.01, 0.04);
		
	if $temp_down_button.is_active:
		temp_velocity -= randf_range(0.01, 0.04);
		
	if $pressure_up_button.is_active:
		pressure_velocity += randf_range(0.01, 0.04);
		
	if $pressure_down_button.is_active:
		pressure_velocity -= randf_range(0.01, 0.04);
	
	if $leave_train_button.is_active:
		get_tree().change_scene_to_file("res://seb_scenes/lever/lever_pull.tscn")
		
	if $Lever/lever_pull.is_active:
		if $Lever.lever_state_inorm == 0.0:
			$Lever/lever_pull.CanInteract = false;
			$leave_train_button.CanInteract = true;
			$Lever.lever_state_inorm = 0.5;
		
	
	
