extends Node2D

var drag = false
var entered = false
var mousedown = false
var otherconditions = true
signal autoclick
signal notAutoclick

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	enter()
	if(Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)):
		mousedown=true
	else:
		mousedown=false
	if mousedown&&entered&&otherconditions:
		global_position=get_global_mouse_position()
		#autoclick.emit()
	else:
		pass
		#notAutoclick.emit()
		
	if entered:
		autoclick.emit()
	else:
		notAutoclick.emit()
	#print(entered)


func _on_area_2d_mouse_entered() -> void:
	pass
	#entered = true


func _on_area_2d_mouse_exited() -> void:
	pass
	#if !mousedown:
		#entered = false

func enter():
	var a = abs(get_global_mouse_position().x - position.x)
	var b = abs(get_global_mouse_position().y - position.y)
	if a<50 && b<50:
		entered = true
	else:
		if !mousedown:
			entered = false
