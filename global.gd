extends Node

var deaths = 0
var deadcoins = 5
var deadresetamount = 0
var deadcoinprice = deadresetamount + 5
var mins = 0
var secs = 0
var pause = false
var time_start = 0
var time_now = 0
var game_time
var lastScene = null
var score2 = 0
var score = 0
var seccalc
var mincalc
var saveluckcoin = 0
var slc = 0
var slc2 = 0
var phealth = 0
var bosshealth = 50
var ptimeout = false
var boss_left = false
var boss_right = false
var boss_dead = false
var dead = 0
var dead_complete = false

func getDeadComplete():
	return dead_complete
func setDeadComplete(i):
	dead_complete = i
func getDead():
	return dead
func setDead(i):
	dead = i
func getBossright():
	return boss_right
func setBossright(i):
	boss_right = i
func getBossleft():
	return boss_left
func setBossleft(i):
	boss_left = i
func getBossdead():
	return boss_dead
func Bossdead():
	boss_dead = true
func Bossalive():
	boss_dead = false
func getPtimeout():
	return ptimeout
func activatePtimeout():
	ptimeout = true
func deactivatePtimeout():
	ptimeout = false
func getBosshealth():
	return bosshealth
func setBosshealth(i):
	bosshealth = i
func calcPhealth():
	phealth = score / 10
	phealth = phealth + saveluckcoin
	if phealth < 1:
		phealth = 1
func getPhealth():
	return phealth
func setPhealth(i):
	phealth = i
func saveSlc2():
	slc2 = saveluckcoin
func getSlc2():
	return slc2
func setSlc2(i):
	slc2 = i
func getSlc():
	return slc
func setSlc(i):
	slc = i
func getSaveluckcoin():
	return saveluckcoin
func setSaveluckcoin(i):
	saveluckcoin = i
func getDeaths():
	return deaths
func setDeaths(i):
	deaths = i
func getDeadcoins():
	return deadcoins
func setDeadcoins(i):
	deadcoins = i
func getDeadresetamount():
	return deadresetamount
func setDeadresetamount(i):
	deadresetamount = i
func getDeadcoinprice():
	deadcoinprice = deadresetamount + 5
	return deadcoinprice
func setDeadcoinprice(i):
	deadcoinprice = i
func getScore():
	return score
func setScore(setscore):
	score = setscore
func getScene():
	return lastScene
func setScene(scene):
	lastScene = scene
func scene_changed():
	score2 = score
func slc_save():
	slc = saveluckcoin
func getScore2():
	return score2
func setScore2(setscore2):
	score2 = setscore2
func timer_pause():
	if pause == true:
		set_process(false)
	elif pause == false:
		set_process(true)

func _physics_process(delta):
	if bosshealth < 0:
		bosshealth = 0
	if Input.is_action_just_pressed("ui_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	seccalc = seconds
	mincalc = minutes
	minutes = minutes - global2.mindif2
	seconds = seconds - global2.secdif2
	if minutes < 0:
		minutes = 0
	if seconds < 0 and minutes >= 1:
		var seccalc2 = 0
		seccalc2 = global2.secdif2 - seccalc
		seconds = 0
		minutes = minutes - 1
		seconds = 60
		seconds = seconds - seccalc2
		if minutes < 0:
			minutes = 0
	if minutes < 0:
		minutes = 0
	if seconds >= 60:
		seconds = seconds - 60
		minutes = minutes + 1
	mins = minutes
	secs = seconds
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	game_time = str_elapsed
	if get_tree().current_scene.name == "TitleScreen":
		deadcoinprice = deadresetamount + deaths
		deadresetamount = 0
		deaths = 5
		deadcoins = 5
		score = 0
		score2 = 0
		saveluckcoin = 0
		slc = 0
	if get_tree().current_scene.name == "DeathMenu":
		deadresetamount = 0
		deaths = 5
		deadcoins = 5
		score = 0
		score2 = 0
		saveluckcoin = 0
		slc = 0
		deadcoinprice = deadresetamount + deaths
	if get_tree().current_scene.name == "EndMenu":
		deadresetamount = 0
		deaths = 5
		deadcoins = 5
		score = 0
		score2 = 0
		saveluckcoin = 0
		slc = 0
		deadcoinprice = deadresetamount + deaths
	if score <= 0:
		score = 0
	if score2 <= 0:
		score2 = 0
