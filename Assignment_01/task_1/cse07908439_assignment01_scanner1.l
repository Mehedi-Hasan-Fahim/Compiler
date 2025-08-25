%{
#include "cse07908439_assignment01_parser1.tab.h"
#include <stdio.h>
#include <string.h>
%}


%%
[a-zA-Z_][a-zA-Z0-9_]*      { yylval.sval = strdup(yytext); return IDENTIFIER; }
[0-9]+                      { yylval.ival = atoi(yytext); return NUMBER; }
[0-9][a-zA-Z0-9_]+          {yylval.sval = strdup(yytext); return INVALID; }

[ \t\n=;.]+     ;
[^ \t\n=;.]+                 {yylval.sval = strdup(yytext); return INVALID;}

%%

int yywrap() { return 1; }
