// defines all token types

#ifndef TOKENS_H
#define TOKENS_H

enum Token {
    T_EOF = 0,
    
    // Keywords
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
    
    // Type Keywords
    T_SCALAR,
    T_DECIMAL,
    T_BINARY,
    
    // Literals
    T_ID,
    T_NUMBER,
    
    // Operators
    T_PLUS,
    T_MINUS,
    T_TIMES,
    T_DIVIDEDBY,
    
    // Comparison
    T_IS,
    T_NOT,
    T_BELOW,
    T_ABOVE,
    T_EQUAL,
    
    // Boolean
    T_YES,
    T_NO,
    
    // Delimiters
    T_LPAREN,
    T_RPAREN,
    T_LBRACE,
    T_RBRACE,
    T_SEMICOLON,
    T_COMMA,
    
    T_UNKNOWN
};

#endif
