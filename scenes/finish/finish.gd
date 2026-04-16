extends Node2D

func onBodyEntered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player detected!")
		get_tree().reload_current_scene()
