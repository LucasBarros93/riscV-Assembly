    .data
    .align 0

str_beg: .asciz "Escolha uma opção: \n0. Encerrar\n1. pedra\n2. papel\n3. tesoura\n\n"

str_win: .asciz "\n\nVoce Venceu!\n\n"
str_los: .asciz "\n\nVoce Perdeu!\n\n"
str_drw: .asciz "\n\nEmpate!\n\n"

str_x: .asciz " x "
str_r: .asciz "pedra"
str_p: .asciz "papel"
str_s: .asciz "tesoura"

    .text
    .align 2
    .globl main

main:
    #ENTRADAS
    #print começo
    addi a7, zero, 4
    la a0, str_beg
    ecall

    #lendo numero do usuario
    addi a7, zero, 5
    ecall

    add s0, zero, a0 # s0 = num_usuario

    beq s0, zero, end # if s0 == 0 then end:
    
    #gerando numero aleatorio
    addi a7, zero, 42
    addi a1, zero, 3
    ecall

    addi s1, a0, 1 # s1 = random_num[1,3]



print_game:
    # PRINT JOGO
    addi t1, zero, 1
    addi t2, zero, 2
    addi t3, zero, 3

    beq s0, t1, rock_p
    beq s0, t2, paper_p
    beq s0, t3, scissor_p

x:
    #print x
    addi a7, zero, 4
    la a0, str_x
    ecall

    beq s1, t1, rock_c
    beq s1, t2, paper_c
    beq s1, t3, scissor_c

rock_p:
    #print pedra
    addi a7, zero, 4
    la a0, str_r
    ecall
    j x

scissor_p:
    #print tesoura
    addi a7, zero, 4
    la a0, str_s
    ecall
    j x

paper_p:
    #print papel
    addi a7, zero, 4
    la a0, str_p
    ecall
    j x

rock_c:
    #print pedra
    addi a7, zero, 4
    la a0, str_r
    ecall
    j res

scissor_c:
    #print tesoura
    addi a7, zero, 4
    la a0, str_s
    ecall
    j res

paper_c:
    #print papel
    addi a7, zero, 4
    la a0, str_p
    ecall
    j res



res:
    # RESULTADO DA PARTIDA
    # If draw, num_usuario == random_num
    beq s0, s1, draw

    #registrador aux
    sub s2, s0, s1 # s2 = s0 - s1 

    # If win, aux == 1 || aux == -2
    addi t1, zero, 1
    addi t2, zero, -2
    beq s2, t1, win
    beq s2, t2, win

    # If lose, aux == -1 || aux == 2
    addi t1, zero, -1
    addi t2, zero, 2
    beq s2, t1, lose
    beq s2, t2, lose

draw:
    #print empate
    addi a7, zero, 4
    la a0, str_drw
    ecall

    #espera 1s
    addi a7, zero, 32
    addi a0, zero, 1000
    ecall

    ecall
    j main #loop
    
win:
    #print win
    addi a7, zero, 4
    la a0, str_win
    ecall
    
    #espera 1s
    addi a7, zero, 32
    addi a0, zero, 1000
    ecall

    j main #loop

lose:
    #print lose
    addi a7, zero, 4
    la a0, str_los
    ecall

    #espera 1s
    addi a7, zero, 32
    addi a0, zero, 1000
    ecall

    j main #loop




end:
    #encerra programa
    addi a7, zero, 10
    ecall
    
    