.global _start
.text

_start:
    ld  a0,16(sp)       # argv[1]
    li  a1,0            # flags
    li  a2,0            # mode
    li  a7,1024         # "open" system call    <--- can't find the right open system call !!
    ecall
    blt a0,x0,exit      # Error ? we exit

    mv  t5,a0           # we save the file descriptor in t5
    li  a1,0            # offset
    li  a2,2            # SEEK_END
    li  a7,62           # "lseek" system call
    ecall
    blt a0,x0,exit      # Error ? we close the FD and exit
    mv  t6,a0           # we save the file size in t6

    mv  a0,t5           # first argument : the file descriptor (saved in t5)
    li  a1,0            # offset
    li  a2,0            # SEEK_SET
    li  a7,62           # "lseek" system call
    ecall
    blt a0,x0,exit      # Error ? we close the FD and exit

    li  a0,1            # Output to stdout (file descriptor 1)
    mv  a1,t5           # Input = the FD we opened (saved in t5)
    li  a2,0            # offset 0 = start from beginning
    mv  a3,t6           # count = file size saved in t6 
    li  a7,71           # "sendfile" system call
    ecall

close_exit:
    mv  a0,t5           # file descriptor was saved in t5
    li  a7,57           # "close" system call
    ecall

exit:
    li  a7,93           # "exit" system call
    ecall
