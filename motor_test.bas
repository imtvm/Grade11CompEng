symbol rightMotorF = B.7
symbol rightMotorB = B.6
symbol leftMotorF = C.0
symbol leftMotorB = C.1

init:
	low rightMotorF
	low rightMotorB
	low leftMotorF
	low leftMotorB
	pause 5000
	goto main
	
main:
	high rightMotorF
	pause 2000
	low rightMotorF
	pause 1000
	high leftMotorF
	pause 2000
	low leftMotorF
	pause 1000
	high rightMotorF
	high leftMotorF
	pause 2000
	low rightMotorF
	low leftMotorF
	pause 1000
	goto main