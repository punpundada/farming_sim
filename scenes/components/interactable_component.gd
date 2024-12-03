class_name InteractableComponent
extends Area2D

signal interactable_activated
signal ineractable_deactivated


func _on_body_entered(body: Node2D) -> void:
	interactable_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	ineractable_deactivated.emit()
