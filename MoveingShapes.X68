*-----------------------------------------------------------
* Title      : Moving shapes
* Written by : Jason Klutse
* Date       : 2026-11-17
* Description: Movable Shapes
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
XO      equ     14
YO      equ     12
XS      equ     10
YS      equ     8
SXO     equ     -2
* Put program code here
    ; set defaults
    move.l  #$00FF00FF,d1   ; default purple
    jsr     Main
    
_SET_COLOR:                 ; $00BBGGRR
    move.b  #80,d0          ; Task 80: Set pen color
    trap    #15             ; Execute simulator task
    rts

_SHAPE:
    link    a6,#-2
    move.w  XO(a6),d1
    move.w  YO(a6),d2
    move.w  XS(a6),d3
    move.w  YS(a6),d4
    move.w  d1,SXO(a6)
loop2:    
loop1:  
    addq.w  #1,d1
    move.b  #82,d0          ; Task 82: Draw pixel in pen color
    trap    #15             ; Execute simulator task
    cmp     d3,d1          ; Width
    blo     loop1
    addq.w  #1,d2
    
    move.w  SXO(a6),d1

   
    cmp     d4,d2          ; Height
    blo     loop2    
    unlk    a6
    rts
    
Main:           
                move.l      #$00FF00FF,d1
                jsr         _SET_COLOR
                move.w      #100,d2
                move.w      #100,d3
                move.w      #150,d4
                move.w      #150,d5
LOOP:           jsr         CHECK_ARROWS
                move.w      d2,-(a7)
                move.w      d3,-(a7)
                move.w      d4,-(a7)
                move.w      d5,-(a7)
                
                jsr         _SHAPE
                jsr         SLEEP
                jsr         CLEAR
                jsr         LOOP

CHECK_ARROWS:                           ; get arrow inputs\
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
                
                move.b      #19,d0    
                move.l      #'awds',d1
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

                move.b      #19,d0    
                move.l      #'AWDS',d1
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
                move.w      #6,d0
                move.w      #'D',d1
                trap        #15
                rts
RIGHT:           
                move.w      #6,d0
                move.w      #'R',d1
                trap        #15
                rts
UP:
                move.w      #6,d0
                move.w      #'U',d1
                trap        #15
                rts
LEFT:
                move.w      #6,d0
                move.w      #'L',d1
                trap        #15               
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

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
