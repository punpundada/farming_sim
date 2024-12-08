class_name Rock
extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
const STONE = preload("res://scenes/objects/rocks/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(_on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func _on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	self.material.set("shader_parameter/shake_intensity",0.3)
	await  self.get_tree().create_timer(1).timeout
	self.material.set("shader_parameter/shake_intensity",0.0)
	

func on_max_damage_reached() -> void:
	self.call_deferred("load_stone_scene")
	self.queue_free()

func load_stone_scene()->void:
	var stone_scene = STONE.instantiate() as Sprite2D
	stone_scene.global_position = self.global_position
	self.get_parent().add_child(stone_scene)
