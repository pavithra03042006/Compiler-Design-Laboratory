%{
#include "expr.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+        { yylval = atoi(yytext); return NUM; }
[\+\-\*/\(\)] { return yytext[0]; }
[ \t]+        ;      // ignore spaces and tabs
\n            { return '\n'; }
.             { return 0; }

%%

int yywrap(void) {
    return 1;
}
