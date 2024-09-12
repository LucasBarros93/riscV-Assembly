    .data
    .align 0

str_beg: .asciz "Escolha uma opção: \n0. Encerrar\n1. pedra\n2. papel\n3. tesoura"

str_w: .asciz "Voce Venceu!"
str_l: .asciz "Voce Perdeu!"

    .text
    .align 2
    .globl main

main:
    #print começo
    addi a7, zero, 4
    la a0, str_beg
    ecall

    

    addi a7, zero, 10
    ecall
    
    