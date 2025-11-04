//3.	Develop a C program to eliminate left recursion from a grammar.

#include <stdio.h>
#include <string.h>

int main() {
    char in[100], nt, alpha[10][10], beta[10][10];
    int i = 0, j = 0, k = 0, n;

    printf("Enter production (Example: A=Ab|c): ");
    scanf("%s", in);

    nt = in[0];   // Non-terminal
    i = 2;        // Skip 'A='

    while (in[i] != '\0') {
        n = 0;
        if (in[i] == nt) {     // Left recursive part
            i++;
            while (in[i] != '|' && in[i] != '\0')
                alpha[j][n++] = in[i++];
            alpha[j++][n] = '\0';
        } else {               // Non-left recursive part
            while (in[i] != '|' && in[i] != '\0')
                beta[k][n++] = in[i++];
            beta[k++][n] = '\0';
        }
        if (in[i] == '|') i++;
    }

    if (j == 0)
        printf("No Left Recursion found!\n");
    else {
        printf("\nAfter eliminating Left Recursion:\n");
        printf("%c -> %s%c'\n", nt, beta[0], nt);
        printf("%c' -> %s%c' | e\n", nt, alpha[0], nt);
    }

    return 0;
}


//Enter production (Example: A=Ab|c): A=Ab|c
//
//After eliminating Left Recursion:
//A -> cA'
//A' -> bA' | e

