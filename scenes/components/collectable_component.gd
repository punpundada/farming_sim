class_name  CollectableComponent
extends Area2D

@export var collectable_name:String
@onready var timer: Timer = $Timer
@export var wait_time_sec:float = 1.0

func _ready() -> void:
	timer.wait_time=wait_time_sec

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		var collision_shape = self.get_child(1)
		disable_collision_shape(collision_shape)
		timer.start()

func disable_collision_shape(collision_shape: Node2D)->void:
	if collision_shape is CollisionShape2D:
		collision_shape.disabled = true

func _on_timer_timeout() -> void:
	print("collected")
	self.get_parent().queue_free()
