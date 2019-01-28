symbol servoWheel = B.2

init:
	servo servoWheel, 150
	pause 500
	goto main
	
main:
	servopos servoWheel, 200 'left 100 'fwd 150 'right 200
	pause 500
	servopos servoWheel, 150
	pause 500
	servopos servoWheel, 100
	pause 500
	goto main