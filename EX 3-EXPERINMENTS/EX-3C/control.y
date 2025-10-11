%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();
%}

%token IF ELSE FOR WHILE SWITCH CASE
%token SEMICOLON LBRACE RBRACE LPAREN RPAREN ID EOL COLON

%%

input:
        | input line
    ;

line:
        statement EOL      { printf("Valid control structure.\n\n"); }
    |   error EOL          { printf("Invalid syntax.\n\n"); yyerrok; }
    |   EOL                { /* empty line, ignore */ }
    ;

statement:
        IF LPAREN ID RPAREN block ELSE block
    |   IF LPAREN ID RPAREN block
    |   WHILE LPAREN ID RPAREN block
    |   FOR LPAREN ID SEMICOLON ID SEMICOLON ID RPAREN block
    |   SWITCH LPAREN ID RPAREN LBRACE cases RBRACE
    ;

block:
        LBRACE RBRACE
    |   LBRACE statements RBRACE
    ;

statements:
        statement
    |   statements statement
    ;

cases:
        CASE ID COLON statements
    |   cases CASE ID COLON statements
    ;

%%

void yyerror(const char *s) {
}

int main() {
    printf("Enter control structure (Ctrl+C to end): \n\n");
    yyparse();
    return 0;
}
