*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    
* Put program code here

    MOVE.W #FIRST,A0
; Load the first memmory location 2000
    
    REPEAT 
    LEA MESSAGE,A1
    MOVE.W #14,d0
;Output message to screen
    TRAP #15
    
    MOVE.W #4,D0
    TRAP #15
;Move data in register D1 to A0 and increment with every loop
    MOVE.W D1,(A0)+
    
    UNTIL.B D1 <EQ> #0 DO
    ;Repeat until D1 is equal to literal value 0
    
    MOVE.W #FIRST,A0
    ;Load first memmory location before we enter the loop
    
LOOP MOVE.W (A0)+, D1
    CMP.W #0,D1
    BEQ EXIT

    LEA SPACING,A1
    MOVE.W #14,D0
    TRAP #15
    
    ;Keep looping until register D1 is equal to 0, printing each number and spacing it out
    
    MOVE.W #20,D0
    TRAP #15
    BRA LOOP
    
EXIT SIMHALT             ; halt simulator

* Put variables and constants here
CR EQU $0D
LF EQU $0A
MESSAGE DC.B CR,LF,'ENTER 0 TO STOP LOOP',CR,LF,0
FIRST EQU $2000
SPACING DC.B ' ',0
    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
