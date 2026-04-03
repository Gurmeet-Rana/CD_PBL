%{
#include "hero_parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int line_num = 1;
%}

%option noyywrap
%option yylineno
%option caseless

%%

[ \t]+ ;
\n { line_num++; }

"//".* ;

"/*" {
    int c, prev = 0;
    while ((c = yyinput()) != EOF) {
        if (c == '\n') line_num++;
        if (prev == '*' && c == '/') break;
        prev = c;
    }
}

 
"assemble" { return T_ASSEMBLE; }
"initialized" { return T_INITIALIZED; }
"to" { return T_TO; }
"update" { return T_UPDATE; }
"check" { return T_CHECK; }
"then" { return T_THEN; }
"otherwise" { return T_OTHERWISE; }
"repeat" { return T_REPEAT; }
"while" { return T_WHILE; }
"shout" { return T_SHOUT; }

"scalar" { return T_SCALAR; }
"decimal" { return T_DECIMAL; }
"binary" { return T_BINARY; }

"yes" { return T_YES; }
"no" { return T_NO; }

"plus" { return T_PLUS; }
"minus" { return T_MINUS; }
"times" { return T_TIMES; }
"dividedby" { return T_DIVIDEDBY; }
"is" { return T_IS; }
"not" { return T_NOT; }
"below" { return T_BELOW; }
"above" { return T_ABOVE; }
"equal" { return T_EQUAL; }

[a-zA-Z_][a-zA-Z0-9_]* {
    yylval.sval = strdup(yytext);
    return T_ID;
}

[0-9]+\.[0-9]+ {
    yylval.fval = atof(yytext);
    return T_FLOAT;
}

[0-9]+ {
    yylval.ival = atoi(yytext);
    return T_NUMBER;
}

"(" { return T_LPAREN; }
")" { return T_RPAREN; }
"{" { return T_LBRACE; }
"}" { return T_RBRACE; }
";" { return T_SEMICOLON; }
"," { return T_COMMA; }

. {
    fprintf(stderr, "Lexical error at line %d: '%c'\n", line_num, yytext[0]);
    return T_UNKNOWN;
}

%%