# 🚀 Setup & Run Instructions

## 📦 Project Structure

```
CD_PBL/
├── compiler.exe              # Your C++ compiler (already built)
├── *.hs, *.l, *.y, etc.      # Original compiler files
├── backend/                  # Node.js Express API
└── frontend/                 # React web UI
```

---

## 🔧 Installation

### Prerequisites
- **Node.js** (v16 or higher) - [Download](https://nodejs.org/)
- **npm** (comes with Node.js)
- **compiler.exe** (already in your project root)

### Step 1: Install Backend Dependencies
```bash
cd backend
npm install
```

### Step 2: Install Frontend Dependencies
```bash
cd ../frontend
npm install
```

---

## ▶️ Running the Full Stack

### Terminal 1: Start Backend API
```bash
cd backend
npm start
```

Expected output:
```
========================================
  HeroScript Compiler API
========================================
Server running on http://localhost:5000

Endpoints:
  POST   http://localhost:5000/api/compile
  GET    http://localhost:5000/api/health
  GET    http://localhost:5000/api/info
========================================
```

### Terminal 2: Start Frontend (in a new terminal)
```bash
cd frontend
npm run dev
```

Expected output:
```
  VITE v4.4.0  ready in 123 ms

  ➜  Local:   http://localhost:3000/
```

### Terminal 3: Open in Browser
Simply visit: **http://localhost:3000**

---

## 💻 What You Can Do

1. **Write HeroScript Code** - Use the left editor panel
2. **Compile** - Click the "🚀 Compile" button
3. **View Results** - See output on the right panel
4. **Try Examples** - Click Basic, Loop, or Conditional buttons
5. **Check Status** - Button to verify backend connection

---

## 🐛 Troubleshooting

### Backend won't start?
- Make sure `compiler.exe` exists in the project root
- Check if port 5000 is available: `netstat -ano | findstr :5000`
- Try: `npm install` in backend folder again

### Frontend won't connect?
- Ensure backend is running first (Terminal 1)
- Check if port 3000 is available
- Try: `npm install` in frontend folder again

### Compiler not found error?
- Verify `compiler.exe` exists in `CD_PBL/` root directory
- Run your C++ compiler rebuild if needed:
  ```bash
  flex heroscript_lexer.l
  bison -d hero_parser.y
  g++ -o compiler.exe main.cpp semantics.cpp lex.yy.c hero_parser.tab.c -lm
  ```

---

## 📡 API Endpoints

### Compile Code
```bash
curl -X POST http://localhost:5000/api/compile \
  -H "Content-Type: application/json" \
  -d '{"code":"assemble scalar x initialized to 5; shout (x);"}'
```

### Check Health
```bash
curl http://localhost:5000/api/health
```

### Get API Info
```bash
curl http://localhost:5000/api/info
```

---

## 🛑 Stop the Servers

- **Backend**: Press `Ctrl+C` in Terminal 1
- **Frontend**: Press `Ctrl+C` in Terminal 2

---

## 📝 Next Steps

- Customize the frontend UI further
- Add more compiler features
- Add syntax highlighting with a code editor library
- Deploy to cloud (Azure, Heroku, etc.)

Enjoy! 🎮
