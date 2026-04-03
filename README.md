# HeroScript Compiler

A custom Domain-Specific Language (DSL) compiler with a hero/gaming theme, implemented as a B.Tech Compiler Design project.

## Language Overview

HeroScript is a simple imperative language designed with RPG/gaming terminology. It supports:

- **Variable Declaration**: `assemble scalar power_level initialized to 9000;`
- **Variable Types**: `scalar` (integer), `binary` (boolean), `decimal` (float)
- **Assignment**: `update power_level to power_level plus 100;`
- **Conditionals**: `check (power_level above 8000) then { ... } otherwise { ... }`
- **Loops**: 
  - `repeat (count) { ... }`
  - `while (condition) { ... }`
- **Output**: `shout (value);`
- **Operators**: `plus`, `minus`, `times`, `dividedby`, `below`, `above`, `equal`, `not`

## Example Program

```
assemble scalar power_level initialized to 9000;
assemble binary is_active initialized to yes;

check (power_level above 8000) then {
    shout (power_level);
    update power_level to power_level plus 100;
} otherwise {
    update is_active to no;
}

repeat (10) {
    update power_level to power_level minus 1;
}
```

## Project Structure

```
CD_PBL/
├── Makefile                      # Build configuration
├── heroscript_lexer.l            # Lexer (Flex)
├── hero_parser.y                 # Parser (Bison)
├── tokens.h                      # Token definitions
├── ast.h                         # Abstract Syntax Tree
├── semantics.h / semantics.cpp   # Symbol table & semantic analysis
├── main.cpp                      # Compiler driver
├── mission_test.hs               # Example program
└── README.md                     # This file
```

## Compiler Phases

1. **Lexical Analysis** (Flex) - Breaks input into tokens
2. **Syntax Analysis** (Bison) - Verifies grammar structure
3. **Semantic Analysis** - Type checking, symbol table management
4. **Execution** - Interprets the AST or generates code

## Building the Project

### Prerequisites
- GCC/G++ compiler
- Flex (lexer generator)
- Bison (parser generator)
- Make

### Build Instructions

```bash
cd C:\Users\DELL\Desktop\B.Tech\CD_PBL
make clean
make
```

This generates:
- `heroscript` (executable)
- `lex.yy.c` (lexer source)
- `hero_parser.tab.c` (parser source)
- `.o` files (object files)

### Running the Compiler

```bash
./heroscript mission_test.hs
```

Output:
```
========================================
  HeroScript Compiler v1.0
========================================
Compiling: mission_test.hs
----------------------------------------

[Line 1] Assembled scalar 'power_level' = 9000
[Line 2] Assembled binary 'is_active' = 1
[Line 4] SHOUT: 9000
[Line 5] Updated 'power_level' to 9100

=== SYMBOL TABLE ===
Variable             Type            Value      Init
--------             ----            -----      ----
power_level          scalar          9100       Yes
is_active            binary          1          Yes
===================

========================================
Compilation SUCCESSFUL
========================================
```

## Features Implemented

✅ **Completed:**
- Lexical analysis with all keywords and operators
- Parser grammar for declarations, assignments, conditionals
- Basic loops (repeat, while)
- Symbol table management
- Semantic error checking
- Variable type system

🟡 **In Progress:**
- Complex nested structures
- Function definitions
- Array support

❌ **Future Enhancements:**
- Code generation to C
- Optimization passes
- Intermediate representation (IR)

## Variable Types

| Type | Description | Default | Example |
|------|-------------|---------|---------|
| `scalar` | Integer | 0 | `assemble scalar power_level initialized to 9000;` |
| `binary` | Boolean (yes/no) | no | `assemble binary is_active initialized to yes;` |
| `decimal` | Float (stored as int) | 0 | `assemble decimal health initialized to 100;` |

## Operators

| Operator | Type | Usage |
|----------|------|-------|
| `plus` | Arithmetic | `a plus b` |
| `minus` | Arithmetic | `a minus b` |
| `times` | Arithmetic | `a times b` |
| `dividedby` | Arithmetic | `a dividedby b` |
| `below` | Comparison | `a below b` |
| `above` | Comparison | `a above b` |
| `equal` | Comparison | `a equal b` |
| `not` | Logical | `not condition` |

## Error Handling

The compiler reports:
- **Lexical Errors**: Invalid characters
- **Syntax Errors**: Grammar violations
- **Semantic Errors**: Undefined variables, redeclarations, type mismatches

Example error output:
```
[Semantic Error at line 5] Variable 'power_level' not declared
Compilation FAILED with errors.
```

## Testing

Test programs are in the workspace:
- `mission_test.hs` - Basic program with declarations and conditionals
- Create additional `.hs` files to test different features

## Compiler Author

Created for B.Tech Compiler Design (CD_PBL) Project

## Next Steps

1. Implement code generation (output to C or intermediate code)
2. Add more advanced features (functions, arrays)
3. Optimize symbol table lookups
4. Implement proper scope management
5. Add library functions (math operations, I/O)

---

**Project Status**: ~70% Complete - Core compiler functional, refinements ongoing.
