%{
#include "control.tab.h"
%}

%%

"if"            { return IF; }
"else"          { return ELSE; }
"for"           { return FOR; }
"while"         { return WHILE; }
"switch"        { return SWITCH; }
"case"          { return CASE; }

";"             { return SEMICOLON; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"("             { return LPAREN; }
")"             { return RPAREN; }

[0-9a-zA-Z_]+   { return ID; }  // variable names or numbers
[ \t]+          { /* skip whitespace */ }
\n              { return EOL; }  // end of line
.               { return yytext[0]; } // any other character

%%

int yywrap() { return 1; }
