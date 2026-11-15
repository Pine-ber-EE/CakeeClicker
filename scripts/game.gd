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
	
	setShopD()
	setShopW()
	setShopG()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer= timer+delta
	if(timer>=1):
		timer = 0
		tick()
	
	#update other scenes w/ variables
	$counters/eggCounter.amount = eggs
	$counters/milkCounter.amount = milk
	$counters/wheatCounter.amount = wheat
	
	setShopD2()
	setShopW2()
	setShopG2()
	
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
	print("hi")
	print(itemID)
	#itemID 1 is plus a chicken
	if(itemID == 1):
		chickens=chickens+1
		print("bought!")
		
func setShopD():
	$"TabContainer/diaryShop/GridContainer/+1chicken".maxAmt=999
	$"TabContainer/diaryShop/GridContainer/+1chicken".cost=10
	$"TabContainer/diaryShop/GridContainer/+1chicken".buy.connect(buy.bind(1))
	
	$"TabContainer/diaryShop/GridContainer/+1cow".maxAmt=999
	$"TabContainer/diaryShop/GridContainer/+1cow".cost=15
	$"TabContainer/diaryShop/GridContainer/+1cow".buy.connect(buy.bind(2))
	
	$"TabContainer/diaryShop/GridContainer/vacinnes".maxAmt=3
	$"TabContainer/diaryShop/GridContainer/vacinnes".cost=50
	$"TabContainer/diaryShop/GridContainer/vacinnes".buy.connect(buy.bind(3))
	
	$"TabContainer/diaryShop/GridContainer/feed".maxAmt=1
	$"TabContainer/diaryShop/GridContainer/feed".maxAmt=100
	$"TabContainer/diaryShop/GridContainer/feed".buy.connect(buy.bind(4))

func setShopW():
	$TabContainer/gardenShop/GridContainer/gmo.maxAmt=3
	$TabContainer/gardenShop/GridContainer/gmo.cost=5
	$TabContainer/gardenShop/GridContainer/gmo.buy.connect(buy.bind(5))
	
	$TabContainer/gardenShop/GridContainer/scythe.maxAmt=1
	$TabContainer/gardenShop/GridContainer/scythe.cost=10
	$TabContainer/gardenShop/GridContainer/scythe.buy.connect(buy.bind(6))
	
	$TabContainer/gardenShop/GridContainer/moreland.maxAmt=999
	$TabContainer/gardenShop/GridContainer/moreland.cost=6
	$TabContainer/gardenShop/GridContainer/moreland.buy.connect(buy.bind(7))
	
	$TabContainer/gardenShop/GridContainer/bettersoil.maxAmt=999
	$TabContainer/gardenShop/GridContainer/bettersoil.buy.connect(buy.bind(8))
	
func setShopG():
	$TabContainer/generalShop/GridContainer/autobake.maxAmt=1
	$TabContainer/generalShop/GridContainer/autobake.buy.connect(buy.bind(9))
	
	$TabContainer/generalShop/GridContainer/fasterbake.maxAmt=1
	$TabContainer/generalShop/GridContainer/fasterbake.buy.connect(buy.bind(10))
	
	$TabContainer/generalShop/GridContainer/autoclicker.maxAmt=10
	$TabContainer/generalShop/GridContainer/autoclicker.buy.connect(buy.bind(11))
	
	$"TabContainer/generalShop/GridContainer/autoclicker++".maxAmt=10
	$"TabContainer/generalShop/GridContainer/autoclicker++".buy.connect(buy.bind(12))


func setShopD2():
	$"TabContainer/diaryShop/GridContainer/+1chicken".money=cake
	
	$"TabContainer/diaryShop/GridContainer/+1cow".money=cake
	
	$"TabContainer/diaryShop/GridContainer/vacinnes".money=cake
	
	$"TabContainer/diaryShop/GridContainer/feed".money=wheat

func setShopW2():
	$TabContainer/gardenShop/GridContainer/gmo.money=cake
	
	$TabContainer/gardenShop/GridContainer/scythe.money=cake
	
	$TabContainer/gardenShop/GridContainer/moreland.money=cake
	
	$TabContainer/gardenShop/GridContainer/bettersoil.money=cake
	
func setShopG2():
	$TabContainer/generalShop/GridContainer/autobake.money=cake
	
	$TabContainer/generalShop/GridContainer/fasterbake.money=cake
	
	$TabContainer/generalShop/GridContainer/autoclicker.money=cake
	
	$"TabContainer/generalShop/GridContainer/autoclicker++".money=cake
