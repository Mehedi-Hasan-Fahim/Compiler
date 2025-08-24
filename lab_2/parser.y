%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

%}

%union {
    char* sval;
}

%token <sval> IDENTIFIER
%token INVALID

%%
program: /* empty */ | program input ;
input:
    IDENTIFIER        { printf("Valid Identifier: %s\n", $1); }
    |
    INVALID           { printf("Invalid Identifier\n"); }
    ;
%%

int main(void) {
    return yyparse();
}



