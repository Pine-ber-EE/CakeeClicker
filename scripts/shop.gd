extends Node2D
signal buy
var amt = 0
var maxAmt
var avaliable = false
var cost = 50
var money = 0 #remember to make game.gd update this


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # Replace with function body.
	if amt>=maxAmt:
		avaliable = false
	elif money<cost:
		avaliable = false
	else:
		avaliable = true
		
	if avaliable:
		modulate.a=1
		$Label2.show()
	else:
		modulate.a=0.5
		$Label2.hide()


func _on_button_pressed() -> void:
	if avaliable:
		buy.emit()
	else:
		print("no!")
		pass #set brightness when i add that
