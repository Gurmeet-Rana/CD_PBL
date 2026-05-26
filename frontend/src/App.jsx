import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

export default function App() {
  const [code, setCode] = useState(`assemble scalar power_level initialized to 9000;
assemble binary is_active initialized to yes;

check (power_level above 8000) then {
    shout (power_level);
    update power_level to power_level plus 100;
} otherwise {
    update is_active to no;
}

repeat (10) {
    update power_level to power_level minus 1;
}`);
  
  const [output, setOutput] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [status, setStatus] = useState('Ready');

  // Check backend health on mount
  useEffect(() => {
    checkHealth();
  }, []);

  const checkHealth = async () => {
    try {
      const response = await axios.get('/api/health');
      setStatus(`✓ Connected - ${response.data.compiler}`);
    } catch (err) {
      setStatus('✗ Backend not available');
    }
  };

  const handleCompile = async () => {
    setLoading(true);
    setError('');
    setOutput('');

    try {
      const response = await axios.post('/api/compile', { code });
      
      if (response.data.success) {
        setOutput(response.data.output);
        setStatus('✓ Compilation successful');
      } else {
        setError(response.data.error || 'Compilation failed');
        setStatus('✗ Compilation failed');
      }
    } catch (err) {
      const errorMsg = err.response?.data?.error || err.message;
      setError(errorMsg);
      setStatus('✗ Error');
    } finally {
      setLoading(false);
    }
  };

  const loadExample = (exampleName) => {
    const examples = {
      basic: `assemble scalar x initialized to 5;
assemble scalar y initialized to 10;
update x to x plus y;
shout (x);`,
      loop: `assemble scalar i initialized to 0;

repeat (5) {
    shout (i);
    update i to i plus 1;
}`,
      conditional: `assemble scalar score initialized to 85;

check (score above 80) then {
    shout (100);
} otherwise {
    shout (0);
}`
    };
    setCode(examples[exampleName] || code);
  };

  return (
    <div className="container">
      <header className="header">
        <h1>⚔️ HeroScript Compiler IDE</h1>
        <p className="subtitle">A gaming-themed domain-specific language compiler</p>
      </header>

      <div className="status-bar">
        <span className="status">{status}</span>
        <button className="btn-small" onClick={checkHealth}>Check Connection</button>
      </div>

      <div className="main-content">
        <div className="editor-panel">
          <div className="panel-header">
            <h2>📝 Code Editor</h2>
            <div className="example-buttons">
              <button className="btn-example" onClick={() => loadExample('basic')}>Basic</button>
              <button className="btn-example" onClick={() => loadExample('loop')}>Loop</button>
              <button className="btn-example" onClick={() => loadExample('conditional')}>Conditional</button>
            </div>
          </div>
          <textarea
            className="editor"
            value={code}
            onChange={(e) => setCode(e.target.value)}
            placeholder="Write your HeroScript code here..."
          />
          <button 
            className="btn-compile"
            onClick={handleCompile}
            disabled={loading}
          >
            {loading ? '⏳ Compiling...' : '🚀 Compile'}
          </button>
        </div>

        <div className="output-panel">
          <div className="panel-header">
            <h2>📤 Compilation Output</h2>
          </div>
          
          {error && (
            <div className="error-box">
              <strong>❌ Error:</strong>
              <pre>{error}</pre>
            </div>
          )}
          
          {output && (
            <div className="success-box">
              <pre>{output}</pre>
            </div>
          )}
          
          {!error && !output && (
            <div className="placeholder">
              Click "Compile" to see the output here...
            </div>
          )}
        </div>
      </div>

      <footer className="footer">
        <p>HeroScript Compiler | Compiler Design Project</p>
      </footer>
    </div>
  );
}
