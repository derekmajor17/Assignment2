.data
  emptyInput:   .asciiz "Input is empty."
  invalidInput: .asciiz "Invalid base-27 number."
  longInput:    .asciiz "Input is too long"
  userInput:    .space  512
  
  .text
main:
  li $v0, 8
  la $a0, userInput
