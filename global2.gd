extends Node

var timemin = 0
var timesec = 0
var saveMin = 0
var saveSec = 0
var mindif2 = 0
var secdif2 = 0
var mindif = 0
var secdif = 0
var seccalc = 0
var seccalc2 = 0

func getMindif():
	return mindif
func setMindif(i):
	mindif = i
func getMindif2():
	return mindif2
func setMindif2(i):
	mindif2 = i
func getSecdif():
	return secdif
func setSecdif(i):
	secdif = i
func getSecdif2():
	return secdif2
func setSecdif2(i):
	secdif2 = i
func saveDif():
	if get_tree().paused == false:
		saveMin = global.mins
		saveSec = global.secs
		if saveSec >= 60:
			saveSec = saveSec - 60
			saveMin = saveMin + 1
func calcDif():
	seccalc = timesec
	seccalc2 = saveSec
	mindif = saveMin - timemin
	secdif = saveSec - timesec
	mindif2 = mindif2 + mindif
	secdif2 = secdif2 + secdif
	if secdif < 0:
		var seccalc3 = 0
		seccalc3 = timesec - saveSec
		saveSec = 0
		if saveMin > 0:
			saveMin = saveMin - 1
			saveSec = 60
			saveSec = saveSec - seccalc3
		saveMin = 0
	if secdif >= 60:
		secdif = secdif - 60
		mindif = mindif + 1
	if secdif2 >= 60:
		secdif2 = secdif2 - 60
		mindif2 = mindif2 + 1
func saveTime():
	if get_tree().paused == true:
		timemin = global.mins
		timesec = global.secs
		if timesec >= 60:
			timesec = timesec - 60
			timemin = timemin + 1
	else:
		pass

func _physics_process(delta):
	if get_tree().current_scene.name == "TitleScreen":
		global.setDeadresetamount(0)
		global.setDeaths(5)
		global.setDeadcoins(5)
		global.setScore(0)
		global.setScore2(0)
		global.setSaveluckcoin(0)
		global.setSlc(0)
		global.setDeadcoinprice(global.getDeadresetamount() + global.getDeaths())
	if get_tree().current_scene.name == "DeathMenu":
		global.setDeadresetamount(0)
		global.setDeaths(5)
		global.setDeadcoins(5)
		global.setScore(0)
		global.setScore2(0)
		global.setSaveluckcoin(0)
		global.setSlc(0)
		global.setDeadcoinprice(global.getDeadresetamount() + global.getDeaths())
	if get_tree().current_scene.name == "EndMenu":
		global.setDeadresetamount(0)
		global.setDeaths(5)
		global.setDeadcoins(5)
		global.setScore(0)
		global.setScore2(0)
		global.setSaveluckcoin(0)
		global.setSlc(0)
		global.setDeadcoinprice(global.getDeadresetamount() + global.getDeaths())
