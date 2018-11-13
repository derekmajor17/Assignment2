#
#Project2.S
.data
  emptyInput:   .asciiz "Input is empty."   #Adds string to data
  invalidInput: .asciiz "Invalid base-27 number."   #Adds string to data
  longInput:    .asciiz "Input is too long"   #Adds string to data
  userInput:    .space  512   #User input representing a space

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
  li $v0, 8     #system call to read string 
  la $a0, userInput       #address of input string to read 
  li $a1, 16      #system call to close 
  syscall
  la $t0, userInput   #load address of user input 

getStringLength:
  lb $t1, 0($t0)      #loads the byte 
  beq $t1, $zero, after_get_str_len     #branches if equal
  addi $t0, $t0, 1      #adds and prints 
  j getStringLength    #jumps out of getStringLength
