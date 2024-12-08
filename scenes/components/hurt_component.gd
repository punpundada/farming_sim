class_name HurtComponent
extends Area2D

@export var tool:DataTypes.Tools = DataTypes.Tools.None

signal hurt(hit_damage:int)


func _on_area_entered(area: Area2D) -> void:
	if area is HitComponent:
		if tool == area.current_tool:
			hurt.emit(area.hit_damage)
