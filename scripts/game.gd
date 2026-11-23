extends Node2D

var milk = 0
var cow = 1
var mt = 0 #milk per second per cow
var mc = 1 #milk per click per cow
var tempmc = 1

var eggs = 0
var chickens = 1
var et = 0 #eggs per second per chicken
var ec = 1 #eggs per click per chicken
var tempec = 1

var wheat = 1000
var wt = 1 #wheat per second
var wc = 1 #harvest wheat per click
var wheatStorage = 10
var wheatInStorage = 0

var cake = 0
var autobaker = 0
var autoclickeramt = 0
var autoclicker = 0

var timer = 0
var shaketimer = 9
var shaketimes = 0
var feedtimer = 10

var donate = 0

var shakeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$diaryButton.Dclick.connect(diaryClicked)
	$wheatButton.Wclick.connect(wheatClicked)
	$bakeButton.Cclick.connect(cakeClicked)
	
	$autoclicker.autoclick.connect(autoclick1)
	$autoclicker2.autoclick.connect(autoclick2)
	$autoclicker3.autoclick.connect(autoclick3)
	$autoclicker4.autoclick.connect(autoclick4)
	$autoclicker.notAutoclick.connect(notAutoclick1)
	$autoclicker2.notAutoclick.connect(notAutoclick2)
	$autoclicker3.notAutoclick.connect(notAutoclick3)
	$autoclicker4.notAutoclick.connect(notAutoclick4)
	
	setShopD()
	setShopW()
	setShopG()
	
	click()
	click2()
	click3()
	click4()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer= timer+delta
	feedtimer = feedtimer + delta
	if(timer>=1):
		timer = 0
		tick()
		
	checkClick()
	print("mouse:"+str($autoclicker.mousedown))
	#print("enter:"+str($autoclicker.entered))

		
	if feedtimer<10:
		tempec = ec*5
		tempmc=mc*5
		$background/CPUParticles2D.show()
		$background/Sprite2D.show()
	else:
		$background/CPUParticles2D.hide()
		$background/Sprite2D.hide()
		tempec = ec
		tempmc = mc
	
	if(wheat<3 || eggs<2 || milk<1):
		$bakeButton.modulate.a=0.5
	else:
		$bakeButton.modulate.a=1
	
	$wheatButton/Label.text = "Ready to harvest: "+str(wheatInStorage)+"/"+str(wheatStorage)

	#update other scenes w/ variables
	$counters/eggCounter.amount = eggs
	$counters/milkCounter.amount = milk
	$counters/wheatCounter.amount = wheat
	$counters/cakeCounter.amount = cake
	
	$clickamt.text = str(autoclickeramt)+"/4 autoclickers owned"
	
	setShopD2()
	setShopW2()
	setShopG2()
	
	shaketimerfunc()
	shaketimer=shaketimer+delta*20
	
func diaryClicked():
	milk = milk + (cow*tempmc)/1
	eggs = eggs + (chickens*tempec)/1
	#print("diaryClicked")
	#print("eggs: "+ str(eggs)+ " milk: " + str(milk))

func wheatClicked():
	if wheatInStorage<=0:	
		shake()
	elif(wheatInStorage<wc/1):
		wheat = wheat + wheatInStorage
		wheatInStorage=0
		#print("wheatClicked")
		#print("wheat: "+str(wheat))
	else:
		wheat = wheat + wc/1
		wheatInStorage=wheatInStorage-wc/1
		#print("wheatClicked")
		#print("wheat: "+str(wheat))
	
func cakeClicked():
	#3 wheat, 2 egg, 1 milk = cake
	if(wheat<3 || eggs<2 || milk<1):
		#print("u broke")
		shake()
		#shakeLabel=$wheatButton/Label
	else:
		cake=cake+1
		wheat = wheat-3
		eggs = eggs -2
		milk = milk - 1
	
