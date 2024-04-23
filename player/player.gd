extends CharacterBody3D

<<<<<<< HEAD

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
=======
var ray_origin = Vector3()
var ray_target = Vector3()

# mouse input
func _input(event):
	#get cam
	var cam = get_parent().get_node("Camera3D")
	
	if event is InputEventMouseMotion:
		ray_origin = cam.project_ray_origin(get_viewport().get_mouse_position())
		ray_target = cam.project_ray_normal(get_viewport().get_mouse_position())*1000

func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	var parameters = PhysicsRayQueryParameters3D.create(ray_origin,ray_target,1,[self])
	var ray = space_state.intersect_ray(parameters)
	
	# get angle and update rotation
	if ray:
		var ray_collision_point =  ray.position
		var object_position = get_translation()
		ray_collision_point = object_position-ray_collision_point
		var angle = Vector2(ray_collision_point.x,ray_collision_point.z).angle_to(object_position.x,object_position.z)
		self.set_rotation(Vector3(0,angle,0))
>>>>>>> 29ae365 (dans first commit with nonsense files)
