%{
#include <stdio.h>
#include <string.h>

struct Symbol {
    char name[20];
    char type[15];
    char kind[15];
    char scope[15];
    char memloc[15];
    char extra[30];
} symtab[100];

int count = 0;

int is_keyword(const char *word) {
    return (strcmp(word, "int") == 0 || strcmp(word, "float") == 0);
}

void insert_symbol(char *name, char *type, char *kind, char *scope, char *memloc, char *extra) {
    strcpy(symtab[count].name, name);
    strcpy(symtab[count].type, type);
    strcpy(symtab[count].kind, kind);
    strcpy(symtab[count].scope, scope);
    strcpy(symtab[count].memloc, memloc);
    strcpy(symtab[count].extra, extra);
    count++;
}

void display_symtab() {
    int i;
    printf("\n%-15s %-12s %-12s %-10s %-15s %-20s\n",
           "Name", "Type", "Kind", "Scope", "Mem_Loc", "Extra_Info");
    printf("---------------------------------------------------------------------------------------\n");
    for (i = 0; i < count; i++) {
        printf("%-15s %-12s %-12s %-10s %-15s %-20s\n",
               symtab[i].name, symtab[i].type, symtab[i].kind,
               symtab[i].scope, symtab[i].memloc, symtab[i].extra);
    }
}
%}

ID      [a-zA-Z_][a-zA-Z0-9_]*
NUM     [0-9]+
FLOAT   [0-9]+\.[0-9]+
STR     \"([^\"\n]|\\.)*\"
CHAR    \'([^'\n]|\\.)\'

OP      [+\-*/%=&|!<>]+
PUNC    [;,\[\]\(\)\{\}]
COMMENT1 "//".*
COMMENT2 "/\\*([^*]|\\*+[^*/])*\\*/"
WS      [\t\n\r]+
%%

{ID} {
    if(is_keyword(yytext)) {
        insert_symbol(yytext, "Keyword", "datatype", "global", "-", "reserved word");
    } else {
        insert_symbol(yytext, "Identifier", "variable", "local", "0x100", "size=4 bytes");
    }
}

{NUM}    { insert_symbol(yytext, "Constant", "literal", "local", "-", "integer constant");}

{FLOAT}  { insert_symbol(yytext, "Constant", "literal", "local", "-", "float constant");}

{STR}    { insert_symbol(yytext, "Constant", "literal", "local", "-", "string literal");}

{CHAR}   {  insert_symbol(yytext, "Constant", "literal", "local", "-", "char literal");}

{OP}     {  }
{PUNC}   {  }
.        {  }

%%

int main() {
    printf("Enter code (press Ctrl+Z then Enter to end):\n");
    yylex();
    display_symtab();
    return 0;
}

int yywrap() {
    return 1;
}
