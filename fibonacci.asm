section .data
SYS_EXIT        equ     60
EXIT_SUCCESS    equ     0

i           dd          0           ; loop counter
n           dd          2          ; 'nth' Fibonacci number
currentFib  dd          0           ;  Fib numbers
nextFib     dd          1
fibNum      dd          0           ; Number to return

section .bss

section .text
global _start
_start:
    ; Check if n is 0 or 1
    cmp     dword [n], 0
    je      nIsZero    
    cmp     dword[n], 1
    je      nIsOne 
    ; If not, enter the loop to find the nth fibonacci number
    mov     eax, dword [n]          ; move n into eax
    mov     ecx, dword [i]          ; move loop counter into ecx
loopStart:
    mov     ebx, dword [currentFib]
    mov     edx, dword [nextFib]
    add     ebx, edx
    mov     dword [currentFib], edx ; store
    mov     dword [nextFib], ebx
    ; Keep
    inc     ecx                     ; increment the loop counter
    cmp     ecx, eax                ; check if i === n
    jne     loopStart
    mov     dword [fibNum], ebx
    jmp last
      
nIsZero:
    mov dword [fibNum], 0
    jmp last

nIsOne:
    mov dword [fibNum], 1
    jmp last

last:
    mov     rax, SYS_EXIT
    mov     rdi, EXIT_SUCCESS
    syscall