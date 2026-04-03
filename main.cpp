#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantics.h"

extern int yyparse();
extern FILE* yyin;
extern int line_num;

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <input_file.hs>\n", argv[0]);
        return 1;
    }

    const char* filename = argv[1];

    // Reset global state
    globalSymbolTable.clear();
    line_num = 1;

    yyin = fopen(filename, "r");
    if (!yyin) {
        fprintf(stderr, "Error: Cannot open file '%s'\n", filename);
        return 1;
    }

    printf("========================================\n");
    printf("  HeroScript Compiler v1.0\n");
    printf("========================================\n");
    printf("Compiling: %s\n", filename);
    printf("----------------------------------------\n\n");

    int result = yyparse();

    fclose(yyin);

    printf("\n");

    // Show symbol table only if parsing succeeded
    if (result == 0) {
        globalSymbolTable.print();
    }

    // Show semantic errors
    if (globalSymbolTable.hasErrors()) {
        globalSymbolTable.printErrors();
        printf("========================================\n");
        printf("Compilation FAILED (Semantic Errors)\n");
        printf("========================================\n");
        return 1;
    }

    if (result == 0) {
        printf("========================================\n");
        printf("Compilation SUCCESSFUL\n");
        printf("========================================\n");
        return 0;
    } else {
        printf("========================================\n");
        printf("Compilation FAILED (Syntax Errors)\n");
        printf("========================================\n");
        return 1;
    }
}