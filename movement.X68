*-----------------------------------------------------------
* Title      : movement
* Written by : Jason Klutse
* Date       : 2026-11-15
* Description: The movement of pixels
*-----------------------------------------------------------
    ORG    $1000
START:                                  ; first instruction of program

* Put program code here
_MAIN:
LOOP:           jsr         CHECK_ARROWS
                jsr         SLEEP
                bra         LOOP
                jsr         _END
CHECK_ARROWS:                           ; get arrow inputs
                move.b      #19,d0    
                move.l      #$25262728,d1
                trap        #15
                
                tst.b       d1
                bne         DOWN

                lsr.l       #8,d1
                tst.b       d1
                bne         RIGHT
                
                lsr.l       #8,d1
                tst.b       d1
                bne         UP
                
                lsr.l       #8,d1
                tst.b       d1
                bne         LEFT
                rts
                
DOWN:
                move.b      #6,d0
                move.b      #'v',d1
                trap        #15
                rts
RIGHT:          
                move.b      #6,d0
                move.b      #'>',d1
                trap        #15
                rts
UP:
                move.b      #6,d0
                move.b      #'^',d1
                trap        #15
                rts
LEFT:
                move.b      #6,d0
                move.b      #'<',d1
                trap        #15
                rts
                
SLEEP:
                move.b      #23,d0
                move.l      #1,d1
                trap        #15
                rts

                
                

_END:                
    SIMHALT                             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
