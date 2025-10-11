

%{
#include "calc.tab.h"
#include <stdlib.h>
%}

%%
[0-9]+      { yylval = atoi(yytext); return NUM; }
[ \t]       ;  // ignore spaces and tabs
\n          { return '\n'; }  // handle newlines
.           { return yytext[0]; }  // operators and parentheses
%%

int yywrap() { return 1; }
