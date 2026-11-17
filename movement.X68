*-----------------------------------------------------------
* Title      : movement
* Written by : Jason Klutse
* Date       : 2026-11-15
* Description: The movement of pixels
*-----------------------------------------------------------
    ORG    $1000
START:                                  ; first instruction of program
XO    equ    16
YO    equ    12
XS    equ    8
YS    equ    4
SXO   equ    -4
FLAG  equ    -8 
* Put program code here
_MAIN:
                link        a6,#0
                move.l      #$00FFFFFF,d1
                jsr         _SET_COLOR      ; set color in d1.l
                move.w      #0,d1
                move.w      #0,d2
                move.w      #100,d3
                move.w      #100,d4
                jsr         _SHAPE          ; d1.w = x offset d2.w = y offset, d3.w = Width, d4.w = Height
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
                
                rts
RIGHT:          

                rts
UP:

                rts
LEFT:

                rts
                
SLEEP:
                move.b      #23,d0
                move.l      #5,d1
                trap        #15
                rts
CLEAR:          
                move.w      #$FF00,d1
                move.b      #11,d0
                trap        #15
                
_SET_COLOR:                 ; $00BBGGRR
                move.b      #80,d0          ; Task 80: Set pen color
                trap        #15             ; Execute simulator task
                rts

_SHAPE:
                move.w      #-1,d6
                move.w      d1,d5
loop2:    
loop1:  
                addq.w      #1,d1
                move.b      #82,d0          ; Task 82: Draw pixel in pen color
                trap        #15             ; Execute simulator task
                move.l      d1,d0
                cmp         d3,d0          ; Width
                blo         loop1
                addq.w      #1,d2
                
                move.w      d5,d1
                
                move.l      d2,d0
                cmp         d3,d0          ; Height
                blo         loop2
                rts

                


                
                

_END:                
    SIMHALT                             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
