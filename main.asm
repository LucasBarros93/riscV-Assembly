    .data
    .align 0

str1: .asciz "Escolha sua opcao:\n1 - Pedra\n2 - Papel\n3 - Tesoura\n\n0 - Sair\n\n"
strEmpate: .asciz "Empate!\n"
strGanhou: .asciz "Ganhou!\n"
strPerdeu: .asciz "Perdeu!\n"

strPedra: .asciz "Pedra"
strPapel: .asciz "Papel"
strTesoura: .asciz "Tesoura"
strX: .asciz " x "
strEnter: .asciz "\n"

head: .word 0

    .text
    .align 2


# s0 -> escolha do usuário
# s1 -> escolha do PC
# s2 -> 
# s3 -> 
# s4 -> 
# s5 -> 
# s6 -> 
# s7 -> 
# s8 -> 
# s9 -> 
# s10 -> ponteiro pra o ultimo no da lista
# s11 -> ponteiro para o começo da lista

# t0 -> resultado numérico da partida
# t1 -> registrador com valor fixo de 1
# t2 -> registrador com valor fixo de 2
# t3 -> registrador com valor fixo de -1
# t4 -> registrador com valor fixo de -2
# t5 -> registrador com valor fixo de 3
# t6 -> cria nó da lista

    .global main

main:

    # imprimir as opcoes na tela
    addi a7, zero, 4 
    la a0, str1
    ecall

    # Lendo escolha do usuario
    addi a7, zero, 5
    ecall
    add s0, zero, a0  # salvando em s0

    beq s0, zero, printaLista

# =========================================> gerando numero aleatorio <====================================

    addi a1, zero, 3
    addi a7, zero, 42
    ecall

    addi s1, a0, 1
    
    jal ra, adicionaNo

# ================================================> escolhas <============================================

    addi t1, zero, 1
    addi t2, zero, 2
    addi t3, zero, -1
    addi t4, zero, -2
    addi t5, zero, 3

    sub t0, s0, s1
    beq t0, zero, empate
    beq t0, t1, ganhou
    beq t0, t4, ganhou
    beq t0, t2, perdeu
    beq t0, t3, perdeu

# ==========================================> analisar vitoria <================================================

empate:
    addi a7, zero, 4
    la a0, strEmpate
    ecall
    j imprimeEscolhas

ganhou:
    addi a7, zero, 4
    la a0, strGanhou
    ecall
    j imprimeEscolhas

perdeu:
    addi a7, zero, 4
    la a0, strPerdeu
    ecall
    j imprimeEscolhas

# =============================================> opcoes de impressao <=============================================

imprimeEscolhas:
    jal ra, escolhaJogador
    jal ra, imprimeX
    jal ra, escolhaPC

    jal ra, delay

    j main

# ==========================================================> fim <==========================================

fim:    

    addi a7, zero, 10
    ecall

# ===========================================> decidindo impressao <===================================================

escolhaJogador:
    beq s0, t1, pedra
    beq s0, t2, papel
    beq s0, t5, tesoura

escolhaPC:
    beq s1, t1, pedra
    beq s1, t2, papel
    beq s1, t5, tesoura

# =============================================> opcoes de impressao <=============================================

pedra:
    addi a7, zero, 4
    la a0, strPedra
    ecall

    jr ra

papel:
    addi a7, zero, 4
    la a0, strPapel
    ecall

    jr ra

tesoura:
    addi a7, zero, 4
    la a0, strTesoura
    ecall

    jr ra

imprimeX: 
    addi a7, zero, 4
    la a0, strX
    ecall

    jr ra

# =============================================> enter e delay <=============================================
delay:
    addi a7, zero, 4
    la a0, strEnter
    ecall #imprime enter
    ecall #imprime enter

    addi a7, zero, 32
    addi a0, zero, 1000
    ecall #dalay de 1s

    jr ra

# =============================================> add lista encadeada <=============================================

adicionaNo:
    addi a0, zero, 8
    addi a7, zero, 9
    ecall   #reserva 8 espaços de mempria em a0

    mv t6, a0  #t6 é o novo no

    sw s1, 0(t6)    #salva o valor em t6
    sw zero, 4(t6)  #proximo no depois de t6 e NULL (ultimo no)

    la s11, head    #olha pra cabeca da lista
    lw s9, 0(s11)   #olha o conteudo da cabeca

    beq s9, zero, primeiroNo    #se o conteudo for NULL(0), esse eh o primeiro no

    mv s9, s10
    sw t6 4(s9)

    mv s10, t6

    jr ra


primeiroNo:
    sw t6, 0(s11)
    mv s10, t6

    jr ra

# =============================================> print lista encadeada <=============================================

printaLista:
    la s11, head
    lw s9, 0(s11)

    beq s9, zero, listaVazia
    j printLoop

printLoop:
    beq s9, zero, fim
    lw t6, 0 (s9)

    #print
    add a0, zero, t6
    addi a7, zero, 1
    ecall

    jal delay

    lw s9, 4(s9)
    j printLoop
    

listaVazia:
    j fim