%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
int result;  // store result of last evaluation
%}

%token NUM
%left '+' '-'
%left '*' '/'

%%

input:
    /* empty */
  | input line
  ;

line:
    E '\n' { printf("Result is:%d\n", result); }
  ;

E : E '+' E   { $$ = $1 + $3; result = $$; }
  | E '-' E   { $$ = $1 - $3; result = $$; }
  | E '*' E   { $$ = $1 * $3; result = $$; }
  | E '/' E   { $$ = $1 / $3; result = $$; }
  | '(' E ')' { $$ = $2; result = $$; }
  | NUM       { $$ = $1; result = $$; }
  ;

%%

int main() {
    printf("enter expression(Press ctrl+C to end):\n");
    yyparse();  // parse until EOF
    printf("Exited...\n");
    return 0;
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}