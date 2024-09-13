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
# s2 -> registrador com valor fixo de 1
# s3 -> registrador com valor fixo de 2
# s4 -> registrador com valor fixo de -1
# s5 -> registrador com valor fixo de -2
# s6 -> registrador com valor fixo de 3
# s7 -> 
# s8 -> 
# s9 -> 
# s10 -> ponteiro pra o ultimo no da lista
# s11 -> ponteiro para o começo da lista

# t0 -> resultado numérico da partida
# t1 -> no atual da lista
# t2 -> 
# t3 -> 
# t4 -> 
# t5 -> 
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
    

# ================================================> escolhas <============================================

    addi s2, zero, 1
    addi s3, zero, 2
    addi s4, zero, -1
    addi s5, zero, -2
    addi s6, zero, 3

    sub t0, s0, s1
    beq t0, zero, empate
    beq t0, s2, ganhou
    beq t0, s5, ganhou
    beq t0, s3, perdeu
    beq t0, s4, perdeu

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

    jal ra, adicionaNo
    j main

# ==========================================================> fim <==========================================

fim:    

    addi a7, zero, 10
    ecall

# ===========================================> decidindo impressao <===================================================

escolhaJogador:
    beq s0, s2, pedra
    beq s0, s3, papel
    beq s0, s6, tesoura

escolhaPC:
    beq s1, s2, pedra
    beq s1, s3, papel
    beq s1, s6, tesoura

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
    addi a0, zero, 16
    addi a7, zero, 9
    ecall   #reserva 16 espaços de mempria em a0

    mv t6, a0  #t6 é o novo no

    sw s0, 0(t6)    #salva o valor do playerem t6
    sw s1, 4(t6)    #salva o valor do pc em t6
    sw t0, 8(t6)    #salva o valor do resultado em t6
    sw zero, 12(t6)  #proximo no depois de t6 e NULL (ultimo no)

    la s11, head    #olha pra cabeca da lista
    lw t1, 0(s11)   #olha o conteudo da cabeca

    beq t1, zero, primeiroNo    #se o conteudo for NULL(0), esse eh o primeiro no

    mv t1, s10 #t1 = ultimo no (s10)
    sw t6, 12(t1) #proximo no do ultimo(t1) é o novo(t6)

    mv s10, t6 #ultimo no (s10) eh t6

    jr ra


primeiroNo:
    sw t6, 0(s11) #cabeca aponta pra novo no (t6)
    mv s10, t6 #ultimo no (s10) eh t6

    jr ra

# =============================================> print lista encadeada <=============================================

printaLista:
    la s11, head #olha pra cabeca da lista
    lw t1, 0(s11) #olha o conteudo da cabeca

    beq t1, zero, listaVazia #se o conteudo for NULL(0), a lista ta vazia
    j printLoop

printLoop:
    beq t1, zero, fim #se o no atual(t1) eh vazio, acabou a lista
    
    lw s0, 0(t1)    #carreaga o conteudo do no atual (t1) em s0
    lw s1, 4(t1)    #carreaga o conteudo do no atual (t1) em s1
    lw t0, 8(t1)    #carreaga o conteudo do no atual (t1) em t0

    #print
    jal ra, escolhaJogador
    jal ra, imprimeX
    jal ra, escolhaPC

    jal delay

    lw t1, 12(t1) #no atual (t1) = proximo no 
    j printLoop
    

listaVazia:
    j fim