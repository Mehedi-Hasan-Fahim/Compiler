#include <stdio.h>
#include <string.h>

int main() {
    char nonTerminal;
    char part[20];
    
    // Arrays to store the parts of the rule
    char alpha[10][20], beta[10][20];
    int alphaCount = 0;
    int betaCount = 0;
    
    int numParts;
    
    // --- Flags for detection ---
    int hasLeftRecursion = 0;
    int hasRightRecursion = 0; // 

    // --- 1. Get Input ---
    
    printf("Enter the non-terminal (e.g., E): ");
    scanf(" %c", &nonTerminal);

    printf("How many parts does the rule have? (e.g., for 'E+T | T', there are 2): ");
    scanf("%d", &numParts);

    printf("Enter the %d parts, one by one:\n", numParts);

    // --- 2. Sort Parts and Detect Recursion ---

    for (int i = 0; i < numParts; i++) {
        printf("Part %d: ", i + 1);
        scanf("%s", part); // Read one part, e.g., "E+T" or "T"

        // Check for Left Recursion
        if (part[0] == nonTerminal) {
            hasLeftRecursion = 1;
            // Copy everything *after* the first character into alpha
            strcpy(alpha[alphaCount], part + 1);
            alphaCount++;
        } else {
            // Not left-recursive
            // Copy the whole part into beta
            strcpy(beta[betaCount], part);
            betaCount++;
        }
        
        // Check for Right Recursion
        int len = strlen(part);
        if (len > 0 && part[len - 1] == nonTerminal) {
            hasRightRecursion = 1;
        }
    }

    // --- 3. Print Detections and New Rules ---

    // Print our findings
    printf("\n--- Analysis ---\n");
    if (hasRightRecursion) {
        printf("Right Recursive detected.\n"); //
    }
    if (!hasLeftRecursion) {
        printf("No left recursion detected.\n");
        return 0; // No fix needed, so we can exit
    } else {
         printf("Left Recursive detected. Removing...\n");
    }

    printf("\n--- Removed Left Recursion ---\n");

    // Print the new main rule: A -> βA'
    printf("%c -> ", nonTerminal);
    if (betaCount == 0) {
        printf("%c'", nonTerminal);
    } else {
        for (int i = 0; i < betaCount; i++) {
            printf("%s%c'", beta[i], nonTerminal);
            if (i < betaCount - 1) {
                printf(" | ");
            }
        }
    }
    printf("\n");

    // Print the new 'prime' rule: A' -> αA' | ε
    printf("%c' -> ", nonTerminal);
    for (int i = 0; i < alphaCount; i++) {
        printf("%s%c'", alpha[i], nonTerminal);
        printf(" | ");
    }
    printf("ε\n");

    return 0;
}
