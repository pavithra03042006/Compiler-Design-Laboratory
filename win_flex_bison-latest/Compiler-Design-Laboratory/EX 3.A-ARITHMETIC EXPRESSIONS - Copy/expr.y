%{
#include <stdio.h>
#include <stdlib.h>
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%

expr:
      expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | NUM
    ;

%%

int main() {
    printf("Enter an expression: ");
    if (yyparse() == 0)
        printf("Valid expression.\n");
    return 0;
}

int yyerror(const char *s) {
    printf("Invalid expression\n");
    exit(1);
    return 0;
}
