%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <map>
#include "semantics.h"

extern int yylex();
extern int line_num;
extern FILE* yyin;
void yyerror(const char *s);

extern SymbolTable globalSymbolTable;
%}

%union {
    int ival;
    float fval;
    char* sval;
}

%token <ival> T_NUMBER
%token <fval> T_FLOAT
%token <sval> T_ID

%token T_ASSEMBLE T_INITIALIZED T_TO T_UPDATE T_CHECK T_THEN T_OTHERWISE
%token T_REPEAT T_WHILE T_SHOUT
%token T_SCALAR T_BINARY T_DECIMAL
%token T_YES T_NO
%token T_PLUS T_MINUS T_TIMES T_DIVIDEDBY
%token T_IS T_NOT T_BELOW T_ABOVE T_EQUAL
%token T_LPAREN T_RPAREN T_LBRACE T_RBRACE T_SEMICOLON T_COMMA
%token T_UNKNOWN

%type <fval> expression

%left T_PLUS T_MINUS
%left T_TIMES T_DIVIDEDBY

%%

program: statement_list {
    printf("--- Program compiled successfully ---\n");
};

statement_list: statement
              | statement statement_list;

statement: declaration
         | assignment
         | shout_stmt
         | check_stmt
         | repeat_stmt
         | while_stmt;

/* DECLARATION */
declaration:
    T_ASSEMBLE T_SCALAR T_ID T_INITIALIZED T_TO expression T_SEMICOLON {
        globalSymbolTable.insert($3, "scalar", line_num);
        globalSymbolTable.update($3, $6, line_num);
        printf("[Line %d] scalar '%s' = %.2f\n", line_num, $3, $6);
        free($3);
    }
  | T_ASSEMBLE T_BINARY T_ID T_INITIALIZED T_TO expression T_SEMICOLON {
        globalSymbolTable.insert($3, "binary", line_num);
        globalSymbolTable.update($3, ($6 != 0), line_num);
        printf("[Line %d] binary '%s' = %s\n", line_num, $3, $6 ? "yes" : "no");
        free($3);
    }
  | T_ASSEMBLE T_DECIMAL T_ID T_INITIALIZED T_TO expression T_SEMICOLON {
        globalSymbolTable.insert($3, "decimal", line_num);
        globalSymbolTable.update($3, $6, line_num);
        printf("[Line %d] decimal '%s' = %.2f\n", line_num, $3, $6);
        free($3);
    };

/* ASSIGNMENT */
assignment:
    T_UPDATE T_ID T_TO expression T_SEMICOLON {
        globalSymbolTable.update($2, $4, line_num);
        printf("[Line %d] Updated '%s' = %.2f\n", line_num, $2, $4);
        free($2);
    };

/* SHOUT */
shout_stmt:
    T_SHOUT T_LPAREN expression T_RPAREN T_SEMICOLON {
        printf("[Line %d] SHOUT: %.2f\n", line_num, $3);
    };

/* CONTROL */
check_stmt:
    T_CHECK T_LPAREN expression T_RPAREN T_THEN block otherwise_part;

otherwise_part:
      /* empty */
    | T_OTHERWISE block;

block:
    T_LBRACE statement_list T_RBRACE;

repeat_stmt:
    T_REPEAT T_LPAREN expression T_RPAREN block {
        printf("[Line %d] Repeat %d times\n", line_num, (int)$3);
    };

while_stmt:
    T_WHILE T_LPAREN expression T_RPAREN block {
        printf("[Line %d] While loop\n", line_num);
    };

/* EXPRESSIONS */
expression:
    T_NUMBER { $$ = $1; }
  | T_FLOAT { $$ = $1; }
  | T_YES { $$ = 1; }
  | T_NO { $$ = 0; }
  | T_ID {
        SymbolEntry* e = globalSymbolTable.lookup($1);
        if(!e) {
            fprintf(stderr, "Error: '%s' not declared\n", $1);
            $$ = 0;
        } else {
            $$ = e->value;
        }
        free($1);
    }
  | expression T_PLUS expression { $$ = $1 + $3; }
  | expression T_MINUS expression { $$ = $1 - $3; }
  | expression T_TIMES expression { $$ = $1 * $3; }
  | expression T_DIVIDEDBY expression {
        if($3 == 0) {
            fprintf(stderr, "Division by zero\n");
            $$ = 0;
        } else $$ = $1 / $3;
    }
  | expression T_BELOW expression { $$ = ($1 < $3); }
  | expression T_ABOVE expression { $$ = ($1 > $3); }
  | expression T_EQUAL expression { $$ = ($1 == $3); }
  | T_LPAREN expression T_RPAREN { $$ = $2; };

%%

void yyerror(const char *s) {
    fprintf(stderr, "[Syntax Error at line %d] %s\n", line_num, s);
}