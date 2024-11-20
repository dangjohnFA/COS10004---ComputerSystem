/stage1
main:
      MOV R0, #dnd1     /Move dnd to R0
      STR R0, .WriteString /print question one out
      MOV R9, #inputname
      STR R9, .ReadString / username
numinput:
      MOV R4, #dnd2
      STR R4, .WriteString / user's selected number of matchsticks
      LDR R4, .InputNum
      MOV R3,#0 
arrayloop:
      LDRB R2,[R9+R3]
      STRB R2, [R9+R3]
      ADD R3,R3,#1
      CMP R2, #0
      BNE arrayloop
;the range of number allowed.
      CMP R4, #10       / compare user's input to 10
      BLT numinput
      CMP R4, #100      / compare user's input to 100
      BGT numinput
;print after inputs are filled.
      MOV R0, #dnd3
      STR R0, .WriteString /print dnd into console 
      STR R9, .WriteString /print username into console
      MOV R0, #dnd4
      STR R0, .WriteString
      STR R4, .WriteSignedNum /print user's number console
      BL displayMatchstick
/stage2
secondmain:
      MOV R0, #dnd10
      STR R0, .WriteString
      STR R9, .WriteString /print username into console
      MOV R0, #dnd6
      STR R0, .WriteString
      STR R4, .WriteSignedNum /print user's number console
      MOV R0, #dnd7
      STR R0, .WriteString /print the dnd7 out
      MOV R0, #dnd5
      STR R0, .WriteString
      STR R9, .WriteString /print username into console
      MOV R0, #dnd8
      STR R0, .WriteString /print the dnd8 out
      LDR R5, .InputNum /receive the user number
      CMP R5, #1 
      BLT secondmain
      CMP R5, #7        / compare to the range if it is available
      BGT secondmain
      CMP R5, R4
      BGT secondmain
      SUB R4, R4, R5    /Substraction
      BL displayMatchstick
/stage3
      MOV R7, R4
      STR R7, .WriteSignedNum 
      CMP R7, #1
      BNE PlayercheckZero / move to the playercheckzero function
      B PlayerWin
PlayercheckZero:
      CMP R7, #0
      BNE Npc
      B drawCondition
Npc:
      MOV R0, #dnd11
      STR R0, .WriteString /print "Computer Player’s turn"
      LDR R5, .Random   / random number will chosen
      AND R5, R5, #7
      CMP R5, #1
      BLT Npc
      CMP R5, R4
      BGT Npc
      SUB R4, R4, R5    /Substraction
      MOV R7, R4
      STR R7, .WriteSignedNum 
      BL displayMatchstick
      CMP R7, #1
      BNE NPCcheckZero  / move to the NPCcheckZero function
      B NpcWin
NPCcheckZero:
      CMP R7, #0
      BNE secondmain
      B drawCondition   / When the remain matchsticks return 0
PlayerWin:
      MOV R0, #dnd5
      STR R0, .WriteString
      STR R9, .WriteString /print username and You WIN into console
      MOV R0, #dnd12
      STR R0, .WriteString
      B checkYes
NpcWin: 
      MOV R0,#dnd5
      STR R0, .WriteString
      STR R9, .WriteString /print username and YOU LOSE into console
      MOV R0, #dnd13
      STR R0, .WriteString
      B checkYes
drawCondition:
      MOV R0, #dnd15
      STR R0, .WriteString / In draw condition
      B checkYes
checkYes:
      MOV R0, #dnd16
      STR R0, .WriteString / Write the message asking for input
      MOV R1, #inputBuffer /
      STR R1, .ReadString / Read the input string into the buffer
      LDRB R5, [R1]     / Load the first character of the input into R9
      CMP R5, #121      / Compare with ASCII 'y' (121)
      BNE checkNo
      B main
checkNo:
      CMP R5, #110      / Compare with ASCII 'n' (110)
      BNE checkYes
      B gameOver
gameOver:
      MOV R0, #dnd9
      STR R0, .WriteString / when user choose 'n', the game's over
      B halt1
halt1:
      HALT
/stage4
displayMatchstick:
      PUSH {LR}
      STR R0, .ClearScreen
      MOV R1, #.PixelScreen
      MOV R8, #.black
      MOV R3, #768
      MOV R7, R4        / Use R7 to store the number of matchsticks
      MOV R8, #0
      MOV R6, #1
loop2:
      MOV R5, #0        / Matchstick counter
loop1:
      CMP R7, #0
      BEQ ret1
      STR R2, [R1+R3]   / Start the animation by printing it at 768
      ADD R3, R3, #8    / Move to the next position
      ADD R5, R5, #1
      ADD R8, R8, #1
      CMP R8, R7
      BEQ ret1
      CMP R5, #20
      BNE loop1
      ADD R6, R6, #1
      CMP R6, #2
      BEQ row2
      CMP R6, #3
      BEQ row3
      CMP R6, #4
      BEQ row4
      CMP R6, #5
      BEQ row5
      HALT
row2:
      MOV R3, #1536
      B loop2
row3:
      MOV R3, #2304
      B loop2
row4:
      MOV R3, #3072
      B loop2
row5:
      MOV R3, #3840
      B loop2
ret1:
      POP {LR}
      RET
      HALT
dnd1: .ASCIZ "Please enter your name\n"
inputname: .BLOCK 256
dnd2: .ASCIZ "How many matchsticks (10-100)?\n"
dnd3: .ASCIZ "Player 1 is "
dnd4: .ASCIZ "\nMatchsticks: "
dnd5: .ASCIZ "\nPlayer "
dnd6: .ASCIZ ", there are "
dnd7: .ASCIZ "matchsticks remaining"
dnd8: .ASCIZ ", how many do you want to remove (1-7)?\n"
dnd9: .ASCIZ "\nGame Over"
dnd10:.ASCIZ "\nPlayer "
dnd11:.ASCIZ "\nComputer Player’s turn\n"
dnd12:.ASCIZ ", YOU WIN!"
dnd13:.ASCIZ ", YOU LOSE!"
dnd14:.ASCIZ "Computer"
dnd15:.ASCIZ "It's a draw!"
dnd16:.ASCIZ "\nPlay again (y/n) ?\n"
inputBuffer: .BLOCK 256 / Allocate 256 bytes for the input buffer