func tick():
	milk = milk + (cow*mt)/1
	eggs = eggs + (chickens*et)/1
	#print(str(wheat + wt/1))
	if (wheatInStorage + wt/1) > wheatStorage:
		wheatInStorage=wheatStorage
	else: 
		wheatInStorage = wheatInStorage + wt/1
	for i in range(autobaker):
		if!(wheat<3 || eggs<2 || milk<1):
			cake=cake+1
			wheat = wheat-3
			eggs = eggs -2
			milk = milk - 1
	#print("onetick")
	#print("eggs: "+ str(eggs)+ " milk: " + str(milk)+ " wheat: "+str(wheat))
	#print("wheat: "+str(wheat)+" wheatInStorage: "+str(wheatInStorage)+" wheatStorage: "+str(wheatStorage))
	


func autoclick1():
	autoclicker = 1
func autoclick2():
	autoclicker = 2
func autoclick3():
	autoclicker = 3
func autoclick4():
	autoclicker = 4

func notAutoclick1():
	if autoclicker == 1:
		autoclicker = 0
func notAutoclick2():
	if autoclicker == 2:
		autoclicker = 0
func notAutoclick3():
	if autoclicker == 3:
		autoclicker = 0
func notAutoclick4():
	if autoclicker == 4:
		autoclicker = 0

func checkClick():
	if autoclicker == 1:
		$autoclicker.otherconditions=true
		$autoclicker2.otherconditions=false
		$autoclicker3.otherconditions=false
		$autoclicker4.otherconditions=false
	elif autoclicker == 2:
		$autoclicker.otherconditions=false
		$autoclicker2.otherconditions=true
		$autoclicker3.otherconditions=false
		$autoclicker4.otherconditions=false
	elif autoclicker == 3:
		$autoclicker.otherconditions=false
		$autoclicker2.otherconditions=false
		$autoclicker3.otherconditions=true
		$autoclicker4.otherconditions=false
	elif autoclicker == 4:
		$autoclicker.otherconditions=false
		$autoclicker2.otherconditions=false
		$autoclicker3.otherconditions=false
		$autoclicker4.otherconditions=true
	else:
		$autoclicker.otherconditions=true
		$autoclicker2.otherconditions=true
		$autoclicker3.otherconditions=true
		$autoclicker4.otherconditions=true
		
	if autoclickeramt==0:
		$autoclicker.hide()
		$autoclicker2.hide()
		$autoclicker3.hide()
		$autoclicker4.hide()
		$clickamt.hide()
	elif autoclickeramt==1:
		$autoclicker.show()
		$autoclicker2.hide()
		$autoclicker3.hide()
		$autoclicker4.hide()
		$clickamt.show()
	elif autoclickeramt==2:
		$autoclicker.show()
		$autoclicker2.show()
		$autoclicker3.hide()
		$autoclicker4.hide()
		$clickamt.show()
	elif autoclickeramt==3:
		$autoclicker.show()
		$autoclicker2.show()
		$autoclicker3.show()
		$autoclicker4.hide()
		$clickamt.show()
	elif autoclickeramt==4:
		$autoclicker.show()
		$autoclicker2.show()
		$autoclicker3.show()
		$autoclicker4.show()
		$clickamt.show()
		
	#Input.warp_mouse($autoclicker.clicker.position)

func click():
	while true:
		if $autoclicker.visible:
			var a = InputEventMouseButton.new()
			a.button_index = MOUSE_BUTTON_LEFT
			a.position = $autoclicker.position
			a.pressed = true
			Input.parse_input_event(a)
			
			await get_tree().process_frame
			
			a.pressed = false
			Input.parse_input_event(a)
func click2():
	while true:
		if $autoclicker2.visible:
			var a = InputEventMouseButton.new()
			a.button_index = MOUSE_BUTTON_LEFT
			a.position = $autoclicker.position
			a.pressed = true
			Input.parse_input_event(a)
			
			await get_tree().process_frame
			
			a.pressed = false
			Input.parse_input_event(a)
func click3():
	while true:
		if $autoclicker3.visible:
			var a = InputEventMouseButton.new()
			a.button_index = MOUSE_BUTTON_LEFT
			a.position = $autoclicker.position
			a.pressed = true
			Input.parse_input_event(a)
			
			await get_tree().process_frame
			
			a.pressed = false
			Input.parse_input_event(a)
