%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

int yyparse_string(const char *s);
int parse_range(const char *s, int left, int right);
%}

%union {
    char* sval;
}

%token <sval> STRING
%token INVALID

%%
input:
    STRING  {
                printf("Input String: %s\n", $1);
                printf("Parsing result: ");
                if (yyparse_string($1))
                    printf("String is accepted.\n");
                else
                    printf("Syntax error.\n");
            }
    | INVALID { printf("Invalid Input\n"); }
    ;
%%

int main() {
    printf("Enter string: ");
    return yyparse();
}

int yyparse_string(const char *s) {
    int len = strlen(s);
    // top-level call: check from 0 to len-1
    return parse_range(s, 0, len - 1);
}

/* Recursive check using two indices (left and right).
   Returns 1 if s[left..right] belongs to the language. */
int parse_range(const char *s, int left, int right) {
    if (left > right) {
        // consumed everything successfully (even length)
        return 1;
    }
    if (left == right) {
         return 1; // Single char (a or b) case
    }
     // CFG: S -> aSa | bSb | a | b | ε
    if (s[left] == s[right]) {
        return parse_range(s, left + 1, right - 1);
    }
    return 0;// Rule S -> aSb did not match
}


void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

