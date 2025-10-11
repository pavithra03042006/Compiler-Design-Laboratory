%{
#include "typecheck.tab.h"
#include <stdlib.h>
%}

%%
"int"       { return INT; }
"float"     { return FLOAT; }
"char"      { return CHAR; }
"="         { return EQL; }
";"         { return SEMICOLON; }
[0-9]+      { yylval.float_value = atof(yytext); return NUMBER; }
[0-9]+\.[0-9]+ { yylval.float_value = atof(yytext); return FLOATVAL; }
\'[a-zA-Z0-9]\' { yylval.char_value = yytext[1]; return CHARACTER; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[ \t\n]    ;   /* ignore spaces and newlines */
.          { return yytext[0]; }
%%

int yywrap() { return 0; }
