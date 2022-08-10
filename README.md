# Project Details

Testing for this project was performed on the Raspberry Pi Model 2B, using the following version of gcc for compilation:
gcc version 10.2.1 20210110 (Raspbian 10.2.1-6+rpi1)

# Compilation of Program

To compile the code from the base directory:
gcc -o gauss gauss.c

To generate the code's associated assembly file:
gcc -S gauss.c

# Program Execution

To run the compiled program, run the following command:
./gauss

When the program begins running, the user is prompted with the following instructions:
Select action:
(f) = run on local input file
(0, 1, 2, 3) = run test i from testbench 10 times

To select an action, the user must press either f, 0, 1, 2, or 3 followed by the enter key.
For all of the testbench options, the program will be run on a testbench matrix 10 times, 
printing the execution time of each iteration to stdout.
0	:	Randomly Generated Matrix of size 100x100

1	:	Randomly Generated Matrix of size 250x250

2	:	Randomly Generated Ill-conditioned Matrix of size 100x100

3	:	Randomly Generated Well-conditioned Matrix of size 100x100

For the local input file option, the program will run on the specified input matrix once, first printing
the input matrix, then the execution time for finding the inverse, and finally the inverse itself.


For example: to run the program out of the root directory on input/n3_a.txt, a matrix stored in the input directory,
type its filepath after choosing the (f) action:
input/n3_a.txt


The program also takes user input for the size of the input function, so for the above example where the
input matrix is of size 3x3, the user will input the number 3.
