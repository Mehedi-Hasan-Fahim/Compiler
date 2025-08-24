 %{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex(void);
void yyerror(const char *s) {fprintf(stderr,"Error: %s\n",s); }
int yywrap(void) {return 1;}
%}

%union {
    int ival;
    char* sval;
}

%token <ival> NUMBER
%token <sval> IDENTIFIER
%type <ival> expression

%left '+' '-'
%left '*' '/'

%%
program: /* empty */ | program statement ;
statement: IDENTIFIER '=' expression ';' {
   printf("Assign %d to %s\n",$3,$1) ;free($1);
};
expression:
     NUMBER     {$$ = $1;}
    |IDENTIFIER {$$ = 0;}
    |expression '+' expression {$$ = $1 + $3;}
    |expression '-' expression {$$ = $1 - $3;}
    |expression '*' expression {$$ = $1 * $3;}
    |expression '/' expression {$$ = $1 / $3;}
    ;
%%
int main(void){ return yyparse(); }






