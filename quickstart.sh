#!/bin/bash
# Quick start script for Linux/Mac

echo ""
echo "========================================"
echo "  HeroScript Compiler - Full Stack"
echo "========================================"
echo ""

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js not found! Please install from https://nodejs.org/"
    exit 1
fi

echo "✓ Node.js found"
echo ""

# Install backend dependencies
echo "Installing backend dependencies..."
cd backend
if [ ! -d "node_modules" ]; then
    npm install
else
    echo "✓ Backend dependencies already installed"
fi
cd ..

echo ""
echo "Installing frontend dependencies..."
cd frontend
if [ ! -d "node_modules" ]; then
    npm install
else
    echo "✓ Frontend dependencies already installed"
fi
cd ..

echo ""
echo "========================================"
echo "Ready to run! Open two terminals and run:"
echo ""
echo "Terminal 1: cd backend && npm start"
echo "Terminal 2: cd frontend && npm run dev"
echo ""
echo "Then open: http://localhost:3000"
echo "========================================"
echo ""
