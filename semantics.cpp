//symbol table and error checking

#include "semantics.h"
#include <iostream>
#include <cstdio>

SymbolTable globalSymbolTable;
int currentLineNumber = 1;

bool SymbolTable::insert(const std::string& name, const std::string& type, int line) {
    if (exists(name)) {
        char buffer[256];
        snprintf(buffer, sizeof(buffer), "Semantic Error at line %d: Symbol '%s' already declared",
                 line, name.c_str());
        addError(buffer);
        return false;
    }
    
    table[name] = SymbolEntry(name, type, 0, false, line);
    return true;
}

SymbolEntry* SymbolTable::lookup(const std::string& name) {
    auto it = table.find(name);
    if (it != table.end()) {
        return &it->second;
    }
    return nullptr;
}

bool SymbolTable::update(const std::string& name, int value, int line) {
    auto entry = lookup(name);
    if (!entry) {
        char buffer[256];
        snprintf(buffer, sizeof(buffer), "Semantic Error at line %d: Symbol '%s' not declared",
                 line, name.c_str());
        addError(buffer);
        return false;
    }
    
    entry->value = value;
    entry->initialized = true;
    return true;
}

bool SymbolTable::exists(const std::string& name) const {
    return table.find(name) != table.end();
}

void SymbolTable::print() const {
    printf("\n=== SYMBOL TABLE ===\n");
    printf("%-20s %-15s %-10s %-12s\n", "Variable", "Type", "Value", "Init");
    printf("%-20s %-15s %-10s %-12s\n", "--------", "----", "-----", "----");
    
    for (const auto& pair : table) {
        const SymbolEntry& entry = pair.second;
        printf("%-20s %-15s %-10d %-12s\n",
               entry.name.c_str(),
               entry.type.c_str(),
               entry.value,
               entry.initialized ? "Yes" : "No");
    }
    printf("===================\n\n");
}

void SymbolTable::addError(const std::string& error) {
    errors.push_back(error);
    std::cerr << error << std::endl;
}

void SymbolTable::printErrors() const {
    if (!errors.empty()) {
        printf("\n=== ERRORS ===\n");
        for (const auto& error : errors) {
            printf("%s\n", error.c_str());
        }
        printf("==============\n\n");
    }
}

void SymbolTable::clear() {
    table.clear();
    errors.clear();
}
