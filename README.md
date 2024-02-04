# cat command written in RISC-V assembly (linux)

This is a very basic ```cat``` command written from scratch in 64 bits RISC-V assembly.  
It just opens a file and displays it.

The source shows how to:
- use command line arguments
- make system calls

TODO : find the right system call for "open"

Makefile will build with debug symbols, so you can have some fun with gdb :-)
