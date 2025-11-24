%{
#include "parser.tab.h"
%}

%%
0       { return ZERO; }
1       { return ONE; }
[ \t\r\n]+   ;   //ignore whitespace
.       { printf("Invalid character: %s\n", yytext); exit(1); }
%%

int yywrap() {
    return 1;
}
