%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

/* Initialize counters */
int article_number = 0;
int line_number = 0;
%}

%token ARTICLE
%token PERIOD

%%

program: 
    /* empty */ 
    | program input
    ;

input:
    ARTICLE { 
        article_number++; 
    }
    | PERIOD { 
        line_number++; 
    }
    ;

%%

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main(void) {
    printf("Enter text (Ctrl+z to end):\n");
    yyparse();
    printf("\n----------------------------\n");
    printf("Total articles detected : %d\n", article_number);
    printf("Total sentences detected: %d\n", line_number);
    printf("----------------------------\n");
    return 0;
}
