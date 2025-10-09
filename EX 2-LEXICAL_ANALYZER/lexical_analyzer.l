%{
#include <stdio.h>
#include <string.h>

int line_num = 1;
int printed_line = 0; 
void print_line_num_if_needed() {
    if (!printed_line) {
        printf("Line %d:\n", line_num);
        printed_line = 1;
    }
}

int is_keyword(const char *word) {
    const char *keywords[] = {"int","float","char","void","if","else","while","for","return",
                              "printf","scanf","include","getch","main", NULL};
    for (int i = 0; keywords[i]; i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}

int yywrap(void) { return 1; }
%}



ID          [a-zA-Z_][a-zA-Z0-9_]*
NUM         [0-9]+
FLOAT       [0-9]+\.[0-9]+
STR         \"([^\"\n]|\\.)*\"
CHAR        \'([^'\n]|\\.)\'
OP          [+\-*/%=&|!<>]+
PUNC        [;,\[\]\(\)\{\}]
COMMENT1    "//".*
COMMENT2    "/\\*([^*]|\\*+[^*/])*\\*/"
WS          [ \t]+
PREPROCESSOR "#".*

%%

\n              { line_num++; printed_line = 0; }
{COMMENT1}      { print_line_num_if_needed(); printf("\t%-12s : Comment\n", yytext); }
{COMMENT2}      { print_line_num_if_needed(); printf("\t%-12s : Comment\n", yytext); }
{PREPROCESSOR}  { print_line_num_if_needed(); printf("\t%-12s : Preprocessor\n", yytext); }

{FLOAT}         { print_line_num_if_needed(); printf("\t%-12s : Constant\n", yytext); }
{NUM}           { print_line_num_if_needed(); printf("\t%-12s : Constant\n", yytext); }
{STR}           { print_line_num_if_needed(); printf("\t%-12s : Constant\n", yytext); }
{CHAR}          { print_line_num_if_needed(); printf("\t%-12s : Constant\n", yytext); }

{ID}            {
                    print_line_num_if_needed();
                    if (is_keyword(yytext))
                        printf("\t%-12s : Keyword\n", yytext);
                    else
                        printf("\t%-12s : Identifier\n", yytext);
                }

{OP}            { print_line_num_if_needed(); printf("\t%-12s : Operator\n", yytext); }
{PUNC}          { print_line_num_if_needed(); printf("\t%-12s : Punctuation\n", yytext); }
{WS}            { /* ignore whitespace */ }
.               { /* ignore any other character */ }

%%

int main() {
    printf("\n--- Lexical Analysis ---\n\n");
    printf("Enter your C code (Press Ctrl+Z to finish):\n\n");
    yylex();  
    printf("\n--- End of Lexical Analysis ---\n");
    return 0;
}
