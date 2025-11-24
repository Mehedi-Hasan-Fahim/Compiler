%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while" { 
    yylval.sval = strdup(yytext); 
    return KEYWORD; 
}

[a-zA-Z0-9_]+ ; /* Ignore other identifiers (variable names, etc.) */
[ \t\n]+      ; /* Ignore whitespace */
.             ; /* Ignore symbols like +, -, =, >, etc. */

%%

int yywrap() {
    return 1;
}
