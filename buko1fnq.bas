symbol servoWheel = B.2


init:
	servo servoWheel, 75
	goto main
	pause 500

main:
	servopos servoWheel, 225
	
