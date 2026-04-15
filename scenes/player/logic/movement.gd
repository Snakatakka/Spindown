extends RigidBody2D

const speed: float = 300.0
var gravity: Vector2 = Vector2(0, 6.4 * speed)
var isOnFloor: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lock_rotation = true
	
	#if isOnFloor:
		#apply_central_force(gravity / speed)
	#else:
	apply_central_force(gravity)
	
	if Input.is_action_just_pressed("ui_down"):
		gravity = Vector2(0, 6.4 * speed)
		print("Gravity Switched!")
	elif Input.is_action_just_pressed("ui_up"):
		gravity = Vector2(0, -6.4 * speed)
		print("Gravity Switched!")
	elif Input.is_action_just_pressed("ui_left"):
		gravity = Vector2(-6.4 * speed, 0)
		print("Gravity Switched!")
	elif Input.is_action_just_pressed("ui_right"):
		gravity = Vector2(6.4 * speed, 0)
		print("Gravity Switched!")
		
	var direction := Input.get_axis("Left", "Right")
	
	if direction:
		apply_central_force(Vector2((direction * speed), 0))
		print(direction)
	
	# if direction:
		# position.x = direction * speed
	# else:
		# position.x = move_toward(position.x, 0, speed)


func onArea2DBodyEntered(body: Node2D) -> void:
	isOnFloor = true
	print("YOURE IN!")

func onArea2DBodyExited(body: Node2D) -> void:
	isOnFloor = false
	print("YOURE IN!")
