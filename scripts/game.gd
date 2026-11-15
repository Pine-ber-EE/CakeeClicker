extends Node2D

var milk = 0
var cow = 1
var mt = 0 #milk per second per cow
var mc = 1 #milk per click per cow

var eggs = 0
var chickens = 1
var et = 0 #eggs per second per chicken
var ec = 1 #eggs per click per chicken

var wheat = 0
var wt = 0 #wheat per second
var wc = 1 #wheat per click

var cake = 0
var autobaker = 0

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$diaryButton.Dclick.connect(diaryClicked)
	$wheatButton.Wclick.connect(wheatClicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer= timer+delta
	if(timer>=1):
		timer = 0
		tick()
	
func diaryClicked():
	milk = milk + (cow*mc)/1
	eggs = eggs + (chickens*ec)/1
	print("diaryClicked")
	print("eggs: "+ str(eggs)+ " milk: " + str(milk))

func wheatClicked():
	wheat = wheat + wc/1
	print("wheatClicked")
	print("wheat: "+str(wheat))
	
func tick():
	milk = milk + (cow*mt)/1
	eggs = eggs + (chickens*et)/1
	wheat = wheat + wt/1
	print("onetick")
	print("eggs: "+ str(eggs)+ " milk: " + str(milk)+ " wheat: "+str(wheat))
	
func buy(itemID):
	#itemID 1 is plus a chicken
	if(itemID == 1):
		chickens=chickens+1
		
