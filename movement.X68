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
                move.w      #0,XO(a6)
                move.w      #0,YO(a6)
                move.w      #100,XS(a6)
                move.w      #100,YS(a6)
                jsr         _SHAPE          ; d1.w = x offset d2.w = y offset, d3.w = Width, d4.w = Height
LOOP:           jsr         CHECK_ARROWS
                jsr         CLEAR
                jsr         _SHAPE
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
                link        a6,#0
                movem       d0-d6,-(a7)
                move.w      #-1,FLAG(a6)
                move.w      XO(a6),SXO(a6)
loop2:    
loop1:  
                addq.w      #1,XO(a6)
                move.b      #82,d0          ; Task 82: Draw pixel in pen color
                trap        #15             ; Execute simulator task
                move.l      XO(a6),d0
                cmp         XS(a6),d0          ; Width
                blo         loop1
                addq.w      #1,YO(a6)
                
                move.w      SXO(a6),XO(a6)
                
                move.l      YO(a6),d0
                cmp         YS(a6),d0          ; Height
                blo         loop2
                movem.l     (a7)+,d0-d6
                unlk        a6
                rts

                


                
                

_END:                
    SIMHALT                             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
