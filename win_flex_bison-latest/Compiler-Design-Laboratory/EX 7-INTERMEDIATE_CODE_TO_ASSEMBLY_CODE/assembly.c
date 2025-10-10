#include <stdio.h>
#include <string.h>
#include <conio.h>

void main() {
    char icode[10][30], str[20], opr[10];
    int i = 0;

    printf("\nEnter the set of intermediate code (terminated by 'exit'):\n");

    do {
        scanf("%s", icode[i]);
    } while (strcmp(icode[i++], "exit") != 0);

    printf("\nTarget Code Generation\n");

    i = 0;
    do {
        strcpy(str, icode[i]);

        // Operator identification
        switch (str[3]) {
            case '+': strcpy(opr, "ADD"); break;
            case '-': strcpy(opr, "SUB"); break;
            case '*': strcpy(opr, "MUL"); break;
            case '/': strcpy(opr, "DIV"); break;
            default : strcpy(opr, "");   break;
        }

        // Assembly-like target code
        printf("\n\tMov %c, R%d", str[2], i);   // Load second operand into register
        printf("\n\t%s %c, R%d", opr, str[4], i); // Perform operation
        printf("\n\tMov R%d, %c", i, str[0]);   // Store result in destination variable

    } while (strcmp(icode[++i], "exit") != 0);

    getch();
}
