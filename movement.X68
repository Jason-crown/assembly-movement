*-----------------------------------------------------------
* Title      : movement
* Written by : Jason Klutse
* Date       : 2026-11-15
* Description: The movement of pixels
*-----------------------------------------------------------
    ORG    $1000
START:                                  ; first instruction of program
XO    equ    14
YO    equ    12
XS    equ    10
YS    equ    8
SXO   equ    -2
FLAG  equ    -4 
* Put program code here

_MAIN:
                move.l      #$00FF00FF,d1
                jsr         _SET_COLOR      ; set color in d1.l
                move.w      #10,d1
                move.w      #10,d2
                move.w      #100,d3
                move.w      #100,d4                
LOOP:           
                jsr         CHECK_ARROWS
                jsr         CLEAR

                ;jsr         _SHAPE
                jsr         SLEEP
                

                move.w      d1,-(a7)
                move.w      d2,-(a7)
                move.w      d3,-(a7)
                move.w      d4,-(a7)

                jsr         _SHAPE
                bra         LOOP
                jsr         _END
CHECK_ARROWS:                           ; get arrow inputs\
                movem.l     d0-d1,-(sp)
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
                movem.l     (sp)+,d0-d1
                rts
                
DOWN:
                addi        #10,d2 
                addi        #10,d4               
                rts
RIGHT:           
                ;addi        #10,d1 
                addi        #10,d3
                rts
UP:
                subi        #10,d2 
                subi        #10,d4
                rts
LEFT:
                ;subi        #10,d1 
                subi        #10,d3                
                rts
                
SLEEP:
                movem.l     d0-d1,-(sp)
                move.b      #23,d0
                move.l      #5,d1
                trap        #15
                movem.l     (sp)+,d0-d1
                rts
CLEAR:          
                movem.l     d0-d1,-(sp)
                move.w      #$FF00,d1
                move.b      #11,d0
                trap        #15
                movem.l     (sp)+,d0-d1                
                rts
                
_SET_COLOR:                 ; $00BBGGRR
                move.b      #80,d0          ; Task 80: Set pen color
                trap        #15             ; Execute simulator task
                rts

_SHAPE:
                link        a6,#0
                movem.l     d0-d5,-(sp)
                move.w      YS(a6),d4
                move.w      XS(a6),d3
                move.w      YO(a6),d2
                move.w      XO(a6),d1
                move.w      d1,d5
loop2:    
loop1:  
                addq.w      #1,d1
                move.b      #82,d0          ; Task 82: Draw pixel in pen color
                trap        #15             ; Execute simulator task
                cmp         d3,d1          ; Width
                blo         loop1
                addq.w      #1,d2
                move.w      d5,d1
                cmp         d4,d2          ; Height
                blo         loop2
                movem.l     (sp)+,d0-d6
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
