%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token ID
%token INVALID

%%

input:
      /* empty */
    | input line
    ;

line:
      ID '\n'       { printf("Valid variable name\n"); }
    | INVALID '\n'  { printf("Invalid variable name\n");}
    | error '\n'    { printf("Invalid variable name\n"); yyerror; }
    ;

%%

int main() {
    printf("Enter variable names (Ctrl+C to end):\n");

    yyparse();  // yyparse will automatically loop until EOF
    printf("\nExited.\n");
    return 0;
}

int yyerror(const char *s) {
    return 0; // continue parsing
}
