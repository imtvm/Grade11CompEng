'Servo Controller
'Author: Tyler Vergis-Mayo
'Code Completed On: 08/12/2016
'Written for the Picaxe-08m2 Microcontroller

'SERIAL INFORMATION 
symbol serInPin = C.2 'Sets the serInPin var to pin C.2
symbol command = b0 'Sets the command variable to b0

'SERVO INFORMATION
symbol servoWheel = C.1 'Sets the servo wheel to pin C.1
symbol fwd = 170 'Sets the fwd position to 150
symbol left = 140 'Sets the fwd position to 100
symbol right = 220 'Sets the fwd position to 200

init: 'Only run once right when the MCU is given power

	servo servoWheel, fwd 'Initilizes the servo to the forward position
	
	'goto main 'Goes to the beginning of the main proceadure
	
main: 'Main proceadure that is looped infinitly

	command = 0 'Sets the command varibale to 0
	
	serin [250], serInPin, T4800_4, command 'Checks for a serial input and assigns the data to the command var
	
	if command = 1 then 'Checks to see if the command var is equal to 1
		servopos servoWheel, left 'sets the servo wheel to the left position
	else if command = 2 then 'Checks to see if the command var is equal to 2
		servopos servoWheel, right 'sets the servo wheel to the left position
	else if command = 3 then 'Checks to see if the command var is equal to 3
		servopos servoWheel, fwd 'sets the servo wheel to the left position
	else 'If none are true then the MCU will do nothing
	
	end if 'Ends the if statement
	
	goto main 'Goes to the beginning of the main proceadure
	
'LAWS OF ROBOTICS

'A robot may not injure a human being or, through inaction, allow a human being to come to harm
'A robot must obey orders given it by human beings except where such orders would conflict with the First Law
'A robot must protect its own existence as long as such protection does not conflict with the First or Second Law

'To be implemented in case of emergency
