extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: InteractableComponent = $InteractableComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable_component.interactable_activated.connect(on_ineractable_activated)
	interactable_component.ineractable_deactivated.connect(on_interactable_deactivated)
	self.collision_layer=1
	
func on_ineractable_activated()->void:
	collision_shape.disabled = true
	animated_sprite.play("open_door")
	self.collision_layer =2
func on_interactable_deactivated()->void:
	collision_shape.disabled = false
	animated_sprite.play("close_door")
	self.collision_layer =1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
