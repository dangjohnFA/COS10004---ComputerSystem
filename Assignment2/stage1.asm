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
      HALT
dnd1: .ASCIZ "Please enter your name\n"
inputname: .BLOCK 256
dnd2: .ASCIZ "How many matchsticks (10-100)?\n"
dnd3: .ASCIZ "Player 1 is "
dnd4: .ASCIZ "\nMatchsticks: "
