extends RigidBody2D

const speed: float = 2.0

@export var gravityFlow: String = "Down"
var gravity: Vector2 = Vector2(0, 6.4 * gravityMultiplier)
var gravityMultiplier: float = 200.0
var isOnFloor: bool = false
var canFlipGravity: bool = true
var gravityVertical: bool = false
var gravityHorizontal: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x = round(position.x/speed) * speed
	position.y = round(position.y/speed) * speed
	
	# apply gravity every frame
	if !((Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right")) and isOnFloor):
		apply_central_force(gravity)
	
	# softlock prevention
	# also it makes debugging easier lol
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
	
	# handle basic gravity flipping
	if canFlipGravity:
		if Input.is_action_just_pressed("ui_down"):
			gravity = Vector2(0, 3.6 * gravityMultiplier)
			isOnFloor = false
			canFlipGravity = false
			print("Gravity Switched!")
		elif Input.is_action_just_pressed("ui_up"):
			gravity = Vector2(0, -3.6 * gravityMultiplier)
			isOnFloor = false
			canFlipGravity = false
			print("Gravity Switched!")
		elif Input.is_action_just_pressed("ui_left"):
			gravity = Vector2(-6.4 * gravityMultiplier, 0)
			isOnFloor = false
			canFlipGravity = false
			print("Gravity Switched!")
		elif Input.is_action_just_pressed("ui_right"):
			gravity = Vector2(6.4 * gravityMultiplier, 0)
			isOnFloor = false
			canFlipGravity = false
			print("Gravity Switched!")

	# handle movement
	if Input.is_action_pressed("Left") and isOnFloor:
		match gravityFlow:
			"Down":
				global_position.x -= speed
			"Up": 
				global_position.x += speed
			"Left":
				global_position.y += speed
			"Right":
				global_position.y -= speed

	if Input.is_action_pressed("Right") and isOnFloor:
		match gravityFlow:
			"Down":
				global_position.x += speed
			"Up": 
				global_position.x -= speed
			"Left":
				global_position.y -= speed
			"Right":
				global_position.y += speed

# detects whether or not we're on the floor
func onBodyEntered(body: Node) -> void:
	if body.is_in_group("floor"):
		isOnFloor = true
		canFlipGravity = true
		gravityVertical = false
		gravityHorizontal = false
		print("On the floor!")

func onBodyExited(body: Node) -> void:
	if body.is_in_group("floor"):
		isOnFloor = false
		print("Not on the floor!")
