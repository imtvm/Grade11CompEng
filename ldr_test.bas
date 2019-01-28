'setfreq m16


symbol ldrL = C.2
symbol ldrR = B.5

symbol lValue = b0
symbol rValue = b1
symbol percent = b2

symbol leftSignal = C.3 'Assigns the left turn signal leds to pin C.3
symbol rightSignal = B.3 'Assings the right turn signal leds to pn B.3

symbol servoWheel = B.2 'Assigns the servo wheel to pin C.5
symbol servoPosition = b3 'Assigns the servoPosition variable to the b3 variable

init:
	'servo servoWheel, 150
	
	low leftSignal 'Sets the leftSignal variable pin state to low
	low rightSignal 'Sets the rightSignal variable pin state to low
	
	goto main

main:

	readadc ldrL, lValue
	readadc ldrR, rValue
	
	if lValue > rValue then 'Checks to see if lValue is greater then rValue
		
		'sertxd("LLLLLLLLL", cr, lf)
		
		percent = lValue - rValue 'Assigns the difference of the lValue and rValue to the percent variable
		percent = percent * 100 / 255 'Turns the percent varibale into a percentage value
		
		if percent > 10 then 'Checks to see if the value of percent is greater then 10
			high leftSignal
			low rightSignal
			'servopos servoWheel, 100 'Turn Left
			sertxd("L ",#percent, cr, lf)
		else 'If it returns false then the following code is run
			'servopos servoWheel, 150 'Move Forward
			low leftSignal
			low rightSignal
			sertxd("Fwd ", #percent, cr, lf)
		end if 'Ends the if statment
	
	elseif rValue > lValue then 'Checks to see if the rValue is greater then the lValue
		
		'sertxd("RRRRRRRRR", cr, lf)
		
		percent = rValue - lValue 'Assigns the difference of rValue and lValue to the percent variable
		percent = percent * 100 / 255 'Turns the percent variable into a percentage value
		
		if percent > 10 then 'Checks to see if the value of percent is greater then 10
			high rightSignal
			low leftSignal
			'servopos servoWheel, 200 'Turn Right
			sertxd("R ", #percent, cr, lf)
		else 'If it returns false then the following code is run
			'servopos servoWheel, 150 'Move Forward
			low rightSignal
			low leftSignal
			sertxd("Fwd ", #percent, cr, lf)
		end if 'Ends the if statment
	
	else 'If neither of the other options are true it defaults to the following code:
		'servopos servoWheel, 150
		low rightSignal
		low leftSignal
		sertxd("Fwd ", #percent, cr, lf)
	endif 'Ends the if statement

	goto main