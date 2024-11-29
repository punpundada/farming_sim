extends NodeState

@export var player:Player
@export var animated_sprite:AnimatedSprite2D
@export var speed := 50


var animation_states = {
	GameInputEvents.Direction.UP: "walk_back",
	GameInputEvents.Direction.DOWN: "walk_front",
	GameInputEvents.Direction.LEFT: "walk_left",
	GameInputEvents.Direction.RIGHT: "walk_right"
}


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction := GameInputEvents.movement_input()
	
	if direction == Vector2.UP:
		animated_sprite.play(animation_states[GameInputEvents.Direction.UP])
	elif direction == Vector2.DOWN:
		animated_sprite.play(animation_states[GameInputEvents.Direction.DOWN])
	elif direction == Vector2.RIGHT:
		animated_sprite.play(animation_states[GameInputEvents.Direction.RIGHT])	
	elif direction == Vector2.LEFT:
		animated_sprite.play(animation_states[GameInputEvents.Direction.LEFT])
		
	if direction != Vector2.ZERO:
		player.player_direction = direction
		
	player.velocity = direction * speed
	player.move_and_slide()
		
		
func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()
