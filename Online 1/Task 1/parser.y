%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%union {
    int ival;
    char* sval;
}

%token <ival> NUMBER
%token <sval> OPERATOR
%token <sval> L_PAREN
%token <sval> R_PAREN

%%

program:
    /* empty */
    | program input
    ;

input:
    NUMBER      { printf("Number: %d\n", $1); }
    | OPERATOR  { printf("Operator: %s\n", $1); free($1); }
    | L_PAREN   { printf("Left Parenthesis: %s\n", $1); free($1); }
    | R_PAREN   { printf("Right Parenthesis: %s\n", $1); free($1); }
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main(void) {
    printf("Enter expressions:"); /* Added prompt to match image */
    return yyparse();
}
