@echo off
REM Quick start script for Windows

echo.
echo ========================================
echo   HeroScript Compiler - Full Stack
echo ========================================
echo.

echo Checking for Node.js...
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found! Please install from https://nodejs.org/
    pause
    exit /b 1
)

echo ✓ Node.js found
echo.

echo Installing backend dependencies...
cd backend
if not exist node_modules (
    call npm install
) else (
    echo ✓ Backend dependencies already installed
)
cd ..

echo.
echo Installing frontend dependencies...
cd frontend
if not exist node_modules (
    call npm install
) else (
    echo ✓ Frontend dependencies already installed
)
cd ..

echo.
echo ========================================
echo Ready to run! Open two terminals and run:
echo.
echo Terminal 1: cd backend
echo           npm start
echo.
echo Terminal 2: cd frontend
echo           npm run dev
echo.
echo Then open: http://localhost:3000
echo ========================================
echo.
pause
exit /b 0
