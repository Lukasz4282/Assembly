        *-----------------------------------------------------------
* Program    :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
	ORG	$1000
START:				; first instruction of program
*---------------------------------------------------------- 
* Display a digit on the 7-segment display 
* Pre:  D3.B contains 1 digit to display 
*       A2 points to 7-segment LED to use 
* Post: A2 points to next 7-segment LED 

	move.b	#32,d0	 trap task to get address of hardware
	move.b	#0,d1    0 in D1 means display
	trap	#15	 display hardware window
	
	move.b	#1,d1    1 in D1 means get address of 7 segment when trap 32 is run
	trap	#15	 get address of 7-segment display and stores it in D1
	move.l	d1,a4	 A4 = Address of 7-segment display
	
*	move.b	#2,d1    2 in d1 means get address of LEDS
*	trap	#15	 get address of LEDs
*	move.l	d1,a3	 A3 = Address of LEDs (we don't use this, this is just as example)

	move.l a4,a2     Address of 7 segment display needs to be in A2 for segment7 sub routine



*------------ identify the characters load them into D3 one at a time and display them one at a time----------
	

        
*~~ Ask user to hit enter to continue and then put ALArm in 7 Segment etc ~~*

                *~~ INSERT CODE HERE ~~*
                
        move.b	#19,d3	        place the value from array position 15 (char 0) in D3 and call segment7 subroutine 
	bsr	segment7
	
	move.b	#18,d3		12th item which is the char n
	bsr	segment7
	
	move.b	#10,d3          10th item which is the blank char
	bsr	segment7
	
	LEA MESSAGE,A1
        MOVE.W #14,d0

        TRAP #15  
        MOVE.W #4,D0
        TRAP #15
        
         move.l a4,a2     Address of 7 segment display needs to be in A2 for segment7 sub routine

                
        move.b	#12,d3	        16th item which is the char A
	bsr	segment7
	
	move.b	#17,d3		17th item which is the char L
	bsr	segment7
	
	move.b	#12,d3	        16th item which is the char A
	bsr	segment7
	
	move.b	#22,d3	        18th item which is the char R
	bsr	segment7
	
	move.b	#18,d3	        14th item which is the char n
	bsr	segment7
	
	move.b	#18,d3	        14th item which is the char n
	bsr	segment7
	
        move.b	#10,d3	        10th item which is the char ""
	bsr	segment7
	
	move.b	#10,d3	        10th item which is the char ""
	bsr	segment7
	
	
	
	
	LEA MESSAGE,A1
        MOVE.W #14,d0

        TRAP #15  
        MOVE.W #4,D0
        TRAP #15

        move.l a4,a2     Address of 7 segment display needs to be in A2 for segment7 sub routine

        
                
        move.b	#12,d3	        16th item which is the char A
	bsr	segment7
	
	move.b	#13,d3		19th item which is the char C
	bsr	segment7
	
	move.b	#23,d3	        20th item which is the char T
	bsr	segment7
	
	move.b	#16,d3	        18th item which is the char i
	bsr	segment7
	
	move.b	#24,d3	        14th item which is the char v
	bsr	segment7
	
	 move.b	#12,d3	        16th item which is the char A
	bsr	segment7
	
       move.b	#23,d3	        20th item which is the char T
	bsr	segment7
	
	move.b	#14,d3	        20th item which is the char E
	bsr	segment7

        	LEA MESSAGE,A1
        MOVE.W #14,d0

        TRAP #15  
        MOVE.W #4,D0
        TRAP #15

        move.l a4,a2     Address of 7 segment display needs to be in A2 for segment7 sub routine
 
        
        
        move.b	#20,d3	        23th item which is the char O
	bsr	segment7
	
	move.b	#21,d3		24th item which is the char P
	bsr	segment7
	
	move.b	#14,d3	        20th item which is the char E
	bsr	segment7
	
	move.b	#18,d3	        14th item which is the char n
	bsr	segment7
	
	move.b	#10,d3	        10th item which is the char ""
	bsr	segment7
	
	move.b	#10,d3	        10th item which is the char ""
	bsr	segment7
	
        move.b	#10,d3	        10th item which is the char ""
	bsr	segment7
	
	move.b	#10,d3	        10th item which is the char ""
	bsr	segment7




*------------ end of display characters 

	MOVE.B	#9,D0
	TRAP	#15		; halt simulator

* Variables and Strings

segment7: 
    movem.l d3/a0,-(a7)     save registers 
    lea digits,a0           starting address of bit pattern array table now in A0 
    and.l   #$00ff,d3       we force the top 8 bits of D3 to 0 by anding with #$00ff (leave only the byte unchanged)
    move.b  (a0,d3),(a2)    display digit by placing in A2 the contents of A0 position value in D3 e.g (digits,pos 12)
    adda.l  #2,a2           move to next digit in 7-segment display
    movem.l (a7)+,d3/a0     restore registers 
    rts
    
    *Note: Adda is used with address registers, which are never byte-size so is extended to 32 bits
    *Note: movem moves to or from memory. For more see: http://68k.hax.com/MOVEM
    
* bit patterns to form digits on readout 
*----------------------------------------------------------- 
*         A 
*       ----- 
*     F|     |B 
*      |  G  | 
*       ----- 
*     E|     |C 
*      |  D  | 
*       -----   .H 
* 
* Bit Number  128  64 32  16 8 4 2 1
* Segment     H    G  F   E  D C B A 
*
* Total of all is 255 (Hex FF) => 128 + 64 + 32 + 16 + 8 + 4 + 2 + 1

digits: 
    dc.b  $3F           digit 0 63 in decimal 1+2+4+8+16+32 #0
    dc.b  $06           digit 1 #1
    dc.b  $5B           digit 2 #2
    dc.b  $4F           digit 3 #3
    dc.b  $66           digit 4 #4
    dc.b  $6D           digit 5 #5
    dc.b  $7D           digit 6 #6
    dc.b  $07           digit 7 #7
    dc.b  $7F           digit 8 #8
    dc.b  $6F           digit 9 #9
    dc.b  $00           digit off #10
    dc.b  $40           dash #11
    
    
    dc.b  $77           letter A decimal value 119 in decimal pos #12 in the array
    dc.b  $39           letter C decimal value 57 in decimal post #13 in the array
    dc.b  $79           letter E decimal value 121 in decimal pos #14 in the array
    dc.b  $76           letter H decimal value 118 in decimal #15
    dc.b  $10           letter i decimal value 16 in decimal post #16 in the array
    dc.b  $38           letter L decimal value 56 in decimal pos #17 in the array
    dc.b  $54		letter n decimal value 84 in decimal #18
    dc.b  $5C           letter o decimal value 92 in decimal pos #19 in the array
    dc.b  $3F           letter O decimal value 191 in decimal post #20 in the array
    dc.b  $73           letter P decimal value 243 in decimal post #21 in the array
    dc.b  $50           letter R decimal value 80 in decimal post #22 in the array
    dc.b  $78           letter t decimal value 120 in decimal post #23 in the array
    dc.b  $1C           letter v decimal value 28 in decimal post #24 in the array
    
    
    


    ds.w  0             force word boundary always the last element in the array of digits


MESSAGE DC.B 'Press enter to continue',0

	END	START		; last line of source





*~Font name~Courier New~

*The program works in an almost type writer style, where we have a resolver and a bit of information. In this case, we use the diagram and add the value of each edge to make up
*the shape we require, with the added number, we convert to hexidecimal and save it into the next place in the array. The program reads each digit one by one, branching to label segment7
*which keeps track of which digit to alter, saves the digits and writes the hex value of the current index. We can subtract 16 from a3 to reset the display.












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
