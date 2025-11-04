//06. Develop a C program to design a lexical analyzer that recognizes identifiers and constants.

#include <stdio.h>
#include <string.h>
#include <ctype.h>

int isKeyword(char word[]) {
    char *keywords[] = {"int", "float", "char", "double", "if", "else", "while", "for", "return"};
    int n = 9;
    for(int i = 0; i < n; i++)
        if(strcmp(word, keywords[i]) == 0)
            return 1;
    return 0;
}

int main() {
    char input[100], token[30];
    int i = 0, j = 0;

    printf("Enter a statement: ");
    fgets(input, sizeof(input), stdin);

    while(input[i] != '\0') {
        if(isalnum(input[i])) {
            token[j++] = input[i];
        } 
        else {
            if(j > 0) {
                token[j] = '\0';
                if(isKeyword(token))
                    printf("%s : Keyword\n", token);
                else if(isdigit(token[0]))
                    printf("%s : Constant\n", token);
                else
                    printf("%s : Identifier\n", token);
                j = 0;
            }
            if(strchr("=+-*/;", input[i]))
                printf("%c : Operator\n", input[i]);
        }
        i++;
    }
    return 0;
}

/*
Sample Output:
Enter a statement: int a=10
int : Keyword
a : Identifier
= : Operator
10 : Constant
*/


// Enter a statement: int a=10
// int : Keyword
// a : Identifier
// = : Operator
// 10 : Constant
