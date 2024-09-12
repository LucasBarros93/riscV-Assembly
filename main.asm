    .data
    .align 0

str_beg: .asciz "Escolha uma opção: \n0. Encerrar\n1. pedra\n2. papel\n3. tesoura\n\n"

str_win: .asciz "Voce Venceu!"
str_los: .asciz "Voce Perdeu!"

    .text
    .align 2
    .globl main

main:
    #print começo
    addi a7, zero, 4
    la a0, str_beg
    ecall

    #lendo numero do usuario
    addi a7, zero, 5
    ecall

    add s0, zero, a0 # s0 = num_usuario
    
    #gerando numero aleatorio
    addi a7, zero, 42
    addi a1, zero, 3
    ecall

    addi s1, a0, 1 # s1 = random_num[1,3]
    
    #DEBUG
    addi a7, zero, 1
    add a0, zero, s1
    ecall

    #encerra programa
    addi a7, zero, 10
    ecall
    
    