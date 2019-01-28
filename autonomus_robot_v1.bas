'Autonomus Track Following Car
'Author: Tyler Vergis-Mayo
'Code Completed On: dd/mm/2016
'Written for the Picaxe-20M2 Microcontroller

'MOTOR INFORMATION:
symbol rightMotorF = B.7 'Assigns the right motor forward control to pin B.7
symbol rightMotorB = B.6 'Assigns the right motor reverse control to pin B.6
symbol leftMotorF = C.0 'Assigns the left motor forward control to pin C.0
symbol leftMotorB = C.1 'Assigns the left motor reverse control to pin C.1
symbol speedControl = C.2 'Assigns the speed controller to pin B.1

'SERIAL OUT INFORMATION
symbol serOutPin = B.2
symbol left = 1
symbol right = 2
symbol fwd = 3

'TURN SIGNAL INFORMATION
symbol leftSignal = C.4 'Assigns the left turn signal leds to pin C.3
symbol rightSignal = B.3 'Assings the right turn signal leds to pn B.3

'BUZZER INFORMATION
symbol buzzer = B.4 'Assigns the buzzer to the pin B.4
symbol speed = 4 'The Speed that the song is played

'LEDR INFORMATION
symbol ldrL = C.3 'Assigns the left LDR to the pin C.2
symbol ldrR = B.5 'Assigns the left LDR to the pin B.5

'MATH AND LOGICS INFORMATION
symbol lValue = b1 'Assigns the lValue variable to the b1 variable
symbol rValue = b2 'Assigns the rValue variable to the b2 variable
symbol percent = b3 'Assigns a percentage to the variable b3 variable

init: 'Only run once right when the MCU is given power

	pwmout speedControl, 99, 199
	
	high serOutPin

	high rightMotorF 'Sets the rightMotorF variable pin state to low
	high leftMotorF 'Sets the leftMotorF variable pin state to low
	low rightMotorB 'Sets the rightMotorB variable pin state to low
	low leftMotorB 'Sets the leftMotorB variable pin state to low
	
	low leftSignal 'Sets the leftSignal variable pin state to low
	low rightSignal 'Sets the rightSignal variable pin state to low
	
	low buzzer 'Sets the buzzer to low
	
	gosub playBuzzer 'Calls the playBuzzer sub-proceadure
	
	pause 2000 'Pauses the internal clock for 5 seconds before moving on to the next line of code
	
	low buzzer 'Sets the buzzer to low
	
	goto motorInit 'Moves to the main proceadure
	
motorInit:
	
	pwmduty speedControl, 512
	
	goto main

main: 'Main proceadure that is looped infinitly

	gosub readAndCompare 'Calls the compareValues sub-proceadure
	
	goto main 'Returns the code to the beginning of the main function
    
readAndCompare: 'Compares the values of the LDRs and makes the nessacry adjustments to course

	readadc ldrL, lValue 'Reads the left LDR and assigns the incoming value to the lValue variable
	readadc ldrR, rValue 'Reads the right LDR and assigns the incoming value to the rValue variable
	
	if lValue > rValue then 'Checks to see if lValue is greater then rValue
		
		percent = lValue - rValue 'Assigns the difference of the lValue and rValue to the percent variable
		percent = percent * 100 / 255 'Turns the percent varibale into a percentage value
		
		if percent > 10 then 'Checks to see if the value of percent is greater then 10
			gosub turnLeft 'Calls the turnLeft sub
			sertxd("LEFT: ", #percent, cr, lf) 'Sends the percent value to the serial terminal
		else 'If it returns false then the following code is run
			sertxd("FWD: ", #percent, cr, lf) 'Sends the percent value to the serial terminal
			gosub moveForward 'Calls the moveForward sub
		end if 'Ends the if statment
	
	elseif rValue > lValue then 'Checks to see if the rValue is greater then the lValue
		
		percent = rValue - lValue 'Assigns the difference of rValue and lValue to the percent variable
		percent = percent * 100 / 255 'Turns the percent variable into a percentage value
		
		if percent > 1 then 'Checks to see if the value of percent is greater then 10
			gosub turnRight 'Calls  the turnRight sub
			sertxd("RIGHT: ", #percent, cr, lf) 'Sends the percent value to the serial terminal
		else 'If it returns false then the following code is run
			sertxd("FWD: ", #percent, cr, lf) 'Sends the percent value to the serial terminal
			gosub moveForward 'Calls the moveForward sub
		end if 'Ends the if statment
	
	else 'If neither of the other options are true it defaults to the following code:
		gosub moveForward 'Calls the moveForward sub
		sertxd("FWD: ", #percent, cr, lf) 'Sends the percent value to the serial terminal
	endif 'Ends the if statement

	percent = 0 'Sets the percent variable to 0 once it is done comparing the values

	return 'Returns from this sub-proceadure back to the proceadure that called it

turnLeft: 'Controls the servo so that the vehicle can turn left
	
	serout serOutPin, T4800_4, (left) 'Sends a serial output to tell the 08M2 to turn the servo a specific way
	
	pwmduty speedControl, 400
	
	high rightMotorF 'Turns on the right motor forwards control
	high leftMotorF 'Turns on the left motor forwards control
	
	high leftSignal 'Turns on the left turning signal
	
	return 'Returns from this sub-proceadure back to the proceadure that called it
	
turnRight: 'Controls the servo so that the vehicle can turn right
	
	serout serOutPin, T4800_4, (right) 'Send a serial output to tell the 08M2 to turn the servo a specific way
	
	pwmduty speedControl, 400
	
	high rightMotorF 'Turns on the right motor forwards control
	high leftMotorF 'Turns on the left motor forwards control
	
	high rightSignal 'Turns on the right turning signal
	
	return 'Returns from this sub-proceadure back to the proceadure that called it
	
moveForward: 'Controls the motors to move straight

	serout serOutPin, T4800_4, (fwd) 'Sends a serial output to tell the 08M2 to turn the servo a specific way
	
	pwmduty speedControl, 512
	
	'high rightMotorF 'Turns on the right motor forwards control
	'high leftMotorF 'Turns on the left motor forwards control
	
	gosub signalsOff 'Turns off all the turning signals
	
	return 'Returns from this sub-proceadure back to the proceadure that called it
	
signalsOff: 'Turns off all turning signals

	low leftSignal 'Turns off the left turn signal
	low rightSignal 'Turns off the right turn signal
	
	return 'Returns from this sub-proceadure back to the proceadure that called it
	
stall: 'Stalls the vehicle to stop it from moving any more

	low rightMotorF 'Turns off the right motor forwards control
	low rightMotorB 'Turns off the right motor back control
	low leftMotorF 'Turns off the left motor forwards control
	low leftMotorB 'Turns off hte left motor backwards control
	
	return 'Returns from this sub-proceadure back to the proceadure that called it
	
playBuzzer: 'Plays the startup music
	
	tune buzzer, speed, ($65,$65,$C0,$C0,$43,$42,$65,$65,$C0,$C0) 'Plays the song when called
	
	return 'Returns from this sub-proceadure back to the proceadure that called it

'LAWS OF ROBOTICS

'A robot may not injure a human being or, through inaction, allow a human being to come to harm
'A robot must obey orders given it by human beings except where such orders would conflict with the First Law
'A robot must protect its own existence as long as such protection does not conflict with the First or Second Law

'To be implemented in case of emergency