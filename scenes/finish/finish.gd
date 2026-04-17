extends Node2D

# TODO: implement level select and make it so that this number isn't just one
@export var levelCount: int = 1

func onBodyEntered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player detected!")
		get_tree().change_scene_to_file("res://scenes/levels/game/".path_join(str(levelCount + 1) + ".tscn"))
