section .bss
  nome resb 8
  lennome equ $-nome
  letra resb 1
  lenletra equ $-letra
  ultima resb 1
  
section .data
    msgnaocontem db "Não Contém a letra escrita"
    lenmsgnaocontem equ $-msgnaocontem

    msgcontem db "Contém a letra escrita"
    lenmsgcontem equ $-msgcontem
    
    
section .text
global _start
_start:
  
  xor r8, r8
  mov rax, 0
  mov rdi, 0
  mov rsi, nome
  mov rdx, lennome
  syscall
  
  mov rax, 0
  mov rdi, 0
  mov rsi, letra
  mov rdx, lenletra
  syscall

  ;printando a primeira letra
  mov rax, 1
  mov rdi, 1
  mov rsi, nome 
  mov rdx, 1
  syscall


  ;printando ultima letra
  mov rdi, nome
  mov r9, 0
  .findultima:
    mov al, [rdi + r9]
    cmp al, 0
    je .fim 
    inc r9
    jmp .findultima
  .fim:
    mov r8, [rdi+r9-1]
    mov [ultima], r8
    mov rax, 1
    mov rdi, 1
    mov rsi, ultima
    mov rdx, 1
    syscall
  mov r8, 0
  mov rdi, nome
    
  
  ;Verificando se existe a letra no nome
  .loop:
    mov al, [rdi + r8]
    cmp al, [letra]
    je .possuiLetra
    cmp al, 0
    je .naoPossuiletra
    inc r8
    jmp .loop

  .possuiLetra:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgcontem
    mov rdx, lenmsgcontem
    syscall
      
    mov rax, 60
    xor rdi, rdi
    syscall
  
  .naoPossuiletra:
    mov rax, 1
    mov rdi, 1
    mov rsi, msgnaocontem
    mov rdx, lenmsgnaocontem
    syscall
      
    mov rax, 60
    xor rdi, rdi
    syscall
