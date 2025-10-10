%{
#include <stdio.h>
#include <stdlib.h>
%}

%token VALID INVALID

%%

input:
      input line
    | line
    ;

line:
      VALID    { printf("Valid variable: %s\n", yytext); }
    | INVALID  { printf("Invalid variable: %s\n", yytext); }
    ;

%%

int main() {
    printf("Enter variable names (press Ctrl+D to end):\n");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    return 0; 
}
