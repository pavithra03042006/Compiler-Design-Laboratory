//11. Given intermediate code as input, develop a program that generates the corresponding machine code.
#include <stdio.h>
#include <string.h>

void main() {
    char icode[20][50], op[10];
    int i = 0;

    printf("Enter the Intermediate Code (type 'exit' to finish):\n");

    // Input intermediate code lines
    do {
        scanf(" %[^\n]", icode[i]);
    } while (strcmp(icode[i++], "exit") != 0);

    printf("\nGenerated Machine Code:\n");

    i = 0;
    do {
        // ----- IF condition -----
        if (strncmp(icode[i], "if", 2) == 0) {
            char op1, op2, relop[3], label[10];
            sscanf(icode[i], "if %c %s %c goto %s", &op1, relop, &op2, label);

            if (strcmp(relop, "<") == 0)
                strcpy(op, "JLT");
            else if (strcmp(relop, "<=") == 0)
                strcpy(op, "JLE");
            else if (strcmp(relop, ">") == 0)
                strcpy(op, "JGT");
            else if (strcmp(relop, ">=") == 0)
                strcpy(op, "JGE");
            else if (strcmp(relop, "==") == 0)
                strcpy(op, "JE");
            else if (strcmp(relop, "!=") == 0)
                strcpy(op, "JNE");
            else
                strcpy(op, "JMP");

            printf("\n\tCMP %c, %c", op1, op2);
            printf("\n\t%s %s", op, label);
        }

        // ----- Label (e.g. L1:) -----
        else if (icode[i][strlen(icode[i]) - 1] == ':') {
            printf("\n%s", icode[i]);
        }

        // ----- Goto statement -----
        else if (strncmp(icode[i], "goto", 4) == 0) {
            char label[10];
            sscanf(icode[i], "goto %s", label);
            printf("\n\tJMP %s", label);
        }

        // ----- Arithmetic / Assignment (e.g. c=a+b) -----
        else if (strchr(icode[i], '=') != NULL) {
            char res, op1, op2, opr;
            sscanf(icode[i], "%c=%c%c%c", &res, &op1, &opr, &op2);

            switch (opr) {
                case '+': strcpy(op, "ADD"); break;
                case '-': strcpy(op, "SUB"); break;
                case '*': strcpy(op, "MUL"); break;
                case '/': strcpy(op, "DIV"); break;
                default : strcpy(op, "MOV"); break;
            }

            // Assembly-like code (using register i)
            printf("\n\tMOV %c, R%d", op1, i);
            if (opr != '=') {
                printf("\n\t%s %c, R%d", op, op2, i);
            }
            printf("\n\tMOV R%d, %c", i, res);
        }

    } while (strcmp(icode[++i], "exit") != 0);
}



/*
Enter the Intermediate Code (type 'exit' to finish):
a=5
b=10
if a<10 goto L1
goto L2
L1:
c=a+b
L2:
exit

Generated Machine Code:

        MOV 5, R0
        MOV ┬, R0
        MOV R0, a
        MOV 1, R1
        MOV ┬, R1
        MOV R1, b
        CMP a, g
        JMP
        JMP L2
L1:
        MOV a, R5
        ADD b, R5
        MOV R5, c
L2:

*/ 