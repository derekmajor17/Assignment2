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
  li $v0, 4   # address of string to print
  syscall
  j exit    #jump to exit program

main:
  la $a0, userInput   #points to the starting address of user input
     li $v0, 8    # loads userInput in $v0
     syscall
