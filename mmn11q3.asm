# Title: Question #3		Filename: mmn11q3
# Author: Eden Fenster		Date: 08.08.2023
# Description: Print a string in a loop and omit from it a char after each print, until there is nothing left.
# Input: 	sentence - the string that we are printing
# Output:	$t0 - our string with a char being removed from the end at each iteration.
#
 ################# Data segment #####################
 .data # Allocate space for string
 buffer: .space 31
 sentence: .asciiz  "\n Please Enter a string (max 30 characters):\n"
 ################# Code segment #####################
 .text
 .globl main
 main:   #main program entry
 	li $v0,4 # syscall to print string
 	la $a0,sentence # "Please Enter a string (max 30 characters)"
 	syscall # printing
  ###########################################################
  # get string from the user
  ############################################################
  	li $v0, 8 #set syscall to read string
  	la $a0, buffer    #point to buffer
  	li $a1, 31 #set input string to be maximum 30 characters
  	syscall #get the string to buffer

  	li $v0,11  #syscall 11 print char
  	li $t0 ,-1#$t0 the string indexfor case of one char
  continue_count: #count the number of chars in the string
  	addi $t0,$t0,1
  	lbu $t1, buffer($t0)       #$t1 =load byte from memory
  	bgt  $t1,10,continue_count #not null(=0) not \n(=10)
  	beq $t0,$0,Exit #there is no char to print 
  outer_loop:
  	li $a0,0xa
  	syscall
  	
  	li $t1,0 #$t1 the inner loop counter
  inner_loop:
  	lbu $a0,buffer($t1) #char to print
  	syscall
  	
  	addi $t1,$t1,1
  	bne $t1,$t0,inner_loop 
  	addi $t0,$t0,-1 #$t0 the outer loop counter
  	bnez $t0 outer_loop
  Exit:
  	li $v0, 10# Exit program
  	syscall
