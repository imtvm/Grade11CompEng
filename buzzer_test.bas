symbol buzzer = B.4
symbol leds = C.3

init:
	low buzzer
	low leds
	gosub playSong
	pause 3000
	goto main
main:
	high leds
	pause 500
	low leds
	pause 500
	goto main

playSong:
	tune buzzer, 4,($65,$65,$C0,$C0,$43,$42,$65,$65,$C0,$C0)
	return