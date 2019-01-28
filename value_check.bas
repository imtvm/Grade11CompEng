symbol ldrL = C.2
symbol ldrR = B.5
symbol lValue = b0
symbol rValue = b1

main:
	readadc ldrL, lValue
	readadc ldrR, rValue
	sertxd("Right: ", #rValue, " Left: ", #lValue, cr, lf)
	pause 1000
	goto main