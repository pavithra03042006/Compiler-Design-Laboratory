//  17. Use lex and yacc tool to implement a native calc


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


// enter expression(Press ctrl+C to end):

// 3+45
// Result is:48

// 45/9
// Result is:5

// 67*3
// Result is:201

// Exited...