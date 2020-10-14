10 print chr$(147);
20 print "     +----------------------------+"
30 print "     !         edforth64          !"
40 print "     ! (c)2020 ir. marc dendooven !"
50 print "     +----------------------------+"

100 rem *** change parameters here ***
110 dss=5: rem data stack size

200 gosub 1000: rem initialise

300 rem repl
310 input i$: rem read
320 gosub 2000: rem execute
330 print ms$;:gosub 4000: rem print
340 goto 310 : rem loop

500 rem push v on data stack
505 if er then return
510 if dp>=dss then ms$="stack overflow":er=-1:return
520 d(dp)=v:dp=dp+1
530 return

600 rem pull v from data stack
605 if er then return
610 if dp <= 0 then ms$="stack underflow":er=-1:return
620 dp=dp-1:v=d(dp)
630 return

//700 rem copy v from top of stack
//705 if er then return
//710 if dp <= 0 then ms$="stack underflow":er=-1:return
//720 v = d(dp-1)
//730 return

1000 rem initialise
1010 dim d(dss-1):dp=0:rem data stack and pointer
1020 return

2000 rem interpreter
2005 ms$="ok":er=0
2010 if i$="bye" then end
2020 if i$=".s" then gosub 4000:return
2030 if i$="." then gosub 600: print v:return
2040 if i$="+" then gosub 600:v1=v:gosub 600:v=v+v1:gosub 500:return
2050 if i$="-" then gosub 600:v1=v:gosub 600:v=v-v1:gosub 500:return
2060 if i$="*" then gosub 600:v1=v:gosub 600:v=v*v1:gosub 500:return
2070 if i$="/" then gosub 600:v1=v:gosub 600:v=v/v1:gosub 500:return
2080 if i$="dup" then gosub 600:gosub500:gosub 500:return
2090 if i$="drop" then gosub 600:return
2100 if i$="swap" then 3000
2110 if i$="over" then 3100
2130 if i$="rot" then 3200
2140 if i$="emit" then gosub 600: print chr$(v): return
2150 if i$="cr" then print: return
2160 if i$="poke" then gosub 600:v1=v:gosub 600:poke v,v1:return
2170 if i$="peek" then gosub 600:v=peek(v):gosub 500: return
2190 v=val(i$): gosub 500:return

3000 rem swap 
3010 gosub 600:v1=v:gosub 600:v2=v
3020 v=v1:gosub 500:v=v2:gosub 500
3030 return

3100 rem over
3110 gosub 600:v2=v:gosub 700:v1=v
3120 v=v2:gosub 500:v=v1:gosub 500
3130 return

3200 rem rot
3210 gosub 600:v3=v:gosub 600:v2=v:gosub 600:v1=v
3220 v=v2:gosub 500:v=v3:gosub 500:v=v1:gosub 500
3230 return

4000 rem show datastack
4005 if dp <= 0 then print " <empty>":return
4007 print" <";
4010 for i=0 to dp-1 
4030 print d(i);
4040 next
4050 print "_top >"
4060 return

### implement showstack
### men spreekt van de datastack en de returnstack


