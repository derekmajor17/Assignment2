.data
  emptyInput:   .asciiz "Input is empty."   #Adds string to data
  invalidInput: .asciiz "Invalid base-27 number."   #Adds string to data
  longInput:    .asciiz "Input is too long"   #Adds string to data
  userInput:    .space  512   #User input representing a space

.text
emptyInputError:    
  la $a0, emptyInput    #system call code for printing string
  li $v0, 4   # address of string to print
  syscall
  j exit    #jump to exit program
