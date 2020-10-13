# edFORTH64

This project is a tutorial how to write a FORTH alike implementation on a c64.
This project is only just started... so there is no finished product yet. It is an ongoing text whereto I will contribute whenever I see fit.

** WARNING: I never used Forth ** so I am making this application while I am learning. So don't use this text as a reference nor as a FORTH manual... This is pure a fun project.

This project is part of my **bare commodore 64** project.

> The **bare commodore64** project aims to build programs on the c64 without any existing tools: only **BASIC V2** and manually translated machine code are allowed, except for tools that are build by the **bare commodore 64** project itself. So no existing compilers and helping tools, nor any form of cross-development. Since I am not a masochist, I allow the use of a commodore emulator, and the use of a modern editor to write code. (But the only thing you can do is to copy-paste the code from the editor in the emulator, so emulating typing things in. No transfers of files from PC to the c64 or it's drive)

## Introduction

**BASIC V2** wasn't made for the c64, it is the same basic that was present on the PET computers. So there wasn't any support for the (at the time) powerful graphics and sound features. They could off course be used by accessing the hardware directly by the means of accessing the memory mapped hardware by the basic instructions to access the memory (peek and poke) or by writing machine code programs. The BASIC interpreter has not much possibilities for abstraction, so we should or extend the basic interpreter, or write a complete new language. I chose the latter. Since the limitations of **bare commodore 64** project, it should be very simple. So I decided to make a tiny version of Forth. If you don't know Forth, look at [this page](https://skilldrick.github.io/easyforth/) for an interactive introduction. 
In this text I will build the application chapter by chapter and finish each chapter with a working program which can be executed on a c64. You can type it in or you can copy-paste it in an emulator like vice...

## Chapter 1
### The REPL

Forth has a **REPL**, just as the c64 itself. This works as follows:  
- **R**EAD something from the input  
- **E**VALUATE (or **E**XECUTE) it  
- **P**RINT the result (here the result will be "ok" or some error message - meaningfull output will be done in the evaluator.  
- **L**OOP back to the start of the REPL.

This is very simple to implement in BASIC:

```RealBasic
100 rem repl
110 input i$
120 msg$="ok":if i$="bye" then end
130 print msg$
140 goto 110
```
- we read a line from the input  
- then evaluate it (here we just look if the input is "bye" and exit if so)
- then we print the result (in this application, the output will be "ok" or some error message) 
- and then start again

Very simple isn't it? In the next chapter we will build a simple interpreter to evaluate more than just the "bye" instruction.

## Chapter 2
### The interpreter

Our evaluator will be a very simple interpreter. Everything "word" we enter is looked up in the list and something is executed. If the word is not in the list, an 'unknown command' error is returned.  
As an example, a command "HI" is added, and tree commands which change the color of the screen using poke commands to the video hardware.

```RealBasic
100 rem repl
110 input i$
120 gosub 1000
130 print msg$
140 goto 110

1000 rem interpreter
1010 msg$ = "ok"
1020 if i$="bye" then end
1030 if i$="hi" then print "hi yourself !": return
1040 if i$="clr-green" then poke 53280,0: poke 53281,0: print chr$(153):return
1050 if i$="clr-yellow" then poke 53280,0: poke 53281,0: print chr$(158):return
1060 if i$="clr-normal" then poke 53280,14: poke 53281,6: print chr$(154):return
1100 msg$="unknown command":return 
```

Again very simple... In the next chapter we will a little simple arithmic.

