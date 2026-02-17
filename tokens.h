#ifndef TOKENS_H
#define TOKENS_H

enum Token {
    T_EOF = 0,
    T_ASSEMBLE = 258,
    T_INITIALIZED,
    T_TO,
    T_UPDATE,
    T_CHECK,
    T_THEN,
    T_OTHERWISE,
    T_REPEAT,
    T_WHILE,
    T_SHOUT,
    T_SCALAR,
    T_DECIMAL,
    T_BINARY,
    T_ID,
    T_NUMBER,
    T_PLUS,
    T_MINUS,
    T_TIMES,
    T_DIVIDEDBY,
    T_IS,
    T_NOT,
    T_BELOW,
    T_ABOVE,
    T_YES,
    T_NO,
    T_LPAREN,
    T_RPAREN,
    T_LBRACE,
    T_RBRACE,
    T_SEMICOLON,
    T_UNKNOWN
};

#endif