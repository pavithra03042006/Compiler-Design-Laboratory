%{
#include <stdio.h>
int line_num = 1;
int printed_line = 0;  // Flag to track if line number printed this line

void print_line_num_if_needed() {
    if (!printed_line) {
        printf("Line %d:\n", line_num);
        printed_line = 1;
    }
}

int yywrap(void) {
    return 1;
}
%}

KEYWORD   int|float|char|void|if|else|while|for|return|printf|scanf|include|getch|main
OPERATOR  \+|\-|\*|\/|=|==|<=|>=|<|>|\(|\)|\{|\}|\[|\]|;|,|\"|\'|#

%%

\n          { line_num++; printed_line = 0; }
{KEYWORD}   { print_line_num_if_needed(); printf("\t%-12s : Keyword\n", yytext); }
[0-9]+      { print_line_num_if_needed(); printf("\t%-12s : Constant\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { print_line_num_if_needed(); printf("\t%-12s : Identifier\n", yytext); }

"("         { print_line_num_if_needed(); printf("\t%-12s : open_paren\n", yytext); }
")"         { print_line_num_if_needed(); printf("\t%-12s : close_paren\n", yytext); }
"{"         { print_line_num_if_needed(); printf("\t%-12s : open_brace\n", yytext); }
"}"         { print_line_num_if_needed(); printf("\t%-12s : close_brace\n", yytext); }
";"         { print_line_num_if_needed(); printf("\t%-12s : semicolon\n", yytext); }
","         { print_line_num_if_needed(); printf("\t%-12s : comma\n", yytext); }
"="         { print_line_num_if_needed(); printf("\t%-12s : equal\n", yytext); }
"*"         { print_line_num_if_needed(); printf("\t%-12s : multiply\n", yytext); }
"\""        { print_line_num_if_needed(); printf("\t%-12s : doublequote\n", yytext); }
"'"         { print_line_num_if_needed(); printf("\t%-12s : singlequote\n", yytext); }
"#"         { print_line_num_if_needed(); printf("\t%-12s : preprocessor\n", yytext); }

[ \t]+      ; // ignore whitespace
.           { /* ignore other characters */ }

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <inputfile>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (!file) {
        perror("Error opening file");
        return 1;
    }
    yyin = file;
    printf("\n--- Lexical Analysis ---\n\n");
    yylex();
    fclose(file);
    return 0;
}

