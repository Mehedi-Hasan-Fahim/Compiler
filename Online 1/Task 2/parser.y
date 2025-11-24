%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    char* sval;
}

/* We use a single generic token for all keywords to keep the code clean */
%token <sval> KEYWORD

%%

program: 
    /* empty */
    | program input
    ;

input:
    KEYWORD { 
        printf("Keyword: %s\n", $1); 
        free($1); 
    }
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main(void) {
    printf("Enter text (Ctrl+D to end input):\n"); 
    return yyparse();
}
