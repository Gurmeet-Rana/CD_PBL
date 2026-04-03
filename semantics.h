#ifndef SEMANTICS_H
#define SEMANTICS_H

#include <map>
#include <string>
#include <vector>
#include <iostream>

// Symbol Table Entry
struct SymbolEntry {
    std::string name;
    std::string type;    // "scalar", "binary", "decimal"
    int value;
    bool initialized;
    int lineNumber;
    
    SymbolEntry(const std::string& n = "", const std::string& t = "",
                int v = 0, bool init = false, int line = 0)
        : name(n), type(t), value(v), initialized(init), lineNumber(line) {}
};

// Symbol Table Manager
class SymbolTable {
private:
    std::map<std::string, SymbolEntry> table;
    std::vector<std::string> errors;
    
public:
    // Insert a new symbol
    bool insert(const std::string& name, const std::string& type, int line);
    
    // Lookup a symbol
    SymbolEntry* lookup(const std::string& name);
    
    // Update value
    bool update(const std::string& name, int value, int line);
    
    // Check if symbol exists
    bool exists(const std::string& name) const;
    
    // Print symbol table
    void print() const;
    
    // Error handling
    void addError(const std::string& error);
    bool hasErrors() const { return !errors.empty(); }
    void printErrors() const;
    
    // Clear table
    void clear();
};

// Global symbol table instance
extern SymbolTable globalSymbolTable;
extern int currentLineNumber;

#endif
