// 18. Design a program to generate 3-address code from a given arithmetic expression

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int tCount = 1; // temp variable counter

// Forward declaration
char* genTAC(char* exp, int start, int end);

// Function to find main operator (lowest precedence)
int findMainOp(char* exp, int start, int end) {
    int minPrec = 10, pos = -1, paren = 0;

    for (int i = start; i <= end; i++) {
        if (exp[i] == '(') paren++;
        else if (exp[i] == ')') paren--;
        else if (paren == 0) {
            int prec = -1;
            if (exp[i] == '+' || exp[i] == '-') prec = 1;
            else if (exp[i] == '*' || exp[i] == '/') prec = 2;

            if (prec != -1 && prec <= minPrec) {
                minPrec = prec;
                pos = i;
            }
        }
    }
    return pos;
}

// Generate TAC recursively
char* genTAC(char* exp, int start, int end) {
    // remove outer parentheses
    while (exp[start] == '(' && exp[end] == ')') {
        start++;
        end--;
    }

    int opPos = findMainOp(exp, start, end);

    // Base case — single operand
    if (opPos == -1) {
        char* res = (char*)malloc(end - start + 2);
        strncpy(res, exp + start, end - start + 1);
        res[end - start + 1] = '\0';
        return res;
    }

    // Recursive case — split around operator
    char* left = genTAC(exp, start, opPos - 1);
    char* right = genTAC(exp, opPos + 1, end);

    char* temp = (char*)malloc(5);
    sprintf(temp, "t%d", tCount++);

    printf("%s = %s %c %s\n", temp, left, exp[opPos], right);

    free(left);
    free(right);
    return temp;
}

int main() {
    char exp[100];
    printf("Enter arithmetic expression: ");
    scanf("%s", exp);

    printf("\nThree-Address Code:\n");
    genTAC(exp, 0, strlen(exp) - 1);

    return 0;
}

// Enter arithmetic expression: a+b*c

// Three-Address Code:
// t1 = b * c
// t2 = a + t1

// D:\compiler-lab-model-1\18>18-TAC.exe
// Enter arithmetic expression: a+b-c*d/e

// Three-Address Code:
// t1 = a + b
// t2 = c * d
// t3 = t2 / e
// t4 = t1 - t3