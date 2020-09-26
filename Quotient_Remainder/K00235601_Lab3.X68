*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
    LEA     MESSAGE,A1     ;Loads label MESSAGE into address register A1
    MOVE.B  #14,D0         ;Moves literal value 14 into register D0
    TRAP #15               ;Outputs on screen based on value of D0
    
    LEA PROMPTNUMERATOR,A1 ;Output a message
    MOVE.B #14,D0          ;asking the user to enter
    TRAP #15               ;a numerator number
    MOVE.W #4, D0
    TRAP #15
    MOVE.W D1,D4
    
    LEA PROMPTDENOMINATOR,A1 ;Outputs but this time a denominator
    MOVE.W #14,D0
    TRAP #15
    MOVE.W #4, D0
    TRAP #15
    MOVE.W D1,D3
    
    DIVU D3,D4  ;Divide D3 by D4 and store result in D4
    
    LEA RESULT1,A1
    MOVE.B #14,D0 
    TRAP #15
    MOVE.B D4,D1    ;Disply result from D4 by moving into D1 and Trap #15
    MOVE.B #20,D0 ; Trap task 20 outputs
    TRAP #15 ; the number in D1
    
    LEA RESULT2,A1
    MOVE.B #14,D0
    TRAP #15
    SWAP D4 ; Swaps the lower to get remainder
    MOVE.B D4,D1
    MOVE.B #20,D0
    TRAP #15



    
    
    
    
 
    SIMHALT             ; halt simulator

* Put variables and constants here
CR EQU $0D
LF EQU $0A  
MESSAGE DC.B 'Welcome to the Divide Calculator',CR,LF,0
PROMPTNUMERATOR DC.B 'Please enter a numerator: ',CR,LF,0
PROMPTDENOMINATOR DC.B 'Please enter a denominator',CR,LF,0
RESULT1 DC.B 'The Quotient is: ',0
RESULT2 DC.B CR,LF,'The Remainder is: ',0


    END    START        ; last line of source




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
