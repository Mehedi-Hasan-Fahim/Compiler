%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int line_number = 0;

%}

%union {
    char* sval;
}

%token <sval> SENTENCE

%%
input:/* empty */ |input sentences;

sentences:
      SENTENCE { printf("Line %d: %s\n", ++line_number, $1);   free($1); }
    ;
%%

int main(void) {
    yyparse();
    printf("Total number of lines detected: %d\n", line_number);
    return 0;
}
