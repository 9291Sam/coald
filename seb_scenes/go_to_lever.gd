extends Interactible3D

func _interact():
	get_tree().change_scene_to_file("res://seb_scenes/lever/lever_pull.tscn")
	#self.CanInteract = false
