extends Node3D

enum OutsideState {BeforePull, AfterPull};

var state: OutsideState =  OutsideState.BeforePull;
var time_since_train_move_start = 0.0;

var distance_last_frame = 100000000.0;

const train_kill_velocity = 120;
const traik_kill_travel_time = 1.15;

var horn_sound = preload("res://seb_assets/train_horn.wav")

func _ready():
	$Player.footstep_noise = 2;
	
var time_alive = 0.0;
var thunder_triggered = false;

func _process(delta):
	time_alive += delta;
	match state:
		OutsideState.BeforePull:
			$FinalTrainLight.position.z = train_kill_velocity * traik_kill_travel_time;
			$Lever.lever_state_inorm = 0.0;
			if $Lever/Interactible3D.is_active:
				$Lever.lever_state_inorm = 0.5;
				$Lever/Interactible3D.CanInteract = false;
				GlobalGameState.global_game_state += 1;
				thunder_triggered = true;
				state = OutsideState.AfterPull;
				
			if GlobalGameState.global_game_state == GlobalGameState.GlobalState.SecondState and not thunder_triggered and time_alive > 15.0:
				thunder_triggered = true;
				$Player/ThunderPlayer.play();
			pass
		OutsideState.AfterPull:
			$train/go_back_inside_button.CanInteract = true;
			if $train/go_back_inside_button.is_active:
				get_tree().change_scene_to_file("res://seb_scenes/insideTrain/InsideTrain.tscn")
				
			if GlobalGameState.global_game_state >= GlobalGameState.GlobalState.FourthState:
				if $WorldEnvironment.environment != null:
					$WorldEnvironment.environment.fog_depth_end = 1000.0;
				$train.translate(Vector3(0, -1000, 0));
				$FireLightDistance.visible = true;
				
				if $Player.position.x > 0.0:
					$FinalTrainLight.visible = true;
					time_since_train_move_start += delta;
					
					var current_distance = $Player.position.distance_to($FinalTrainLight.position);
					
					if !$Player/AudioStreamPlayer3D.is_playing():
						$Player/head/Camera3D.look_at($FinalTrainLight.position);
						$Player/AudioStreamPlayer3D.stream = horn_sound
						$Player/AudioStreamPlayer3D.play()
						$Player/AudioStreamPlayer3D2.stop();
					
					
					if time_since_train_move_start > traik_kill_travel_time:
						get_tree().change_scene_to_file("res://scenes/mainMenu.tscn")
						
					$FinalTrainLight.position.z -= delta*train_kill_velocity;
						
					distance_last_frame = current_distance;
				pass
			pass
	pass
