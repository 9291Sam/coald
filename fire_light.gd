extends OmniLight3D

var time_alive: float = 0.0 

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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_alive += delta;
	
	light_energy = remap(smooth_noise_1d(time_alive), 0.0, 1.0, 0.75, 1.23);
	#print(light_energy);
	pass
