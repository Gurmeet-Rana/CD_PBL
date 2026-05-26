const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = 5000;

// Middleware
app.use(cors());
app.use(bodyParser.json({ limit: '50mb' }));

// Temp directory for compilation
const TEMP_DIR = path.join(__dirname, 'temp');
if (!fs.existsSync(TEMP_DIR)) {
  fs.mkdirSync(TEMP_DIR);
}

// Get compiler path (adjust based on your system)
const COMPILER_PATH = path.join(__dirname, '..', 'compiler.exe');

/**
 * POST /compile
 * Compiles HeroScript code
 */
app.post('/api/compile', (req, res) => {
  try {
    const { code } = req.body;

    if (!code) {
      return res.status(400).json({ 
        error: 'No code provided' 
      });
    }

    // Check if compiler exists
    if (!fs.existsSync(COMPILER_PATH)) {
      return res.status(500).json({ 
        error: `Compiler not found at ${COMPILER_PATH}` 
      });
    }

    // Create temp file
    const tempId = uuidv4();
    const tempFile = path.join(TEMP_DIR, `${tempId}.hs`);
    fs.writeFileSync(tempFile, code);

    // Execute compiler
    const command = `"${COMPILER_PATH}" "${tempFile}"`;
    const output = execSync(command, { encoding: 'utf-8' });

    // Cleanup
    fs.unlinkSync(tempFile);

    res.json({
      success: true,
      output: output,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    res.status(500).json({
      success: false,
      error: error.message,
      stderr: error.stderr ? error.stderr.toString() : null
    });
  }
});

/**
 * GET /health
 * Health check endpoint
 */
app.get('/api/health', (req, res) => {
  const compilerExists = fs.existsSync(COMPILER_PATH);
  res.json({
    status: 'ok',
    compiler: compilerExists ? 'available' : 'not found',
    compilerPath: COMPILER_PATH
  });
});

/**
 * GET /info
 * Get compiler info
 */
app.get('/api/info', (req, res) => {
  res.json({
    name: 'HeroScript Compiler API',
    version: '1.0.0',
    description: 'Backend API for HeroScript compiler',
    compilerPath: COMPILER_PATH,
    endpoints: {
      'POST /api/compile': 'Compile HeroScript code',
      'GET /api/health': 'Health check',
      'GET /api/info': 'Get API info'
    }
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({ error: 'Endpoint not found' });
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: 'Internal server error' });
});

// Start server
app.listen(PORT, () => {
  console.log(`========================================`);
  console.log(`  HeroScript Compiler API`);
  console.log(`========================================`);
  console.log(`Server running on http://localhost:${PORT}`);
  console.log(`\nEndpoints:`);
  console.log(`  POST   http://localhost:${PORT}/api/compile`);
  console.log(`  GET    http://localhost:${PORT}/api/health`);
  console.log(`  GET    http://localhost:${PORT}/api/info`);
  console.log(`========================================`);
});
