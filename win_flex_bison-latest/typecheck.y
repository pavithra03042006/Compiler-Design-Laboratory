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

%token SEMICOLON IDENTIFIER EQL INT FLOAT CHAR
%token <float_value> NUMBER FLOATVAL
%token <char_value> CHARACTER

%type <float_value> number floatnum
%type <char_value> charval

%%
program:
    /* allow multiple statements */
    | program statement
    ;

statement:
      INT IDENTIFIER EQL number SEMICOLON      { printf("Valid int\n"); }
    | FLOAT IDENTIFIER EQL floatnum SEMICOLON  { printf("Valid float\n"); }
    | CHAR IDENTIFIER EQL charval SEMICOLON    { printf("Valid char\n"); }

    | INT IDENTIFIER EQL floatnum SEMICOLON    { yyerror("int cannot store float"); }
    | CHAR IDENTIFIER EQL number SEMICOLON     { yyerror("char cannot store number"); }
    | FLOAT IDENTIFIER EQL charval SEMICOLON   { yyerror("float cannot store char"); }
    ;

number: NUMBER      { $$ = $1; };
floatnum: FLOATVAL  { $$ = $1; };
charval: CHARACTER  { $$ = $1; };
%%

int main() {
    printf("Enter expression (Press Ctrl+D to end):\n");
  
        yyparse();
  

}

int yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
