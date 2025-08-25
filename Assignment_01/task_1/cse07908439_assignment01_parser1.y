%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

%}

%union {
    int   ival;
    char* sval;
}

%token <ival> NUMBER
%token <sval> IDENTIFIER
%token <sval> INVALID

%%
program: /* empty */ | program input ;
input:
      NUMBER            { printf("Constant: %d\n", $1);}
    |IDENTIFIER        { printf("Identifier: %s\n", $1); free($1); }
    |INVALID            { printf("Invalid Token: %s\n", $1); free($1); }
    ;
%%

int main(void) {
    return yyparse();
}



