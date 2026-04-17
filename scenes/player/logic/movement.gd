extends RigidBody2D

const speed: float = 40.0

@export var gravityFlow: String = "Down"
var gravity: Vector2 = Vector2(0, 6.4 * gravityMultiplier)
var gravityMultiplier: float = 200.0
var isOnFloor: bool = false
var canFlipGravity: bool = true
var gravityVertical: bool = false
var gravityHorizontal: bool = false
var lockedXPosition: float
var lockedYPosition: float

func _ready() -> void:
	gravityFlow = "Down"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
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
			lockedYPosition = position.y
			gravity = Vector2(0, 3.6 * gravityMultiplier)
			isOnFloor = false
			canFlipGravity = false
	
			if !isOnFloor:
				position.y = lockedYPosition
	
		elif Input.is_action_just_pressed("ui_up"):
			lockedYPosition = position.y
			gravity = Vector2(0, -3.6 * gravityMultiplier)
			isOnFloor = false
			canFlipGravity = false
	
			if !isOnFloor:
				position.y = lockedYPosition
	
		elif Input.is_action_just_pressed("ui_left"):
			lockedXPosition = position.x
			gravity = Vector2(-6.4 * gravityMultiplier, 0)
			isOnFloor = false
			canFlipGravity = false
	
			if !isOnFloor:
				position.x = lockedXPosition
	
		elif Input.is_action_just_pressed("ui_right"):
			lockedXPosition = position.x
			gravity = Vector2(6.4 * gravityMultiplier, 0)
			isOnFloor = false
			canFlipGravity = false
	
			if !isOnFloor:
				position.x = lockedXPosition

	# handle movement
	if Input.is_action_just_pressed("Left") and isOnFloor:
		match gravityFlow:
			"Down":
				global_position.x -= speed
			"Up": 
				global_position.x += speed
			"Left":
				global_position.y += speed
			"Right":
				global_position.y -= speed

	if Input.is_action_just_pressed("Right") and isOnFloor:
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
		isOnFloor = true
		canFlipGravity = true
		gravityVertical = false
		gravityHorizontal = false
		print("On the floor!")

func onBodyExited(body: Node) -> void:
		isOnFloor = false
		print("Not on the floor!")
