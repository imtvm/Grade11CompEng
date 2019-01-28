symbol dp = c.0
symbol lp = c.1
symbol cp = c.2

init:
low dp
low lp
low cp

main:

low dp
pulsout cp, 1
high dp
pulsout cp, 1
low dp
pulsout cp, 1
high dp
pulsout cp, 1
low dp
pulsout cp, 1
high dp
pulsout cp, 1
low dp
pulsout cp, 1
high dp
pulsout cp, 1

pulsout lp, 1
