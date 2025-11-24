#include <stdio.h>
#include <string.h>

/* Recursive check using two indices (left and right).
   Returns 1 if s[left..right] belongs to the language. */
int parse_range(const char *s, int left, int right) {
    if (left > right) {
        // consumed everything successfully (even length)
        return 1;
    }
    if (left == right) {
        // single middle char -> odd length -> cannot be produced by grammar
        return 0;
    }
    // outer characters must be opposite: S->aSa | bSb |ε
    if (s[left] == s[right]) {
        return parse_range(s, left + 1, right - 1);
    }
    return 0; // outer pair not matching the required opposite relation
}

int yyparse_string(const char *s) {
    int len = strlen(s);
    // top-level call: check from 0 to len-1
    return parse_range(s, 0, len - 1);
}

int main() {
    //  char s[]="0101";
    // if (yyparse_string(s))
    //     printf("Accepted\n");
    // else
    //     printf("Not accepted\n"); 
   
    const char *inputs[] = {"", "aa", "bb", "aaaa", "abba", "baab"};
    int n = sizeof(inputs) / sizeof(inputs[0]);

    for (int k = 0; k < n; k++) {
        printf("Input: %s\n", inputs[k]);
        if (yyparse_string(inputs[k]))
            printf("Output: String is accepted.\n\n");
        else
            printf("Output: String is rejected.\n\n");
    }

    return 0;
}
