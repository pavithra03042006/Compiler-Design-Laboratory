%{
#include "var.tab.h"
#include <stdio.h>

void yyerror(const char *s);
%}

%%

[a-zA-Z]      { return LETTER; }
[0-9]         { return DIGIT; }
\n            { return 0; }               // End of input
[^a-zA-Z0-9\n] { yyerror("Invalid Variable"); return 0; }

%%

int yywrap() { return 1; }
