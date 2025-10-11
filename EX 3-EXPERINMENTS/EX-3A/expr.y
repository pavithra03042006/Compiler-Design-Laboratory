%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyerror(const char *s);
%}

%token NUM
%left '+' '-'   // lowest precedence
%left '*' '/'   // higher precedence

%%

input:
      /* empty */
    | input line
    ;

line:
      expr '\n'   { printf("Valid Expression\n"); }
    | error '\n'  { printf("Invalid Expression\n"); yyerrok; }
    ;

expr:
      expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'     // parentheses
    | NUM
    | '(' '-' expr ')' // unary minus **only inside parentheses**
    ;

%%

int main() {
    printf("Enter arithmetic expressions (Ctrl+D to end):\n");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    return 0; // continue parsing
}
