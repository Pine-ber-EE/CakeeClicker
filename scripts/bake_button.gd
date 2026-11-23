extends Node2D
signal Cclick
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer = timer + delta
	#print (timer)
	if($Button.is_hovered()):
		timer = 0
		scale.x=1.1
		scale.y=1.1
	else:
		if timer > 0.2:
			scale.x=1
			scale.y=1
		


func _on_button_pressed() -> void:
	pass # Replace with function body.
	Cclick.emit()


func _on_button_button_down() -> void:
	$Sprite2D.modulate = Color(0.8,0.8,0.8,1)
	
	pass # Replace with function body.


func _on_button_button_up() -> void:
	
	$Sprite2D.modulate = Color(1,1,1,1)
	pass # Replace with function body.