func click4():
	while true:
		if $autoclicker4.visible:
			var a = InputEventMouseButton.new()
			a.button_index = MOUSE_BUTTON_LEFT
			a.position = $autoclicker.position
			a.pressed = true
			Input.parse_input_event(a)
			
			await get_tree().process_frame
			
			a.pressed = false
			Input.parse_input_event(a)





func buy(itemID):
	#print("hi")
	#print(itemID)
	#itemID 1 is plus a chicken
	#2 is plus cow
	#3 is vacinnes
	#4 is feed
	if(itemID == 1):
		chickens=chickens+1
		cake = cake-$"TabContainer/diaryShop/GridContainer/+1chicken".cost
		#print("bought!")
	elif(itemID==2):
		cow=cow+1
		cake = cake-$"TabContainer/diaryShop/GridContainer/+1cow".cost
	elif(itemID==3):
		ec=ec+1
		mc=mc+1
		cake=cake-$TabContainer/diaryShop/GridContainer/vacinnes.cost
	elif(itemID==4):
		if feedtimer>=10:
			feedtimer = 0 #add later
		else:
			feedtimer = feedtimer - 10
		wheat = wheat-$TabContainer/diaryShop/GridContainer/feed.cost
	#5 is gmo
	#6 is scythe
	#7 is moreland
	#8 is bettersoil
	elif(itemID==5):
		wt=wt+1
		cake=cake-$TabContainer/gardenShop/GridContainer/gmo.cost
	elif(itemID==6):
		wc = wheat+10
		cake=cake-$TabContainer/gardenShop/GridContainer/scythe.cost
	elif(itemID==7):
		wheatStorage = wheatStorage + 5
		cake=cake-$TabContainer/gardenShop/GridContainer/moreland.cost
	elif(itemID==8):
		pass
	
	#9 is autobake
	#10 is fasterbake
	#11 is autoclicker
	#12 is letthemeatcake
	elif(itemID==9):
		autobaker = autobaker+ 1
		cake=cake-$TabContainer/generalShop/GridContainer/autobake.cost
	elif(itemID==10):
		autobaker = autobaker+ 5
		cake=cake-$TabContainer/generalShop/GridContainer/fasterbake.cost
	elif(itemID==11):
		autoclickeramt = autoclickeramt + 1
		cake=cake-$TabContainer/generalShop/GridContainer/autoclicker.cost
	elif(itemID==12):
		cake=cake-$TabContainer/generalShop/GridContainer/letthemeatcake.cost
		donate = donate + 250
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
	$"TabContainer/diaryShop/GridContainer/vacinnes".cost=35
	$"TabContainer/diaryShop/GridContainer/vacinnes".buy.connect(buy.bind(3))
	
	$"TabContainer/diaryShop/GridContainer/feed".maxAmt=1
	$"TabContainer/diaryShop/GridContainer/feed".cost=100
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
	$TabContainer/generalShop/GridContainer/autobake.cost=50
	$TabContainer/generalShop/GridContainer/autobake.buy.connect(buy.bind(9))
	
	$TabContainer/generalShop/GridContainer/fasterbake.maxAmt=1
	$TabContainer/generalShop/GridContainer/fasterbake.cost = 150
	$TabContainer/generalShop/GridContainer/fasterbake.buy.connect(buy.bind(10))
	
	$TabContainer/generalShop/GridContainer/autoclicker.maxAmt=10
	$TabContainer/generalShop/GridContainer/autoclicker.cost=200
	$TabContainer/generalShop/GridContainer/autoclicker.buy.connect(buy.bind(11))
	
	$"TabContainer/generalShop/GridContainer/letthemeatcake".maxAmt=10
	$"TabContainer/generalShop/GridContainer/letthemeatcake".cost=250
	$"TabContainer/generalShop/GridContainer/letthemeatcake".buy.connect(buy.bind(12))


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
	
	$"TabContainer/generalShop/GridContainer/letthemeatcake".money=cake
