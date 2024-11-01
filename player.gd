extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var actionable_finder: Area2D = $Direction/ActionableFinder

func _ready() -> void:
	$Label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	# Movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x <0:
			$Direction.rotation = deg_to_rad(-180)
		else:
			$Direction.rotation = 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
	# Dialogue
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		$Label.visible = false
		if actionables.size() > 0:
			actionables[0].action()
			return
		
	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

func _physics_process(delta: float) -> void:
	##TODO have a prompt to talk
		
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Handle jump.
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	move_and_slide()


func _on_actionable_finder_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Actionable"):
		$Label.visible = true


func _on_actionable_finder_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("Actionable"):
		#await get_tree().create_timer(0.1).timeout
		$Label.visible = false
