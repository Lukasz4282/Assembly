*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    
    LEA MESSAGE,A1  ;Shows a message for the user to enter a value
    MOVE.L #14,D0   
    TRAP #15
      
    MOVE.L #4,D0    ;Stores the value into variable A
    TRAP #15
    MOVE.L D1, A
    
    LEA MESSAGE,A1  
    MOVE.B #14,D0
    TRAP #15
    
    MOVE.L #4,D0 ;Stores the value in Variable B etc etc
    TRAP #15
    MOVE.L D1, B
    
    LEA MESSAGE,A1  
    MOVE.L #14,D0
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    MOVE.L D1, C
    
    LEA MESSAGE,A1  
    MOVE.L #14,D0
    TRAP #15
    
    MOVE.L #4,D0
    TRAP #15
    MOVE.L D1, D
    
    LEA MESSAGE,A1  
    MOVE.L #14,D0
    TRAP #15
    
    CLR D5      ;Clears register D5
    ADD.L A,D5  ;Adds variable A to register D5
    ADD.L B,D5

    ADD.L C,D6  ;Adds variable C to register D6
    ADD.L D,D6
    MULS D5,D6  ;Multiplies register D5 by D6 and stores result in D6

    LEA OUTPUT,A1
    MOVE.L #14,D0
    TRAP #15
    MOVE.L D6,D1    ;Outputs result onto screen
    MOVE.L #20,D0 ; Trap task 20 outputs
    TRAP #15 ; the number in D1      
    
    SIMHALT             ; halt simulator

* Put variables and constants here
CR EQU $0D
LF EQU $0A  
A DC.L 0
B DC.L 0
C DC.L 0
D DC.L 0
MESSAGE DC.B 'Please enter 4 numbers: ',CR,LF,0
OUTPUT DC.B 'The result is: ',CR,LF,0
    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
