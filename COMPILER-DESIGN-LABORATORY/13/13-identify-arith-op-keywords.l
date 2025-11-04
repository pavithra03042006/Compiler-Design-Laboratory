//13. Define a lexical analyzer that identifies commands, arithmetic operators and keywords from a given expression.
%{
#include <stdio.h>
%}

KEYWORD     int|float|char|double|if|else|while|for|return
ARITH_OP    \+|\-|\*|\/
REL_OP      <=|>=|==|!=|<|>
ASSIGN_OP   =
ID          [a-zA-Z_][a-zA-Z0-9_]*
SINGLE_COM  \/\/[^\n]*
MULTI_COM   \/\*([^*]|\*+[^*/])*\*+\/

%%

{KEYWORD}      { printf("Keyword: %s\n", yytext); }
{ARITH_OP}     { printf("Arithmetic Operator: %s\n", yytext); }
{REL_OP}       { printf("Relational Operator: %s\n", yytext); }
{ASSIGN_OP}    { printf("Assignment Operator: %s\n", yytext); }
{ID}           { printf("Identifier/Command: %s\n", yytext); }
[0-9]+         { printf("Constant: %s\n", yytext); }
{SINGLE_COM}   { printf("Single-line Comment: %s\n", yytext); }
{MULTI_COM}    { printf("Multi-line Comment: %s\n", yytext); }
[ \t\n]+       ;
.              ;

%%

int yywrap() { return 1; }

int main() {
    printf("Enter an expression: ");
    yyin = stdin;
    yylex();
    return 0;
}



// Enter an expression: int a = b + 10; // test
// Keyword: int
// Identifier/Command: a
// Assignment Operator: =
// Identifier/Command: b
// Arithmetic Operator: +
// Constant: 10
// Single-line Comment: // test
// /* multi line */
// Multi-line Comment: /* multi line */
// if(a >= 5)
// Keyword: if
// Identifier/Command: a
// Relational Operator: >=
// Constant: 5