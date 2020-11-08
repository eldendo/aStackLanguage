10 print chr$(147);
20 print "     +----------------------------+"
30 print "     !      a stack language      !"
40 print "     ! (c)2020 ir. marc dendooven !"
50 print "     !    version for chapter 5   !"
60 print "     +----------------------------+"

100 rem *** change parameters here ***
110 dss=100: rem datastack size
120 dis=5: rem dictionary size

200 gosub 1000: rem initialise

300 rem repl
310 input li$: rem read
320 gosub 2400: rem execute
330 print ms$;:gosub 4000: rem print
340 goto 310 : rem loop

500 rem push v on datastack
505 if er then return
510 if dp>=dss then ms$="stack overflow":er=-1:return
520 d(dp)=v:dp=dp+1
530 return

600 rem pull v from datastack
605 if er then return
610 if dp <= 0 then ms$="stack underflow":er=-1:return
620 dp=dp-1:v=d(dp)
630 return

700 rem add item to dictionary
705 if er then return
710 if df >= dis then ms$="dictionary full":er=-1:return
720 di$(df)=i$:dv$(df)=li$:df=df+1
730 return

1000 rem initialise
1010 dim d(dss-1),di$(dis-1),dv$(dis-1)
1015 dp=0:df=0: rem stacks and pointers
1020 return

2000 rem interpreter
2004 ms$="ok":er=0
2005 if df=0 then 2010
2006 for i = df-1 to 0 step -1
2007 if i$=di$(i) then li$=dv$(i)+" "+li$:return
2008 next i
2010 if i$="bye" then end
2020 if i$=".s" then gosub 4000:return
2030 if i$="." then gosub 600: print v:return
2040 if i$="+" then gosub 600:v1=v:gosub 600:v=v+v1:gosub 500:return
2050 if i$="-" then gosub 600:v1=v:gosub 600:v=v-v1:gosub 500:return
2060 if i$="*" then gosub 600:v1=v:gosub 600:v=v*v1:gosub 500:return
2070 if i$="/" then gosub 600:v1=v:gosub 600:v=v/v1:gosub 500:return

2041 if i$="=" then gosub 600:v1=v:gosub 600:v=v=v1:gosub 500:return
2042 if i$="<" then gosub 600:v1=v:gosub 600:v=v<v1:gosub 500:return
2043 if i$=">" then gosub 600:v1=v:gosub 600:v=v>v1:gosub 500:return
2044 if i$="and" then gosub 600:v1=v:gosub 600:v=v and v1:gosub 500:return
2045 if i$="or" then gosub 600:v1=v:gosub 600:v=v or v1:gosub 500:return
2046 if i$="not" then gosub 600:v=not v:gosub 500:return

2080 if i$="dup" then gosub 600:gosub500:gosub 500:return
2090 if i$="drop" then gosub 600:return
2100 if i$="swap" then 3000
2110 if i$="over" then 3100
2130 if i$="rot" then 3200
2140 if i$="emit" then gosub 600: print chr$(v);: return
2150 if i$="cr" then print: return
2160 if i$="poke" then gosub 600:v1=v:gosub 600:poke v,v1:return
2170 if i$="peek" then gosub 600:v=peek(v):gosub 500: return
2180 if i$="!" then gosub 2500:gosub 700:li$="":return
2190 if i$=".d" then 3300
2200 if i$="then" then 3400
2210 if i$="reset" then run
2220 if i$="."+chr$(34) then 5000
2230 if i$="clear" then dp=0: return
2300 v=val(i$): gosub 500:return

2400 rem evaluate line
2401 if li$="" then return
2410 gosub 2500
2420 gosub 2000
2430 goto 2400

2500 rem split line
2505 if li$="" then ms$="missing key":er=-1:return
2510 i$ = "" 
2515 l=len(li$)
2520 for i = 1 to l
2530 c$ = mid$(li$,i,1)
2540 if c$<>" " then i$=i$+c$: next i
2550 for i = i to l
2560 if mid$(li$,i,1)=" " then next i
2570 li$=right$(li$,l-i+1)
2580 return

3000 rem swap 
3010 gosub 600:v1=v:gosub 600:v2=v
3020 v=v1:gosub 500:v=v2:gosub 500
3030 return

3100 rem over
3110 gosub 600:v2=v:gosub 700:v1=v
3120 v=v2:gosub 500:v=v1:gosub 500
3130 returns

3200 rem rot
3210 gosub 600:v3=v:gosub 600:v2=v:gosub 600:v1=v
3220 v=v2:gosub 500:v=v3:gosub 500:v=v1:gosub 500
3230 return

3300 rem show dictionary
3305 if df<=0 then print"dictionary empty":return
3310 for i=0 to df-1
3320 print di$(i),dv$(i)
3330 next
3340 return

3400 rem then [commands] {else [commands]} end 
3401 rem test for emty li$ not good... should give error or execute last command
3410 gosub 600
3420 if v<>0 then 3500
3429 rem false branch 
3430 gosub 2500
3440 if i$="end" or li$="" then return
3450 if i$<>"else" then 3430 
3460 gosub 2500
3470 if i$="end" or li$="" then return
3480 gosub 2000
3490 goto 3460
3499 rem true branch
3500 gosub 2500
3510 if i$="end" or li$="" then return
3520 if i$<>"else" then gosub 2000:goto 3500 
3530 gosub 2500
3540 if i$="end" or li$=""then return
3550 goto 3530

4000 rem show datastack
4005 if dp <= 0 then print " <empty>":return
4007 print" <";
4010 for i=0 to dp-1 
4030 print d(i);
4040 next
4050 print "_top >"
4060 return

5000 rem printstring
5005 l=len(li$)
5010 for i = 1 to l
5020 c$ = mid$(li$,i,1)
5030 if c$=chr$(34) then 5050
5035 print c$;
5040 next i:li$="":return
5050 for i=i+1 to l : if mid$(li$,i,1)=" " then next i
5060 li$=right$(li$,l-i+1)
5070 return

