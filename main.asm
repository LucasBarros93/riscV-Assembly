    .data
    .align 0

str_beg: .asciz "Escolha uma opção: \n0. Encerrar\n1. pedra\n2. papel\n3. tesoura\n\n"

str_win: .asciz "Voce Venceu!\n\n"
str_los: .asciz "Voce Perdeu!\n\n"
str_drw: .asciz "Empate!\n\n"

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

    beq s0, zero, end # if s0 == 0 then end:
    
    #gerando numero aleatorio
    addi a7, zero, 42
    addi a1, zero, 3
    ecall

    addi s1, a0, 1 # s1 = random_num[1,3]

    # If draw, num_usuario == random_num
    beq s0, s1, draw

    #registrador aux
    sub t0, s0, s1 # t0 = s0 - s1 

    # If win, aux == 1 || aux == -2
    addi t1, zero, 1
    addi t2, zero, -2
    beq t0, t1, win
    beq t0, t2, win

    # If lose, aux == -1 || aux == 2
    addi t1, zero, -1
    addi t2, zero, 2
    beq t0, t1, lose
    beq t0, t2, lose

draw:
    #print empate
    addi a7, zero, 4
    la a0, str_drw
    ecall
    j main #loop
    
win:
    #print win
    addi a7, zero, 4
    la a0, str_win
    ecall
    j main #loop

lose:
    #print lose
    addi a7, zero, 4
    la a0, str_los
    ecall
    j main #loop

    #DEBUG
    # addi a7, zero, 1
    # add a0, zero, s1
    # ecall

    # j main

end:
    #encerra programa
    addi a7, zero, 10
    ecall
    
    