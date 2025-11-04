//15. Write a lex program to scan variables, reserved words and operators of clang

%{
#include <stdio.h>
%}

/* Regular Expressions for tokens */
KEYWORD     int|float|char|double|if|else|while|for|return
IDENTIFIER  [a-zA-Z_][a-zA-Z0-9_]*
CONSTANT    [0-9]+(\.[0-9]+)?
OPERATOR    [=+\-*/;]

%%

{KEYWORD}       { printf("%s : Keyword\n", yytext); }
{IDENTIFIER}    { printf("%s : Identifier\n", yytext); }
{CONSTANT}      { printf("%s : Constant\n", yytext); }
{OPERATOR}      { printf("%s : Operator\n", yytext); }
[ \t\n]+        { /* ignore whitespace */ }
.               { printf("%s : Unknown\n", yytext); }

%%

int yywrap() { return 1; }

int main() {
    printf("Enter a statement: ");
    yylex();
    return 0;
}

//Enter a statement: int a=10
//int : Keyword
//a : Identifier
//= : Operator
//10 : Constant

//float l=10
//float : Keyword
//l : Identifier
//= : Operator
//10 : Constant

//int a=b+10
//int : Keyword
//a : Identifier
//= : Operator
//b : Identifier
//+ : Operator
//10 : Constant