symbol rightMotorF = B.7 'Assigns the right motor forward control to pin B.7
symbol rightMotorB = B.6 'Assigns the right motor reverse control to pin B.6
symbol leftMotorF = C.0 'Assigns the left motor forward control to pin C.0
symbol leftMotorB = C.1 'Assigns the left motor reverse control to pin C.1
symbol speedControlLeft = C.5 'Assigns the speed controller to pin B.1
symbol speedControlRight = B.1 'Assigns the speed controller to pin B.1
symbol x = b0

init:
	pwmout speedControlLeft, 49, 199
	pwmout speedControlRight, 49, 199
	high rightMotorF 'Sets the rightMotorF variable pin state to low
	high leftMotorF 'Sets the leftMotorF variable pin state to low
	low rightMotorB 'Sets the rightMotorB variable pin state to low
	low leftMotorB 'Sets the leftMotorB variable pin state to low
	
	goto main
	
main:
	low rightMotorF
	low leftMotorF
	pwmout speedControlLeft, 49, 199
	pwmout speedControlRight, 49, 199
	high rightMotorF
	high leftMotorF
	pause 1000
	low rightMotorF
	low leftMotorF
	pwmout speedControlLeft, 49, 99
	pwmout speedControlRight, 49, 99
	high rightMotorF
	high leftMotorF
	pause 1000
	goto main