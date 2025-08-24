%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%

[0-9]+      { yylval.ival = atoi(yytext); return NUMBER; }

[a-zA-Z_][a-zA-Z0-9_]*   { yylval.sval = strdup(yytext);return IDENTIFIER; }

"+"         {return '+';}
"-"         {return '-';}
"*"         {return '*';}
"/"         {return '/';}
"="         {return '=';}
";"         {return ';';}

[ \t\n]+    ;  // skip whitespace

.           { return yytext[0]; }

%%



