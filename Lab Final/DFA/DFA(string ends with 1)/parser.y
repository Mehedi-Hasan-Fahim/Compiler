%{
#include <stdio.h>
#include <stdlib.h>

// Define DFA states
typedef enum { q0, q1 } State;

State current_state = q0;

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int yylex(void);
%}

%token ZERO ONE

%%

input:
    sequence
    {
        if (current_state == q1)
            printf("Accepted: The string ends with '1'.\n");
        else
            printf("Rejected: The string does not end with '1'.\n");
        exit(0);
    }
;


sequence:
    /* empty */
    | sequence ZERO {
        // Transition from current state on input '0'
        switch(current_state) {
            case q0: current_state = q0; break;
            case q1: current_state = q0; break;
        }
    }
    | sequence ONE {
        // Transition from current state on input '1'
        switch(current_state) {
            case q0: current_state = q1; break;
            case q1: current_state = q1; break;
        }
    }
;

%%
int main() {
    printf("Enter a binary string (only 0 and 1):\n");
    yyparse();
    return 0;
}


