%{
#include <stdio.h>
#include <stdlib.h>

// Define DFA states
typedef enum { q0, q1 ,q2 ,q3 } State;

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
        if (current_state == q3)
            printf("Accepted: The string contains '011'.\n");
        else
            printf("Rejected: The string does not contain '011'.\n");
        exit(0);
    }
;


sequence:
    /* empty */
    | sequence ZERO {
        // Transition from current state on input '0'
        switch(current_state) {
            case q0: current_state = q1; break;
            case q1: current_state = q1; break;
            case q2: current_state = q1; break;
            case q3: current_state = q3; break;
        }
    }
    | sequence ONE {
        // Transition from current state on input '1'
        switch(current_state) {
            case q0: current_state = q0; break;
            case q1: current_state = q2; break;
            case q2: current_state = q3; break;
            case q3: current_state = q3; break;
        }
    }
;

%%
int main() {
    printf("Enter a binary string (only 0 and 1):\n");
    yyparse();
    return 0;
}


