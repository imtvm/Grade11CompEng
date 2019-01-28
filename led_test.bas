symbol leftSignal = C.3
symbol rightSignal = B.3

init:
	low leftSignal
	low rightSignal
	pause 5000
	goto main
	
main:
	high leftSignal
	pause 2000
	low leftSignal
	pause 1000
	high rightSignal
	pause 2000
	low rightSignal
	pause 1000
	high leftSignal
	high rightSignal
	pause 2000
	low leftSignal
	low rightSignal
	pause 1000
	goto main