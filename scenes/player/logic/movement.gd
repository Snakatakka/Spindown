extends RigidBody2D

const speed: float = 200.0
var gravity: Vector2 = Vector2(0, 6.4 * gravityMultiplier)
var gravityMultiplier: float = 200.0
var isOnFloor: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# apply gravity every frame
	apply_central_force(gravity)
	
	# if we're on the floor, the gravity is lessened in order to allow the player to actually be able to move
	# if we're floating through the air, the gravity is increased so that you don't fall like a balloon
	
	# softlock prevention
	# also it makes debugging easier lol
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	
	# handle basic gravity flipping
	if Input.is_action_just_pressed("ui_down"):
		gravity = Vector2(0, 3.6 * gravityMultiplier)
		isOnFloor = false
		rotation = 0.0
		print("Gravity Switched!")
	elif Input.is_action_just_pressed("ui_up"):
		gravity = Vector2(0, -3.6 * gravityMultiplier)
		isOnFloor = false
		rotation = 180.0
		print("Gravity Switched!")
	elif Input.is_action_just_pressed("ui_left"):
		gravity = Vector2(-6.4 * gravityMultiplier, 0)
		isOnFloor = false
		rotation = 90.0
		print("Gravity Switched!")
	elif Input.is_action_just_pressed("ui_right"):
		gravity = Vector2(6.4 * gravityMultiplier, 0)
		isOnFloor = false
		rotation = 270.0
		print("Gravity Switched!")
	
	# handle movement
	var direction := Input.get_axis("Left", "Right")
	if !isOnFloor:
		if direction:
			apply_central_force(Vector2(direction * speed, 0))
			print(direction)

# detects whether or not we're on the floor
func onBodyEntered(body: Node) -> void:
	if body.is_in_group("floor"):
		isOnFloor = true
		print("On the floor!")

func onBodyExited(body: Node) -> void:
	if body.is_in_group("floor"):
		isOnFloor = false
		print("Not on the floor!")
