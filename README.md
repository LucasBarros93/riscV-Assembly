# ✊📄✂️ Rock-Paper-Scissors in RISC-V Assembly

This is a terminal-based implementation of **Rock, Paper, Scissors**, fully written in **RISC-V Assembly** and designed to run using the [**RARS**](https://github.com/TheThirdOne/rars) simulator.

Made collaboratively by [lucasbarros01](https://github.com/lucasbarros01) and [joaoistfrei](https://github.com/joaoistfrei) as an educational project.

---

## 🎮 Game Features

- Terminal-based **Rock-Paper-Scissors** game
- Fully coded in **RISC-V Assembly**
- Uses **pseudo-random number generation** (RARS syscall `42`)
- Stores match history in a **linked list**
- Prints all rounds played and total wins at the end

---

## 🧠 Game Logic

- Player selects an option: `1 = Rock`, `2 = Paper`, `3 = Scissors`, or `0 = Exit`.
- The computer randomly picks one of the options.
- The game determines the outcome and stores the result.
- When the player exits (`0`), the game:
  - Iterates over the linked list of rounds
  - Prints each play with outcome (Win / Lose / Tie)
  - Displays total victories and total rounds

---

## ▶️ How to Run

1. Open the project in [**RARS**](https://github.com/TheThirdOne/rars).
2. Load the `main.asm` file.
3. Run the program using **F5** or the "Run" button.

Make sure RARS supports **syscall 42** (random number generation) — available in more recent versions.

---

## 💡 Implementation Details

- The game uses **register conventions** to store:
  - `s0` – player's choice
  - `s1` – computer's choice
  - `t0` – match result
  - `t2` – victory counter
  - `t3` – match counter
- Match history is stored in a **singly linked list** allocated dynamically with syscall `9`.
- All printouts use syscall `4` (print string) and `1` (print integer).

---

## 📁 File Structure

```

.
├── main.asm       # Full game implementation in RISC-V
└── .gitignore     # Ignore files (optional)

```

---

## 📷 Example Output

```

\=============================================> PARTIDA 1 <=============================================

Escolha sua opcao:
1 - Pedra
2 - Papel
3 - Tesoura

0 - Sair

1
Pedra x Tesoura
Ganhou!

\[...]

\=============================================> RESULTADOS <=============================================

Pedra x Tesoura - Ganhou!
Papel x Papel - Empate!
Tesoura x Pedra - Perdeu!

\=> Voce ganhou 2 partida(s) de 5

```

---

## 🚧 Limitations

- No input validation: invalid options will behave unpredictably.
- Limited to RARS simulator environment only.
- No UI or graphics — fully ASCII-based terminal output.

---

## 📄 License

This project is for educational purposes only. Feel free to fork and experiment.
