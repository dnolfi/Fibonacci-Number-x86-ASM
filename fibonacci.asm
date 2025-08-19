section .data
SYS_EXIT        equ     60
EXIT_SUCCESS    equ     0

n           dq          10          ; 'nth' Fibonacci number
currentFib  dq          0           ;  Fib numbers
nextFib     dq          1
fibNum      dq          0           ; Number to return

section .bss

section .text
global _start
_start:
    ; Check if n is 0 or 1
    cmp     qword [n], 0
    je      nIsZero    
    cmp     qword[n], 1
    je      nIsOne 
    ; If not, enter the loop to find the nth fibonacci number
    mov     rax, qword [n]          ; move n into eax
    mov     rcx, 2                  ; move loop counter into ecx

loopStart:
    mov     rbx, qword [currentFib]
    mov     rdx, qword [nextFib]
    add     rbx, rdx
    mov     qword [currentFib], rdx ; store the new fibonacci(n-2)
    mov     qword [nextFib], rbx    ; store the new fibonacci(n-1)
    
    inc     rcx                     ; increment the loop counter
    cmp     rcx, rax                ; check if i == n
    jle     loopStart
    mov     qword [fibNum], rbx     ; final result
    jmp     last
      
nIsZero:
    mov     qword [fibNum], 0
    jmp     last

nIsOne:
    mov     qword [fibNum], 1
    jmp     last

last:
    mov     rax, SYS_EXIT
    mov     rdi, EXIT_SUCCESS
    syscall
