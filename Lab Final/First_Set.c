#include <stdio.h>
#include <string.h>
#include <ctype.h>

int n;
char prod[10][10], firstSet[10];

// Add unique characters to firstSet
void addToFirst(char c) {
    if (strchr(firstSet, c) == NULL) {
        int len = strlen(firstSet);
        firstSet[len] = c;
        firstSet[len + 1] = '\0';
    }
}

void findFirst(char symbol) {
    // Case 1: Terminal Symbol
    if (!isupper(symbol)) {
        addToFirst(symbol);
        return;
    }

    // Case 2: Non-Terminal Symbol
    for (int i = 0; i < n; i++) {
        if (prod[i][0] == symbol) { // Match LHS
            char *rhs = &prod[i][3];
            int j, allEpsilon = 1;

            for (j = 0; rhs[j] != '\0'; j++) {
                // Recurse to find FIRST of current symbol
                findFirst(rhs[j]); 

                // Check if the recursion added epsilon (ε)
                char *ptr = strchr(firstSet, '#');
                if (ptr) {
                    *ptr = '\0'; // Found epsilon: strip it and continue chain
                } else {
                    allEpsilon = 0; // No epsilon: break chain
                    break;
                }
            }
            // If the loop finished naturally, the whole production is nullable
            if (allEpsilon) addToFirst('#');
        }
    }
}

int main() {
    n = 5;
    strcpy(prod[0], "S->AB");
    strcpy(prod[1], "A->aA");
    strcpy(prod[2], "A->#");
    strcpy(prod[3], "B->bB");
    strcpy(prod[4], "B->#");


    char ch = 'S';
    firstSet[0] = '\0';
    findFirst(ch);

    printf("FIRST(%c) = { ", ch);
    for (int i = 0; i < strlen(firstSet); i++)
        printf("%c ", firstSet[i]);
    printf("}\n");

    return 0;
}
