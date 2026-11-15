extends Node2D

var amount = 0 #remember to update from game.gd
var numString = "000"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	processNum(amount)
	print(amount)
	amount=amount+10000000

	$Label.text="x "+numString
	
func processNum(a):
	if a<1000:
		numString = str(a/1)
	elif a<10000:
		numString = str(a/1000)+"."+str((a%1000)/100)+"k"
	elif a<1000000: #1,000,000
		numString = str(a/1000)+"k"
	elif a<10000000:
		numString = str(a/1000000)+"."+str((a%1000000)/100000)+"M"
	elif a<1000000000:
		numString = str(a/1000000)+"M"
	elif a<10000000000:
		numString = str(a/1000000000)+"."+str((a%1000000000)/100000000)+"B"
	elif a<1000000000000:
		numString = str(a/1000000000)+"B"
	#trillion
	elif a<10000000000000:
		numString = str(a/1000000000000)+"."+str((a%1000000000000)/100000000000)+"T"
	elif a<1000000000000000:
		numString = str(a/1000000000000)+"T"
	#quadrilion
	elif a<10000000000000000:
		numString = str(a/1000000000000000)+"."+str((a%1000000000000000)/100000000000000)+"q"
	elif a<1000000000000000000:
		numString = str(a/1000000000000000)+"q"
