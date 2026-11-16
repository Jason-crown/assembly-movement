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
                jsr         CHECK_ARROWS
                jsr         _END
CHECK_ARROWS:                           ; get arrow inputs
                move.b      #19,d0    
                move.l      #$25262728,d1
                trap        #15
                
                cmpi.b      #0,d1
                bne         DOWN

                lsr.l       #8,dl
                cmpi.b      #0,d1
                bne         RIGHT
                
                lsr.l       #8,dl
                cmpi.b      #0,d1
                bne         UP
                
                lsr.l       #8,dl
                cmpi.b      #0,d1
                bne         LEFT
                rts
DOWN:
                move.b      #15,d0
                move.b      #'v',d1
                trap        #15
                rts
RIGHT:
UP:
LEFT:

                
                

_END:                
    SIMHALT                             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
