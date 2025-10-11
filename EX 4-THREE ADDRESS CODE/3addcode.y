%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 0;

char* newTemp() {
    char *temp = (char*)malloc(5);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}
%}

%union { char* str; }
%token <str> ID NUM
%type <str> expr

%left '+' '-'
%left '*' '/'

%%

input:
      stmt { printf("\n"); }
    ;

stmt:
      expr ';'           {}
    | ID '=' expr ';' { printf("%s = %s\n", $1, $3); }
    | ID '=' expr     { printf("%s = %s\n", $1, $3); }
    ;

expr: expr '+' expr {
          char* t = newTemp();
          printf("%s = %s + %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '-' expr {
          char* t = newTemp();
          printf("%s = %s - %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '*' expr {
          char* t = newTemp();
          printf("%s = %s * %s\n", t, $1, $3);
          $$ = t;
      }
    | expr '/' expr {
          char* t = newTemp();
          printf("%s = %s / %s\n", t, $1, $3);
          $$ = t;
      }
    | ID   { $$ = $1; }
    | NUM  { $$ = $1; }
;

%%

int main() {
    printf("Enter expressions (Press Ctrl+C to exit):\n");
    while(1) {
        printf("> ");
        yyparse();
    }
    return 0;
}

int yyerror(char *s) {
    printf("Exiting...");
    return 0;
}
