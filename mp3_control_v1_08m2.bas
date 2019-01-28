'Bluetooth Controlled Audio Player
'Author: Tyler Vergis-Mayo
'Code Completed On: 25/11/2016
'Written for the Picaxe-08m2 Microcontroller

'FREQUENCY INFORMATION
setfreq m16 'Sets the clock speed to 16Mhz

'MP3 INFORMATION
symbol mp3Out = C.0 'Sets the mp3Out variable to the C.0 pin

'BLUETOOTH INFORMATION
symbol btIn = C.4 'Sets the btIn variable to the C.4 pin
symbol command = b0 'Sets the command variable to b0

'TRACK INFORMATION
symbol track = b2 'Sets the track variable to b2

init: 'Only run once right when the MCU is given power

	command = 0 'Sets the command variable to 0
	
	goto main 'Goes to the main proceadure

main: 'Main proceadure that is looped infinitly

	gosub checkInput 'Calls the checkInput sub proceadure
	
	goto main 'Goes to the main sub proceadure

checkInput: 'Checks to see what the input is and then plays the correct song/preform the right command
	
	command = 0 'Sets the command variable to 0
	
	serin [250], btIn, T9600_16, command 'Looks for serial input on the btIn pin
	
	if command > 0 and command < 10 then 'Checks to see if the input is one of the specifed tracks
		track = command 'Sets the track number to the int thats stored into the command
		gosub playSong 'Calls the playSong sub proceadure to change the song
	else if command = 11 then 'Checks to see if command is equal to 11
		gosub stopPlayback 'Calls the stopPlayback sub proceadure
	else if command = 12 then 'Checks to see if command is equal to 11
		gosub volumeUp 'Calls the volumeUp sub proceadure
	else if command = 13 then 'Checks to see if command is equal to 11
		gosub volumeDown 'Calls the volumeDown sub proceadure
	else 'If none of the above returns true then it will do nothing
	
	end if 'Ends the if statement
	
	return 'Returns to the proceadure that called it
	
playSong: 'Plays a specific song

	serout mp3Out, T9600_16, ($7E, $FF, $06, $0F, $00, $01, track, $EF) 'Sends serial information out
	
	return 'Returns to the proceadure that called it
	
stopPlayback: 'Stops the playback

	serout mp3Out, T9600_16, ($7E, $FF, $06, $16, $00, $01, track, $EF) 'Sends serial information out
	
	return 'Returns to the proceadure that called it
	
volumeUp: 'Turns the volume up

	serout mp3Out, T9600_16, ($7E $FF $06 $04 $00 $00 $00 $EF) 'Sends serial information out
	
	return 'Returns to the proceadure that called it
	
volumeDown: 'Turns the volume down

	serout mp3Out, T9600_16, ($7E $FF $06 $05 $00 $00 $00 $EF) 'Sends serial information out
	
	return 'Returns to the proceadure that called it
	
'LAWS OF ROBOTICS

'A robot may not injure a human being or, through inaction, allow a human being to come to harm
'A robot must obey orders given it by human beings except where such orders would conflict with the First Law
'A robot must protect its own existence as long as such protection does not conflict with the First or Second Law

'To be implemented in case of emergency