%{
#include "tokens.h"
#include <stdio.h>
int line_num = 1;
%}

%option noyywrap

%%

[ \t]               ; // Skip whitespace
\n                  { line_num++; }

"assemble"          { return T_ASSEMBLE; }
"initialized"       { return T_INITIALIZED; }
"to"                { return T_TO; }
"update"            { return T_UPDATE; }
"check"             { return T_CHECK; }
"then"              { return T_THEN; }
"otherwise"         { return T_OTHERWISE; }
"repeat"            { return T_REPEAT; }
"while"             { return T_WHILE; }
"shout"             { return T_SHOUT; }

"scalar"            { return T_SCALAR; }
"decimal"           { return T_DECIMAL; }
"binary"            { return T_BINARY; }

"plus"              { return T_PLUS; }
"minus"             { return T_MINUS; }
"times"             { return T_TIMES; }
"dividedby"         { return T_DIVIDEDBY; }

"is"                { return T_IS; }
"not"               { return T_NOT; }
"below"             { return T_BELOW; }
"above"             { return T_ABOVE; }

"yes"               { return T_YES; }
"no"                { return T_NO; }

[a-zA-Z_][a-zA-Z0-9_]* { return T_ID; }
[0-9]+(\.[0-9]+)?      { return T_NUMBER; }

"("                 { return T_LPAREN; }
")"                 { return T_RPAREN; }
"{"                 { return T_LBRACE; }
"}"                 { return T_RBRACE; }
";"                 { return T_SEMICOLON; }

.                   { printf("Mystery character %s at line %d\n", yytext, line_num); return T_UNKNOWN; }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
    }
    int token;
    while ((token = yylex()) != T_EOF) {
        printf("Detected Token ID: %d\n", token);
    }
    return 0;
}