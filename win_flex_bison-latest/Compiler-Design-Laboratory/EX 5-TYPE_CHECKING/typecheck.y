%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(const char *msg);
%}

%union {
    char char_value;
    float float_value;
}

%token SEMICOLON IDENTIFIER EQL NUMBER INT FLOAT CHAR FLOATVAL CHARACTER
%type <float_value> number floatnum
%type <char_value> charval

%%
program:
      INT IDENTIFIER EQL number SEMICOLON      { printf("Valid int\n"); }
    | FLOAT IDENTIFIER EQL floatnum SEMICOLON  { printf("Valid float\n"); }
    | CHAR IDENTIFIER EQL charval SEMICOLON    { printf("Valid char\n"); }

    | INT IDENTIFIER EQL floatnum SEMICOLON    { yyerror("int cannot store float"); }
    | CHAR IDENTIFIER EQL number SEMICOLON     { yyerror("char cannot store number"); }
    | FLOAT IDENTIFIER EQL charval SEMICOLON   { yyerror("float cannot store char"); }
    ;

number: NUMBER ;
floatnum: FLOATVAL | NUMBER ;
charval: CHARACTER ;
%%

int main() { return yyparse(); }
int yyerror(const char* s) { fprintf(stderr,"Error: %s\n", s); return 0; }
