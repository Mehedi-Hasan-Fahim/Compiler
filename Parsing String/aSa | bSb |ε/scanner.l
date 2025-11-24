%{
#include "parser.tab.h"
#include <stdio.h>
%}

%%
[0|1]+      { yylval.sval = yytext; return STRING; }
\n          ;
.           { return INVALID; }
%%

int yywrap() { return 1; }
