%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

[0-9]+      { yylval.ival = atoi(yytext); return NUMBER; }
"+"         { yylval.sval = strdup(yytext); return OPERATOR; }
"-"         { yylval.sval = strdup(yytext); return OPERATOR; }
"*"         { yylval.sval = strdup(yytext); return OPERATOR; }
"/"         { yylval.sval = strdup(yytext); return OPERATOR; }
"("         { yylval.sval = strdup(yytext); return L_PAREN; }
")"         { yylval.sval = strdup(yytext); return R_PAREN; }
[ \t\n]     ; /* Ignore whitespace and newlines */
.           { printf("Unexpected character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
