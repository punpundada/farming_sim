extends NodeState

@export var player:Player
@export var animated_sprite:AnimatedSprite2D

enum Direction { UP, DOWN, LEFT, RIGHT }

var animation_states = {
	Direction.UP: "idle_back",
	Direction.DOWN: "idle_front",
	Direction.LEFT: "idle_left",
	Direction.RIGHT: "idle_right"
}

var direction:Vector2

func _on_process(_delta : float) -> void:
	if player == null:
		print("no player available")
		return
	direction = GameInputEvents.movement_input()
	direction = player.player_direction
	
	
	if direction == Vector2.UP:
		animated_sprite.play(animation_states[Direction.UP])
	elif direction== Vector2.DOWN:
		animated_sprite.play(animation_states[Direction.DOWN])
	elif direction == Vector2.LEFT:
		animated_sprite.play(animation_states[Direction.LEFT])
	elif direction == Vector2.RIGHT:
		animated_sprite.play(animation_states[Direction.RIGHT])
	else:
		animated_sprite.play(animation_states[Direction.DOWN])
		


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite.stop()
