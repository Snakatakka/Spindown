extends RigidBody2D

var gravity: Vector2 = Vector2(0, -6.4)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	apply_central_force(gravity)
	
	if Input.is_action_just_pressed("ui_accept"):
		gravity = Vector2(0, 6.4)
	
