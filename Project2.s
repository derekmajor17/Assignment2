#
#Project2.S
.data
  emptyInput:   .asciiz "Input is empty."   #Adds string to data
  invalidInput: .asciiz "Invalid base-27 number."   #Adds string to data
  longInput:    .asciiz "Input is too long"   #Adds string to data
  userInput:    .space  8   #reserves space for 8 bytes in memory

.text
emptyInputError:    
  la $a0, emptyInput    #system call code for emptyInput
  li $v0, 4   # address of string to print
  syscall
  j exit    #jump to exit program

invalidInputError:
  la $a0, invalidInput #system call code for invalidInput
  li $v0, 4   # address of string to print
  syscall
  j exit    #jump to exit program

LongInputError:
  la $a0, longInput   #system call code for longInput
  li $v0, 4   # address of string to printIt will point to 4th b
  syscall
  j exit    #jump to exit program

main:
  la $a0, userInput   #points to the starting address of user input
     li $v0, 8    # loads userInput in $v0
     syscall

#Check if input is more than 4 characters long
     lb $t0, 5($a0)  # sixth byte put into $t0, fifth byte is new line char to enter string
     bne $zero, $t0, printMoreThanFour   # if sixth byte isn't NULL then userInput has more than 4 characters

     li $s0, 1  # number to multiply 27 with 
     li $s1, 0  # sum number
     li $s4, 0  # loop counter
     addi $a0, $a0, 4  # $a0 points to the fifth byte

loop:
     li $t5, 4
     beq $t5, $s4, loopExit
     addi $s4, $s4, 1  # update value of counter by one
     addi $a0, $a0, -1 # update value so it points to the address before the previous byte
     lb $t2, 0($a0)  # getting ASCII value of char
     beqz $t2, loop  # if value is NULL then branch to loop
     
     li $a1, 10    # load new line char
     beq $a1, $t2, loop  # go to loop start if it's a new line char

     addi $t0, $zero, 38
     slt $t1, $t0, $t2
     slti $t4, $t2, 58
     and $s5, $t1, $t4   # if value is in range 39 to 48, $s5 will have 1
     addi $s3, $t2, -39   # $value used for calulation later

     li $t7, 1
     beq $t7, $s5, calculation  # if $s5 already has 1, calculate the char's value from ASCII and skip other checks and branch to calculation

     addi $t0, $zero, 64    #starts at the letter 'A'
     slt $t1, $t0, $t2
     slti $t4, $t2, 80    #ends at the letter 'Q'
     and $s5, $t1, $t4     #if value is  within range 65 to 81 then 1(True) is returned 
     addi $s3, $t2, -55   #if $s5 has 1 then calculate value then branch to calculation 
     
     li $t7, 1
     beq $t7, $s5, calculation  #calculates the char's value from ASCII
     addi $t0, $zero, 96  #range starts at 'a'
     slt $t1, $t0, $t2
     slti $t4, $t2, 114 #range goes to 'q'
     and $s5, $t1, $t4  #if value is within range 97 and 113, $s5 will have 1
     addi $s3, $t2, -87
     li $t7, 1
     beq $t7, $s5, calculation  #if $s5 has 1 then calculate value then branch to calculation 

     # If $s5 is still 0, it means that $t2 has an invalid char in base-27 system
     beq $s5, $zero, printInvalidValue   #if $t2 value is invalid then jump to printInvalidValue

     calculation:
     mult $s0, $s3                               
