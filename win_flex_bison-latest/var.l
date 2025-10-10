%{
#include "var.tab.h"
#include <string.h>
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*   { return ID; }       // valid identifier pattern
[ \t]+                    ;                   // ignore spaces/tabs
\n                        { return '\n'; }  
.                         { return INVALID; }  // anything else is invalid

%%

int yywrap(void) {
    return 1;  // EOF handling: return 1 signals EOF to yyparse
}
