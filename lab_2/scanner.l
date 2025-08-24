%{
#include "parser.tab.h"
#include <stdio.h>
#include <string.h>
%}


%%
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return IDENTIFIER; }
[0-9][a-zA-Z0-9_]* { return INVALID; }
.([a-zA-Z_][a-zA-Z0-9_]*) { return INVALID; }
\n                     ;
%%

int yywrap() { return 1; }

