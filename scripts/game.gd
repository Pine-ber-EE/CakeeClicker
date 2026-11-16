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
var shaketimer = 9
var shaketimes = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$diaryButton.Dclick.connect(diaryClicked)
	$wheatButton.Wclick.connect(wheatClicked)
	$bakeButton.Cclick.connect(cakeClicked)
	
	setShopD()
	setShopW()
	setShopG()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer= timer+delta
	if(timer>=1):
		timer = 0
		tick()
	
	if(wheat<3 || eggs<2 || milk<1):
		$bakeButton.modulate.a=0.5
	else:
		$bakeButton.modulate.a=1
	
	#update other scenes w/ variables
	$counters/eggCounter.amount = eggs
	$counters/milkCounter.amount = milk
	$counters/wheatCounter.amount = wheat
	$counters/cakeCounter.amount = cake
	
	setShopD2()
	setShopW2()
	setShopG2()
	
	shaketimerfunc()
	shaketimer=shaketimer+delta*20
	
func diaryClicked():
	milk = milk + (cow*mc)/1
	eggs = eggs + (chickens*ec)/1
	print("diaryClicked")
	print("eggs: "+ str(eggs)+ " milk: " + str(milk))

func wheatClicked():
	wheat = wheat + wc/1
	print("wheatClicked")
	print("wheat: "+str(wheat))
	
func cakeClicked():
	#3 wheat, 2 egg, 1 milk = cake
	if(wheat<3 || eggs<2 || milk<1):
		print("u broke")
		shake()
	else:
		cake=cake+1
		wheat = wheat-3
		eggs = eggs -2
		milk = milk - 1
	
func tick():
	milk = milk + (cow*mt)/1
	eggs = eggs + (chickens*et)/1
	wheat = wheat + wt/1
	for i in range(autobaker):
		cakeClicked()
	print("onetick")
	print("eggs: "+ str(eggs)+ " milk: " + str(milk)+ " wheat: "+str(wheat))
	









func buy(itemID):
	print("hi")
	print(itemID)
	#itemID 1 is plus a chicken
	#2 is plus cow
	#3 is vacinnes
	#4 is feed
	if(itemID == 1):
		chickens=chickens+1
		cake = cake-$"TabContainer/diaryShop/GridContainer/+1chicken".cost
		print("bought!")
	elif(itemID==2):
		cow=cow+1
		cake = $"TabContainer/diaryShop/GridContainer/+1cow".cost
	elif(itemID==3):
		ec=ec+1
		mc=mc+1
		cake=cake-$TabContainer/diaryShop/GridContainer/vacinnes.cost
	elif(itemID==4):
		pass #add later
		wheat = wheat-$TabContainer/diaryShop/GridContainer/feed.cost
	#5 is gmo
	#6 is scythe
	#7 is moreland
	#8 is bettersoil
	elif(itemID==5):
		wt=wt+1
		cake=cake-$TabContainer/gardenShop/GridContainer/gmo.cost
	elif(itemID==6):
		pass
	elif(itemID==7):
		pass
	elif(itemID==8):
		pass
	
	#9 is autobake
	#10 is fasterbake
	#11 is autoclicker
	#12 is autoclicker++
	elif(itemID==9):
		autobaker = 1
	elif(itemID==10):
		autobaker = 5
	elif(itemID==11):
		pass
	elif(itemID==12):
		pass
		











func shake():
	shaketimer=0
	shaketimes=10

func shaketimerfunc():
	if(shaketimer<1):
		if(shaketimes >=10):
			$Camera2D.position = Vector2(randi_range(-5,5), randi_range(-10,10))
			shaketimes = shaketimes -1
	elif(shaketimer<2):
		if(shaketimes >=9):
			$Camera2D.position = Vector2(randi_range(-5,5), randi_range(-10,10))
			shaketimes = shaketimes -1
	elif(shaketimer<3):
		if(shaketimes >=8):
			$Camera2D.position = Vector2(randi_range(-5,5), randi_range(-10,10))
			shaketimes = shaketimes -1
	elif(shaketimer<4):
		if(shaketimes >=7):
			$Camera2D.position = Vector2(randi_range(-5,5), randi_range(-10,10))
			shaketimes = shaketimes -1
	elif(shaketimer<4):
		if(shaketimes >=6):
			$Camera2D.position = Vector2(randi_range(-5,5), randi_range(-10,10))
			shaketimes = shaketimes -1
	elif(shaketimer<5):
		if(shaketimes >=5):
			$Camera2D.position = Vector2(0, 0)
			shaketimes = shaketimes -1

















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
	$TabContainer/gardenShop/GridContainer/moreland.cost=2
	$TabContainer/gardenShop/GridContainer/moreland.buy.connect(buy.bind(7))
	
	$TabContainer/gardenShop/GridContainer/bettersoil.maxAmt=999
	$TabContainer/gardenShop/GridContainer/bettersoil.maxAmt=5
	$TabContainer/gardenShop/GridContainer/bettersoil.buy.connect(buy.bind(8))
	
func setShopG():
	$TabContainer/generalShop/GridContainer/autobake.maxAmt=1
	$TabContainer/generalShop/GridContainer/autobake.cost=100
	$TabContainer/generalShop/GridContainer/autobake.buy.connect(buy.bind(9))
	
	$TabContainer/generalShop/GridContainer/fasterbake.maxAmt=1
	$TabContainer/generalShop/GridContainer/fasterbake.cost = 150
	$TabContainer/generalShop/GridContainer/fasterbake.buy.connect(buy.bind(10))
	
	$TabContainer/generalShop/GridContainer/autoclicker.maxAmt=10
	$TabContainer/generalShop/GridContainer/autoclicker.maxAmt=200
	$TabContainer/generalShop/GridContainer/autoclicker.buy.connect(buy.bind(11))
	
	$"TabContainer/generalShop/GridContainer/autoclicker++".maxAmt=10
	$"TabContainer/generalShop/GridContainer/autoclicker++".cost=250
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
