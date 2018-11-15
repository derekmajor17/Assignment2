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

