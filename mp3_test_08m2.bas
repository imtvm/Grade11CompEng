setfreq m16

symbol mp3Out = C.0
symbol btIn = C.4
symbol command = b0
symbol track = w2

init:
	command = 0
	goto main

main:
	gosub checkInput
	goto main

checkInput:
	
	command = 0
	
	serin [250], btIn, T9600_16, command
	
	if command > 0 and command < 10 then
		track = command
		gosub playSong
	else if command = 11 then
		gosub stopPlayback
	else if command = 12 then
		gosub volumeUp
	else if command = 13 then
		gosub volumeDown
	else
	
	end if
	
	return
	
playSong:
	serout mp3Out, T9600_16, ($7E, $FF, $06, $0F, $00, $01, track, $EF)
	return
stopPlayback:
	serout mp3Out, T9600_16, ($7E, $FF, $06, $16, $00, $01, track, $EF)
	return
volumeUp:
	serout mp3Out, T9600_16, ($7E $FF $06 $04 $00 $00 $00 $EF)
	return
volumeDown:
	serout mp3Out, T9600_16, ($7E $FF $06 $05 $00 $00 $00 $EF)
	return