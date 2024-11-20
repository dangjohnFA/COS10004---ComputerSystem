/stage 1 
main:
      MOV R0, #dnd1     /Move dnd to R0
      STR R0, .WriteString /print question one out
      MOV R1, #inputname
      STR R1, .ReadString / Move input into array
numinput:
      MOV R4, #dnd2
      STR R4, .WriteString
      LDR R4, .InputNum
      MOV R3,#0 
arrayloop:
      LDRB R2,[R1+R3]
      STRB R2, [R1+R3]
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
      STR R1, .WriteString /print username into console
      MOV R0, #dnd4
      STR R0, .WriteString
      STR R4, .WriteSignedNum /print user's number console
/stage2
secondmain:
      MOV R0, #dnd10
      STR R0, .WriteString
      STR R1, .WriteString /print username into console
      MOV R0, #dnd6
      STR R0, .WriteString
      STR R4, .WriteSignedNum /print user's number console
      MOV R0, #dnd7
      STR R0, .WriteString /print the dnd7 out
      MOV R0, #dnd5
      STR R0, .WriteString
      STR R1, .WriteString /print username into console
      MOV R0, #dnd8
      STR R0, .WriteString /print the dnd8 out
      LDR R5, .InputNum /receive the user number
      CMP R5, #1 
      BLT secondmain
      CMP R5, #7
      BGT secondmain
      CMP R5, R4
      BGT secondmain
      SUB R4, R4, R5    /Substraction to end
      MOV R7, R4
      STR R7, .WriteSignedNum 
      CMP R7, #0
      BGT secondmain    / Loop if still remain
      MOV R0, #dnd9
      STR R0, .WriteString / Game over if the matchstick = 0
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
