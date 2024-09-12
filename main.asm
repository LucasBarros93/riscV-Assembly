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
    addi a7, zero, 41
    ecall

    add s1, zero, a0 # s1 = random_num //GIGANTE
    
    #arrumando pra random_num e {-1,0,1}
    addi t1, zero, 3 
    div t0, s1, t1
    mul t0, t1, t0

    sub s2, s1, t0 #s2 = random_num{-1,0,1}

    addi a7, zero, 1
    add a0, zero, s2
    ecall

    addi a7, zero, 10
    ecall
    
    