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

.text
.align 2
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

    beq a0, zero, fim

# ========================================= gerando numero aleatorio ====================================

    addi a0, zero, 0
    addi a1, zero, 3
    addi a7, zero, 42
    ecall

    addi s1, a0, 1

# ================================================> escolhas <============================================

    addi t1, zero, 1
    addi t2, zero, 2
    addi t3, zero, -1
    addi t4, zero, -2
    addi t5, zero, 0
    addi t6, zero, 3

    sub t0, s0, s1
    beq t0, zero, empate
    beq t0, t3, perdeu
    beq t0, t4, ganhou
    beq t0, t1, ganhou
    beq t0, t2, perdeu

# ========================================== analisar vitoria ================================================

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

# ============================================= opcoes de impressao =============================================

imprimeEscolhas:
    jal ra, escolhaJogador
    jal ra, imprimeX
    jal ra, escolhaPC

    j fim

# ==========================================================> fim < ==========================================

fim:    
    addi a7, zero, 4
    la a0, strEnter
    ecall

    addi a7, zero, 10
    ecall

# =========================================== decidindo impressao ===================================================

escolhaJogador:
    beq s0, t1, pedra
    beq s0, t2, papel
    beq s0, t6, tesoura

escolhaPC:
    beq s1, t1, pedra
    beq s1, t2, papel
    beq s1, t6, tesoura

# ============================================= opcoes de impressao =============================================

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
