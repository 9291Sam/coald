extends Node3D

enum OutsideState {BeforePull, AfterPull};

var state: OutsideState =  OutsideState.BeforePull;
var time_since_train_move_start = 0.0;

var distance_last_frame = 100000000.0;

const train_kill_velocity = 120;

func _process(delta):
	match state:
		OutsideState.BeforePull:
			$Lever.lever_state_inorm = 0.0;
			if $Lever/Interactible3D.is_active:
				$Lever.lever_state_inorm = 0.5;
				GlobalGameState.global_game_state += 1;
				state = OutsideState.AfterPull;
			pass
		OutsideState.AfterPull:
			if GlobalGameState.global_game_state >= GlobalGameState.GlobalState.ThirdState:
				if $WorldEnvironment.environment != null:
					$WorldEnvironment.environment.fog_depth_end = 1000.0;
				$train.translate(Vector3(0, -1000, 0));
				$OminiousBlinkingLight.should_blink = true;
				
				if $Player.position.x > 0.0:
					$FinalTrainLight.visible = true;
					time_since_train_move_start += delta;
					
					var current_distance = $Player.position.distance_to($FinalTrainLight.position);
					
					
					if (current_distance < distance_last_frame):
						print("kill")
						
					$FinalTrainLight.position.z -= delta*train_kill_velocity;
						
					distance_last_frame = current_distance;
				pass
			pass
	pass
