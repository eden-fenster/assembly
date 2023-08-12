# Title: Question #4		Filename: mmn11q4
# Author: Eden Fenster		Date: 09.08.2023
# Description: Print a sorted array containing pairs of 2 numbers in base 8.
# Input: 	stringocta - a string with pairs of numbers in base 8 with a $ separating between each pair.
# Output:	NUM - a sorted array with pairs of numbers in decimal.
#
 ################# Data segment #####################
 .data # Allocate space for string
NUM: .space 10
sortarray: .space 10
space: .asciiz "\n"
stringocta: .space 31
string: .asciiz  "\n Please Enter a string (max 30 characters):\n"
wrong_input: .asciiz "\n wrong input \n"
octa: .word 
 ################# Code segment #####################
  .text
 .globl main
 main:   #main program entry
 	li $v0,4 # syscall to print string
 	la $a0,string # "Please Enter a string (max 30 characters)"
 	syscall # printing

  	li $a1, 31 #set input string to be maximum 30 characters
  	la $a0, stringocta    #point to stringocta
  	li $v0, 8 #set syscall to read string
  	syscall #get the string to stringocta
  	
  	li $t6 ,-1#$t6 the string indexfor case of one char
count: #count the number of chars in the string
  	addi $t6,$t6,1
  	lbu $t7, stringocta($t6)       #$t7 =load byte from memory
  	bnez $t7,count 
  	beq $t7,$zero, is_valid
  	
is_valid: #checking to see if input is valid
	la $t0, stringocta
	li $t1,-3 # loop 1
	li $t2,-2 # loop 2
	li $t3,-1 # loop 3
	li $t4, 0 # number of pairs.
	li $t5, '$' # seperator
	sub $t6, $t6, 2 # number of overall chars - 1
	li $t8, 7 # no one can be bigger than him.
first_loop:
	# first in pair
	addi $t1, $t1, 3
	lbu $t0,stringocta($t1)
	addi $t0,$t0,-48
more_than_seven_first:
	ble $t0, 7, end_of_loop_first  # if > 7
	jal wrong
end_of_loop_first:
	blt $t1,$t6,  else_first
	jal second_loop
else_first: 
	jal first_loop
second_loop:
	# second in pair
	addi $t2, $t2, 3
	lbu $t0,stringocta($t2)
	addi $t0,$t0,-48
more_than_seven_second:
	ble $t0, 7, end_of_loop_second  # if > 7
	jal wrong
end_of_loop_second:
	blt $t2,$t6, else_second
	jal third_loop
else_second:
	addi $t4, $t4, 1 # increment # of pairs
	jal second_loop
	
third_loop:
	addi $t3, $t3, 3
	lbu $t0,stringocta($t3) # checking if each pair is seperated properly.
	jal not_equal
not_equal:
	beq $t0, $t5, end_of_loop_third # if equal
	jal wrong
end_of_loop_third:
	blt $t3,$t6, else_third
	jal valid
else_third: 
	j third_loop # else, continue
valid: # reurn # of pairs
	li $v0, 1
	la $a0, ($t4)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	jal convert
	
	

	
wrong: # return 0
	li $v0,4 # syscall to print string
	la $a0,wrong_input # wrong input
	syscall
	li $t4,0 # number of pairs equals 0
	li $v0, 1
	la $a0, ($t4)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	jal main

convert:
	la $t0, ($t4)     # load the address of $t4
	la $t1, octa    # load the address of octa
	move $t1, $t0 # moving it in


	
	# loading the two other variables.
	#la $t3, stringocta
	#la $t8, NUM
	
	# extracting each pair of numbers and loading them into the array.
	li $t2, -3 # loop
	li $t7, -2 # first loop 
	li $t9, -1 # loop for NUM
conversion:
	addi $t9, $t9, 1
first_digit:
	addi $t2, $t2, 3
	lbu $t5,stringocta($t2)
	addi $t5,$t5,-48
	sll $t3, $t5, 3 # multiply by 8
second_digit:
	addi $t7, $t7, 3
	lbu $t8,stringocta($t7)
	addi $t8,$t8,-48
	add $t3, $t3, $t8 # s1 <- add to t2
	sb $t3, NUM($t9)
full:
	blt $t9, $t0, is_first_done
	jal print
is_first_done:
	blt $t2, $t6,is_second_done
	jal print
is_second_done:
	blt $t7, $t6,loop
	jal print
loop:
	jal conversion
print:
	 # printing
	li, $v0, 11
	la $a1, space
	syscall
	#la $t0, NUM
	#li $t1, octa
	# convert to decimal.
	#jal sort
	# number of times we have been here.
	# li $t2, -1
convert_to_decimal:
	# loop + t6
	# n/10 -> n/10 -> mflo
	#div $t0, 10
	# n%10 -> mfhi
	# into NUM
	# print
	
#sort:
	#swap
	#jal print
