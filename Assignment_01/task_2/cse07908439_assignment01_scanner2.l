%{
#include "cse07908439_assignment01_parser2.tab.h"
#include <stdio.h>
#include <string.h>

%}

%%
[ \t\n]+    ;   /* Ignore spaces, tabs, newlines between tokens */

[^.]+[.]     {
                int len = yyleng;
                char *temp = (char*)malloc(len); // len includes the '.'
                strncpy(temp, yytext, len - 1);  // copy without the period
                temp[len - 1] = '\0';
                yylval.sval = temp;
                return SENTENCE;
            }

.           ;   /* Ignore any other characters */



%%
int yywrap() { return 1; }

