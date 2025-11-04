// 5. Design a top down parser which generates a parsing table with no backtracking
#include <stdio.h>
#include <string.h>

#define MAX 50

char *NT[] = {"E", "E'", "T", "T'", "F"};
char *T[]  = {"id", "+", "*", "(", ")", "$"};
char *table[5][6];
char stack[MAX][10];
int top = -1;

// Stack operations
void push(char *s) { strcpy(stack[++top], s); }
char* pop() { return stack[top--]; }
char* peek() { return stack[top]; }

// Find index of Non-terminal
int ntIndex(char *s) {
    int i;
    for (i = 0; i < 5; i++)
        if (!strcmp(NT[i], s)) return i;
    return -1;
}

// Find index of Terminal
int tIndex(char *s) {
    int i;
    for (i = 0; i < 6; i++)
        if (!strcmp(T[i], s)) return i;
    return -1;
}

// Initialize parsing table
void initTable() {
    int i, j;
    for (i = 0; i < 5; i++)
        for (j = 0; j < 6; j++)
            table[i][j] = NULL;

    table[0][0] = table[0][3] = "T E'";
    table[1][1] = "+ T E'";
    table[1][4] = table[1][5] = "#";
    table[2][0] = table[2][3] = "F T'";
    table[3][2] = "* F T'";
    table[3][1] = table[3][4] = table[3][5] = "#";
    table[4][0] = "id";
    table[4][3] = "( E )";
}

// Display parsing table
void printTable() {
    int i, j;
    printf("Parsing Table:\n%-5s", "NT/T");
    for (j = 0; j < 6; j++) printf("%-10s", T[j]);
    printf("\n");

    for (i = 0; i < 5; i++) {
        printf("%-5s", NT[i]);
        for (j = 0; j < 6; j++)
            printf("%-10s", table[i][j] ? table[i][j] : "-");
        printf("\n");
    }
}

// Main program
int main() {
    char input[100], tokens[20][10];
    int n = 0, i, j, k;

    initTable();
    printTable();

    printf("\nEnter input string (tokens separated by space, end with $):\n");
    fgets(input, sizeof(input), stdin);

    // Split input into tokens
    {
        char *p = strtok(input, " \n");
        while (p) {
            strcpy(tokens[n++], p);
            p = strtok(NULL, " \n");
        }
    }

    push("$");
    push("E");

    printf("\n%-30s%-30s%-20s\n", "Stack", "Input", "Action");

    i = 0;
    while (top >= 0) {
        char *X = peek();
        char *a = tokens[i];
        printf("%-30s%-30s", X, a);

        if (!strcmp(X, a)) { // terminal match
            pop();
            i++;
            printf("%-20s\n", "Match terminal");
        }
        else if (ntIndex(X) != -1) { // non-terminal
            char *prod = table[ntIndex(X)][tIndex(a)];
            if (!prod) {
                printf("%-20s\n", "Error! No rule");
                return 0;
            }
            pop();

            if (strcmp(prod, "#")) { // not epsilon
                char rhs[50];
                char *sym[10];
                strcpy(rhs, prod);
                k = 0;

                // Split RHS and push in reverse
                {
                    char *p = strtok(rhs, " ");
                    while (p) {
                        sym[k++] = p;
                        p = strtok(NULL, " ");
                    }
                }
                for (j = k - 1; j >= 0; j--)
                    push(sym[j]);
            }
            printf("%-20s\n", prod);
        }
        else {
            printf("%-20s\n", "Error! Unexpected symbol");
            return 0;
        }
    }

    if (strcmp(tokens[i - 1], "$"))
        printf("\nInput REJECTED.\n");
    else
        printf("\nInput ACCEPTED by grammar.\n");

    return 0;
}

//
//Parsing Table:
//NT/T id        +         *         (         )         $
//E    T E'      -         -         T E'      -         -
//E'   -         + T E'    -         -         #         #
//T    F T'      -         -         F T'      -         -
//T'   -         #         * F T'    -         #         #
//F    id        -         -         ( E )     -         -
//
//Enter input string (tokens separated by space, end with $):
//id * ( id + id ) $
//
//Stack                         Input                         Action
//E                             id                            T E'
//T                             id                            F T'
//F                             id                            id
//id                            id                            Match terminal
//T'                            *                             * F T'
//*                             *                             Match terminal
//F                             (                             ( E )
//(                             (                             Match terminal
//E                             id                            T E'
//T                             id                            F T'
//F                             id                            id
//id                            id                            Match terminal
//T'                            +                             #
//E'                            +                             + T E'
//+                             +                             Match terminal
//T                             id                            F T'
//F                             id                            id
//id                            id                            Match terminal
//T'                            )                             #
//E'                            )                             #
//)                             )                             Match terminal
//T'                            $                             #
//E'                            $                             #
//$                             $                             Match terminal
//
//Input ACCEPTED by grammar.
