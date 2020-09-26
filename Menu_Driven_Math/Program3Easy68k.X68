*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    LEA  MESSAGE,A1     
    MOVE.B  #14,D0          
    TRAP #15
    
LOOP  LEA     MESSAGE2,A1    ;Loop label used for returning here
    MOVE.B  #14,D0          
    TRAP #15
    MOVE.W #4, D0
    TRAP #15
    MOVE.W D1,D4
    
    CMP.B   #1,D4           ;Compares D4 to 1
    BLT     INVALID         ;BLT branches if D1 is less than 1
    CMP.B   #2,D4           ;Compares D1 to 2
    BGT     INVALID         ;BGT branches if D1 is greater than 2
    
    *--Figures out the number--
    CMP.B #1,D4     ;Compares literal value 1 to D4
    BNE TWO         ;If not equal, go to label TWO
    LEA INPUT1,A1  
    MOVE.B #14,D0
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15        ;Output messages and take inputs
    MOVE.L D1, D6
    
    LEA INPUT1,A1  
    MOVE.L #14,D0
    TRAP #15
      
    MOVE.L #4,D0
    TRAP #15
    MOVE.L D1, D7
    
    *--Outputs the first digit--
    MOVE.L D6,D1
    MOVE.L #20,D0 ; Trap task 20 outputs
    TRAP #15 ; the number in D1 
    *--Outputs the +--*
    LEA ADDITION,A1
    MOVE.L #14,D0
    TRAP #15
    *--Outputs the second digit--
    MOVE.L D7,D1
    MOVE.L #20,D0 ; Trap task 20 outputs        ;Done to format nicely
    TRAP #15 ; the number in D1 
    *--Outputs the =--*
    LEA EQUALS,A1
    MOVE.L #14,D0
    TRAP #15
    *--Outputs the result--
    ADD.L D6,D7
    MOVE.L D7,D1
    MOVE.L #20,D0 ; Trap task 20 outputs
    TRAP #15 ; the number in D1
    
    
    CLR D6  ;Clear registers because they will retain their values after looping 
    CLR D7
    BRA LOOP
 
TWO CMP.L #2,D4 ;Label TWO, Compare literal value 2 to D4
    BNE LOOP    ;Go to LOOP if theyre not equal
    
    LEA INPUT2,A1
    MOVE.B #14,D0
    TRAP #15
    MOVE.W #4, D0
    TRAP #15
    MOVE.W D1,D4
    
    LEA INPUT2,A1
    MOVE.W #14,D0
    TRAP #15
    MOVE.W #4, D0
    TRAP #15
    MOVE.W D1,D3
    
    DIVU D3,D4
    
    LEA RESULT1,A1                          ;Stuff from previous program, division
    MOVE.B #14,D0   
    TRAP #15
    MOVE.B D4,D1
    MOVE.B #20,D0 ; Trap task 20 outputs
    TRAP #15 ; the number in D1
    
    LEA RESULT2,A1
    MOVE.B #14,D0
    TRAP #15
    SWAP D4 ; Swaps the lower
    MOVE.B D4,D1
    MOVE.B #20,D0
    TRAP #15    

    BRA LOOP    ;Go to LOOP regardless

INVALID LEA INV,A1  ;Label to display a message that their input is invalid
    MOVE.L #14,D0
    TRAP #15

    SIMHALT             ; halt simulator

* Put variables and constants here
CR EQU $0D
LF EQU $0A  
MESSAGE DC.B 'Welcome to the second calculator',CR,LF,0
MESSAGE2 DC.B CR,LF,'1. Add 2 numbers',CR,LF,'2. Divide 2 numbers',CR,LF,0
INV DC.B 'Invalid input, please enter a value 1-2 !',CR,LF,0
INPUT1 DC.B 'Please enter a number for addition: ',CR,LF,0
INPUT2 DC.B 'Please enter a number for division: ',CR,LF,0
ADDITION DC.B ' + ',0
EQUALS DC.B ' = ',0
DIV DC.B ' / ',0
RESULT1 DC.B 'The Quotient is: ',0
RESULT2 DC.B CR,LF,'The Remainder is: ',0


    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
