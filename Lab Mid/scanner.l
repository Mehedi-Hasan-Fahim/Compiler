%{
#include "parser.tab.h"
#include <stdio.h>
#include <string.h>
%}

%%

[Tt]he|[Aa]n|[Aa]  { 
    /* Match The, An, A (case insensitive for start of sentence) */
    return ARTICLE; 
}

"." { 
    /* Match a dot to signal the end of a sentence */
    return PERIOD; 
}

[a-zA-Z0-9,]+ ; /* Ignore all other words and numbers */
[ \t\n]       ; /* Ignore whitespace and newlines */
.             ; /* Ignore specific symbols */

%%

int yywrap() { return 1; }
