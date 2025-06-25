# test.asm — Program to test RISCape
# Final result: should store 0xABCDE02E at memory address 132 (0x84)

main:     addi x2, x0, 5         # x2 = 5
          addi x3, x0, 12        # x3 = 12
          addi x7, x3, -9        # x7 = (12 - 9) = 3
          or   x4, x7, x2        # x4 = (3 OR 5) = 7
          xor  x5, x3, x4        # x5 = (12 XOR 7) = 11
          add  x5, x5, x4        # x5 = (11 + 7) = 18
          beq  x5, x7, end       # not taken
          slt  x4, x3, x4        # x4 = (12 < 7) = 0
          beq  x4, x0, around    # taken
          addi x5, x0, 0         # skipped

around:   slt  x4, x7, x2        # x4 = (3 < 5) = 1
          add  x7, x4, x5        # x7 = (1 + 18) = 19
          sub  x7, x7, x2        # x7 = (19 - 5) = 14
          sw   x7, 84(x3)        # [96] = 14
          lw   x2, 96(x0)        # x2 = [96] = 14
          add  x9, x2, x5        # x9 = (14 + 18) = 32
          jal  x3, end           # x3 = 0x44, jump to end
          addi x2, x0, 1         # skipped

end:      add  x2, x2, x9        # x2 = (14 + 32) = 46
          addi x4, x0, 1         # x4 = 1
          lui  x5, 0x80000       # x5 = 0x80000000
          slt  x6, x5, x4        # x6 = (x5 < 1) = 1 (signed compare)
wrong:    beq  x6, x0, wrong     # not taken
          lui  x9, 0xABCDE       # x9 = 0xABCDE000
          add  x2, x2, x9        # x2 = 0xABCDE02E
          sw   x2, 0x40(x3)      # mem[132] = 0xABCDE02E
done:     beq  x2, x2, done      # infinite loop