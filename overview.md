# Project Overview: HeroScript Compiler

## What is this Project?

The HeroScript Compiler is a custom Domain-Specific Language (DSL) compiler developed as part of a B.Tech Compiler Design (CD_PBL) project. HeroScript is designed with an RPG/gaming theme, using intuitive gaming terminology instead of traditional programming keywords. The language supports basic imperative programming constructs like variables, conditionals, loops, and arithmetic operations, all wrapped in a hero-themed syntax.

### Key Features of HeroScript:
- **Variable Types**: `scalar` (integer), `binary` (boolean), `decimal` (float)
- **Declarations**: `assemble scalar power_level initialized to 9000;`
- **Assignments**: `update power_level to power_level plus 100;`
- **Conditionals**: `check (power_level above 8000) then { ... } otherwise { ... }`
- **Loops**: `repeat (count) { ... }` and `while (condition) { ... }`
- **Output**: `shout (value);`
- **Operators**: `plus`, `minus`, `times`, `dividedby`, `above`, `below`, `equal`, `not`

The compiler is implemented using standard compiler construction tools:
- **Lexer**: Flex (lexical analyzer generator)
- **Parser**: Bison (parser generator)
- **Language**: C/C++
- **Platform**: Windows (with GCC/G++)

## What Has Been Done?

The project is currently in **Phase 2** of development, having completed the core compiler pipeline:

### Completed Phases:
1. **Phase 1: Lexical Analysis**
   - Implemented lexer using Flex
   - Tokenizes HeroScript source code into 32+ distinct tokens
   - Handles keywords, identifiers, literals, operators, and delimiters
   - Error reporting for invalid characters

2. **Phase 2: Syntax Analysis & Semantic Analysis**
   - Implemented parser using Bison with comprehensive grammar rules
   - Builds parse trees and performs syntax validation
   - Symbol table management for variable tracking
   - Type checking and semantic error detection
   - Direct interpretation of programs (no code generation yet)

### Implementation Details:
- **Files Created**:
  - `heroscript_lexer.l`: Lexer specification
  - `hero_parser.y`: Parser grammar
  - `tokens.h`: Token definitions
  - `semantics.h/cpp`: Symbol table and semantic analysis
  - `main.cpp`: Compiler driver
  - `mission_test.hs`: Example program
  - Generated files: `lex.yy.c`, `hero_parser.tab.c/h`, `compiler.exe`

- **Build System**: Makefile for automated compilation
- **Testing**: Comprehensive test suite with 5+ test cases covering declarations, arithmetic, conditionals, loops, and error detection
- **Documentation**: Detailed README.md and Phase 2 documentation

### Achievements:
- ✅ Complete lexer with 32+ tokens
- ✅ Full parser with proper precedence handling
- ✅ Symbol table with type checking
- ✅ Support for variables, conditionals, and loops
- ✅ Error handling and recovery
- ✅ Working interpreter that executes HeroScript programs
- ✅ All test cases passing

## What is Left to Do?

The project has a solid foundation but several enhancements are planned for future phases:

### Language Extensions:
- **Arrays**: Support for array data structures
- **Functions**: User-defined functions and procedures
- **Strings**: String data type and operations
- **File I/O**: Reading and writing files
- **Advanced Loops**: For loops and nested loop constructs

### Compiler Improvements:
- **Code Generation**: Generate C code instead of direct interpretation
- **Optimization**: Constant folding, dead code elimination
- **Intermediate Representation**: Three-address code generation
- **Multiple Backends**: Support for different target languages (e.g., assembly, other high-level languages)

### Tool Enhancements:
- **IDE Integration**: Syntax highlighting and error markers in editors
- **Debug Support**: Breakpoints and variable inspection
- **Performance Profiling**: Execution time analysis
- **Documentation Generation**: Automatic documentation tools

### Additional Features:
- **Advanced Error Recovery**: Better error messages and suggestions
- **Module System**: Support for importing and organizing code
- **Standard Library**: Built-in functions for common operations
- **Optimization Passes**: Compiler optimizations for better performance

## Current Status

The compiler is fully functional for Phase 2 requirements and can compile and run basic HeroScript programs. The executable `compiler.exe` is built and ready to use. The project demonstrates core compiler design principles and provides a foundation for further development.

## How to Use

1. Run a program: `./compiler.exe mission_test.hs`
2. View output in the terminal

## Team Member Responsibilities

Assigning clear tasks makes a 4-person project smooth and collaborative. Suggested distribution:

1. Member 1 - Language Design & Documentation
   - Define HeroScript grammar and language features
   - Write README and Phase 2 documentation
   - Provide example programs and usage guide

2. Member 2 - Lexical Analyzer (Lexer)
   - Implement `heroscript_lexer.l` with all token rules
   - Handle keywords, identifiers, literals, operators, delimiters
   - Add lexical error reporting
   - Test tokenization with edge cases

3. Member 3 - Syntax and Semantic Frontend
   - Implement `hero_parser.y` Bison grammar and parser actions
   - Maintain symbol table in `semantics.h` / `semantics.cpp`
   - Add type checking, declaration checks, scope rules
   - Handle syntax and semantic errors

4. Member 4 - Compiler Driver, Testing, and Integration
   - Implement `main.cpp`, compiler flow and interpreter
   - Create `mission_test.hs` and additional test cases
   - Create `Makefile`, build/test scripts, run regression tests
   - Integrate generated `lex.yy.c`, `hero_parser.tab.c/h` and ensure project build

Each member presents their own part in demos:
- Member 1: project concept, requirements, and grammar overview
- Member 2: lexer rules, token output, and lexical debugging
- Member 3: parser behavior, semantic checks, and error cases
- Member 4: end-to-end build/run flow, tests, and future extension plan


The project is well-documented and includes example programs, test cases, and comprehensive documentation for understanding the implementation.