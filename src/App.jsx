import { useState, useEffect, useRef } from 'react'
import { supabase } from './supabaseClient'
import { Auth } from '@supabase/auth-ui-react';
import { ThemeSupa } from '@supabase/auth-ui-shared';

// New component for highlighting word-level differences
const DiffHighlight = ({ original, corrected }) => {
  const originalWords = original.split(/(\\s+)/);
  const correctedWords = corrected.split(/(\\s+)/);

  const correctedMap = correctedWords.reduce((acc, word) => {
    acc[word] = (acc[word] || 0) + 1;
    return acc;
  }, {});

  return (
    <p>
      {originalWords.map((word, i) => {
        if (word.match(/\\s+/)) return <span key={i}>{word}</span>;
        if (!correctedMap[word] || correctedMap[word] < 1) {
          return <span key={i} className="diff-removed">{word}</span>;
        }
        correctedMap[word]--;
        return <span key={i}>{word}</span>;
      })}
    </p>
  );
};

const CorrectedHighlight = ({ original, corrected }) => {
  const originalWords = original.split(/(\\s+)/);
  const correctedWords = corrected.split(/(\\s+)/);

  const originalMap = originalWords.reduce((acc, word) => {
    acc[word] = (acc[word] || 0) + 1;
    return acc;
  }, {});

  return (
    <p>
      {correctedWords.map((word, i) => {
        if (word.match(/\\s+/)) return <span key={i}>{word}</span>;
        if (!originalMap[word] || originalMap[word] < 1) {
          return <span key={i} className="diff-added">{word}</span>;
        }
        originalMap[word]--;
        return <span key={i}>{word}</span>;
      })}
    </p>
  );
};

// Draggable debug overlay component
const DebugOverlay = ({ logs, isVisible, onClose }) => {
  const [position, setPosition] = useState({ x: 20, y: 20 });
  const [isDragging, setIsDragging] = useState(false);
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 });
  const overlayRef = useRef(null);

  const handleMouseDown = (e) => {
    if (e.target.classList.contains('debug-header')) {
      setIsDragging(true);
      setDragStart({ x: e.clientX - position.x, y: e.clientY - position.y });
      overlayRef.current.style.cursor = 'grabbing';
    }
  };

  const handleMouseMove = (e) => {
    if (isDragging) {
      setPosition({ x: e.clientX - dragStart.x, y: e.clientY - dragStart.y });
    }
  };

  const handleMouseUp = () => {
    if (isDragging) {
      setIsDragging(false);
      overlayRef.current.style.cursor = 'default';
    }
  };
  
  useEffect(() => {
    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('mouseup', handleMouseUp);

    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('mouseup', handleMouseUp);
    };
  }, [isDragging, dragStart]);
  
  if (!isVisible) return null

  return (
    <div
      ref={overlayRef}
      className="debug-overlay"
      style={{ top: `${position.y}px`, left: `${position.x}px` }}
      onMouseDown={handleMouseDown}
    >
      <div className="debug-header">
        <h4>Debug Log</h4>
        <button onClick={onClose} className="close-btn">&times;</button>
      </div>
      <div className="debug-content">
        {logs.map((log, index) => (
          <div key={index} className="log-entry">{log}</div>
        ))}
      </div>
    </div>
  );
};

// Reusable component for each AI function module
const AiFunctionModule = ({ title, children }) => (
  <div className="function-module">
    <h3>{title}</h3>
    {children}
  </div>
);

// Main App Component
function App() {
  const [session, setSession] = useState(null)
  const [loading, setLoading] = useState(true)

  const [text, setText] = useState("The old airship, 'The Wanderer,' creaked as it drifted thru the twilight sky. Below, the neon-drenched city of Neo-Veridia pulsed with life, a stark contrast to the quiet solitude of the cockpit. Elara checked the pressure gauges for the tenth time, her brow furrowed with a familiar worry. The storm clouds on the horizon were unlike any she'd ever seen, swirling with an unnatural green light. \n\nSuddenly, a static-filled message crackled over the intercom, a voice speaking in a language she didnt recognize. It was sharp, guttural, and seemed to repeat a single phrase. Her heart pounded in her chest. This was not a standard communication frequency, and The Wanderer was suppose to be the only vessel in this sector. She adjusted her headset, trying to isolate the signal, her fingers flying across the controlls. The green clouds loomed closer, and with them, a sense of impending discovery.")
  
  // Restore separate prompts and responses
  const [writePrompt, setWritePrompt] = useState('Continue the story with a new paragraph that introduces a mysterious signal.');
  const [rewritePrompt, setRewritePrompt] = useState('Rewrite the text with more descriptive and flowery language.');
  const [describePrompt, setDescribePrompt] = useState('Describe the setting and mood of the text in a single sentence.');
  const [describeResponse, setDescribeResponse] = useState('');
  const [rewriteOptions, setRewriteOptions] = useState([]);
  
  const [error, setError] = useState('')
  const [loadingFunction, setLoadingFunction] = useState(null);
  
  const [debugLogs, setDebugLogs] = useState([]);
  const [showDebug, setShowDebug] = useState(true);
  const [caretPosition, setCaretPosition] = useState(0);
  const [selectionRange, setSelectionRange] = useState({ start: 0, end: 0 });

  const [spellcheckVisible, setSpellcheckVisible] = useState(false);
  const [spellcheckCorrections, setSpellcheckCorrections] = useState([]);
  const [originalTextForSpellcheck, setOriginalTextForSpellcheck] = useState('');
  const [spellcheckSelections, setSpellcheckSelections] = useState({});

  const textAreaRef = useRef(null);
  const log = (message) => {
    const timestamp = new Date().toLocaleTimeString();
    setDebugLogs(prevLogs => [`[${timestamp}] ${message}`, ...prevLogs]);
  };

  useEffect(() => {
    log('App component mounted. Initializing session.');
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session)
      setLoading(false)
      log(session ? `Session found for ${session.user.email}`: 'No active session.');
    })

    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        setSession(session)
        setLoading(false)
        log(`Auth state changed: ${event}. User is ${session ? 'authenticated' : 'not authenticated'}.`);
      }
    )

    return () => {
      log('App component unmounted.');
      subscription.unsubscribe()
    }
  }, [])

  const handleSignOut = async () => {
    log('Attempting to sign out.');
    await supabase.auth.signOut()
    log('Sign out successful.');
  }

  const handleTextSelect = (e) => {
    setCaretPosition(e.target.selectionStart);
    setSelectionRange({ start: e.target.selectionStart, end: e.target.selectionEnd });
  };

  const handleSpellcheck = async () => {
    if (!text.trim()) return alert('Please enter text to spellcheck.');
    log('[handleSpellcheck] Starting spellcheck...');
    setLoadingFunction('spellcheck');
    setOriginalTextForSpellcheck(text);

    try {
      const { data, error } = await supabase.functions.invoke('spellcheck', {
        body: { text },
      });

      if (error) {
        throw error;
      }

      log(`[handleSpellcheck] Response received: ${JSON.stringify(data)}`);
      
      if (Array.isArray(data)) {
        if (data.length === 0) {
          log('[handleSpellcheck] No corrections found.');
          alert('No spelling or grammar errors found.');
        } else {
          const initialSelections = {};
          data.forEach((_, index) => {
            initialSelections[index] = 'corrected';
          });
          setSpellcheckSelections(initialSelections);
          setSpellcheckCorrections(data);
          setSpellcheckVisible(true);
        }
      } else {
        log(`[handleSpellcheck] Error: Response data is not an array.`);
        alert('Received an unexpected format from the spellcheck function.');
      }

    } catch (error) {
      log(`[handleSpellcheck] Error: ${error.message}`);
      alert(`An error occurred: ${error.message}`);
    } finally {
      setLoadingFunction(null);
    }
  };

  if (loading) {
    return <div className="container">Loading...</div>
  }

  const getUrl = (functionName) => `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/${functionName}`;

  const getHeaders = async () => {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      log('Error: No active session found.');
      throw new Error('You must be logged in to use this feature.');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${session.access_token}`,
    };
  };

  const handleWrite = async () => {
    if (!writePrompt.trim()) {
      alert('Please enter a prompt to continue writing.');
      return;
    }
    log(`[Write] Invoking with prompt: "${writePrompt}"`);
    setLoadingFunction('write');
    setRewriteOptions([]);
    setDescribeResponse('');
    
    try {
      const headers = await getHeaders();
      const textWithCursor = text.substring(0, caretPosition) + '[CURSOR]' + text.substring(caretPosition);
      
      const response = await fetch(getUrl('write'), {
        method: 'POST',
        headers,
        body: JSON.stringify({ text: textWithCursor, prompt: writePrompt }),
      });

      if (!response.ok) throw new Error(await response.text());
      if (!response.body) throw new Error('Response body is empty.');

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      const textBeforeCursor = text.substring(0, caretPosition);
      const textAfterCursor = text.substring(caretPosition);
      let streamedInsert = '';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value);
        const lines = chunk.split('\n');
        for (const line of lines) {
          if (line.startsWith('data: ')) {
            const data = line.substring(6);
            if (data.trim() === '[DONE]') break;
            try {
              const parsed = JSON.parse(data);
              if (parsed.choices && parsed.choices[0].delta.content) {
                streamedInsert += parsed.choices[0].delta.content;
                setText(textBeforeCursor + streamedInsert + textAfterCursor);
              }
            } catch (e) {
              log(`[Write] Stream parsing error: ${e.message}`);
            }
          }
        }
      }
      setText(textBeforeCursor + streamedInsert + '\n\n' + textAfterCursor);
      log('[Write] Stream finished.');

    } catch (error) {
      log(`[Write] Error: ${error.message}`);
      setError(`Write failed: ${error.message}`);
    } finally {
      setLoadingFunction(null);
    }
  };

  const handleRewrite = async () => {
    const { start, end } = selectionRange;
    
    // The button should be disabled, but as a safeguard, do nothing if called without a selection.
    if (start === end) {
      log('[Rewrite] Aborted: No text selected.');
      return;
    }

    const selectedText = text.substring(start, end);

    log(`[Rewrite] Invoking for selected text: "${selectedText.substring(0, 50)}..."`);
    setLoadingFunction('rewrite');
    setRewriteOptions([]);
    setDescribeResponse('');
    
    try {
      const { data, error } = await supabase.functions.invoke('rewrite', {
        body: { text: selectedText, prompt: rewritePrompt },
      });

      if (error) throw error;

      if (data.options) {
        setRewriteOptions(data.options);
        log(`[Rewrite] Received ${data.options.length} options.`);
      } else {
         throw new Error('Invalid response format from rewrite function. Expected "options" key.');
      }
    } catch (e) {
      log(`[Rewrite] Error: ${e.message}`);
      setError(`Rewrite failed: ${e.message}`);
    } finally {
      setLoadingFunction(null);
    }
  };

  const handleDescribe = async () => {
    if (!text.trim()) {
      alert('Please enter some text to describe.');
      return;
    }
    log(`[Describe] Invoking with prompt: "${describePrompt}"`);
    setLoadingFunction('describe');
    setDescribeResponse('');
    setRewriteOptions([]);

    try {
      const headers = await getHeaders();
      const response = await fetch(getUrl('describe'), {
        method: 'POST',
        headers,
        body: JSON.stringify({ text, prompt: describePrompt }),
      });

      if (!response.ok) throw new Error(await response.text());
      if (!response.body) throw new Error('Response body is empty.');

      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let streamedResponse = '';

      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        const chunk = decoder.decode(value);
        const lines = chunk.split('\n');
        for (const line of lines) {
          if (line.startsWith('data: ')) {
            const data = line.substring(6);
            if (data.trim() === '[DONE]') break;
            try {
              const parsed = JSON.parse(data);
              if (parsed.choices && parsed.choices[0].delta.content) {
                streamedResponse += parsed.choices[0].delta.content;
                setDescribeResponse(streamedResponse);
              }
            } catch (e) {
              log(`[Describe] Stream parsing error: ${e.message}`);
            }
          }
        }
      }
      log(`[Describe] Stream finished.`);
    } catch (e) {
      log(`[Describe] Error: ${e.message}`);
      setError(`Describe failed: ${e.message}`);
    } finally {
      setLoadingFunction(null);
    }
  };

  return (
    <div>
      <DebugOverlay logs={debugLogs} isVisible={showDebug} onClose={() => setShowDebug(false)} />
      
      {session && (
        <nav className="top-nav">
          <h1>AI Writing Assistant</h1>
          <div className="nav-user-info">
            <span className="user-email">{session.user.email}</span>
            <button className="sign-out-btn" onClick={handleSignOut}>Sign Out</button>
            <button onClick={() => setShowDebug(!showDebug)}>{showDebug ? 'Hide' : 'Show'} Debug</button>
          </div>
        </nav>
      )}

      <div className="container">
        {!session ? (
          <div className="auth-container">
            <h1>AI Writing Assistant</h1>
            <p>Please sign in to continue</p>
            <Auth supabaseClient={supabase} appearance={{ theme: ThemeSupa }} />
          </div>
        ) : (
          <div className="main-content">
            <div className="text-input-container">
              <label htmlFor="main-text">Your Text:</label>
              <textarea
                id="main-text"
                ref={textAreaRef}
                value={text}
                onChange={(e) => setText(e.target.value)}
                onSelect={handleTextSelect}
                onClick={handleTextSelect}
                onKeyUp={handleTextSelect}
                placeholder="Enter your content here..."
                rows="15"
              />
            </div>
            
            {/* Spellcheck button moved above the grid */}
            <div className="spellcheck-container">
              <button onClick={handleSpellcheck} disabled={loadingFunction || !text.trim()} className="function-button spellcheck-button">
                {loadingFunction === 'spellcheck' ? 'Checking...' : 'Spellcheck'}
              </button>
            </div>

            <div className="functions-grid">
              {/* Write Module */}
              <AiFunctionModule title="Write">
                <div className="prompt-container">
                  <label>Prompt:</label>
                  <input type="text" value={writePrompt} onChange={(e) => setWritePrompt(e.target.value)} />
                </div>
                <button onClick={handleWrite} disabled={loadingFunction} className="function-button">
                  {loadingFunction === 'write' ? 'Writing...' : 'Write'}
                </button>
              </AiFunctionModule>
              
              {/* Rewrite Module */}
              <AiFunctionModule title="Rewrite">
                <div className="prompt-container">
                  <label>Prompt:</label>
                  <input type="text" value={rewritePrompt} onChange={(e) => setRewritePrompt(e.target.value)} />
                </div>
                <button onClick={handleRewrite} disabled={loadingFunction || (selectionRange.start === selectionRange.end)} className="function-button">
                  {loadingFunction === 'rewrite' ? 'Rewriting...' : 'Rewrite'}
                </button>
                {rewriteOptions.length > 0 && (
                  <div className="response-container options-container">
                    <h4>Select a Rewrite Option:</h4>
                    <ul>
                      {rewriteOptions.map((option, index) => (
                        <li key={index} onClick={() => {
                          const { start, end } = selectionRange;
                          const newText = text.substring(0, start) + option + text.substring(end);
                          setText(newText);
                          setRewriteOptions([]);
                        }}>{option}</li>
                      ))}
                    </ul>
                  </div>
                )}
              </AiFunctionModule>

              {/* Describe Module */}
              <AiFunctionModule title="Describe">
                <div className="prompt-container">
                  <label>Prompt:</label>
                  <input type="text" value={describePrompt} onChange={(e) => setDescribePrompt(e.target.value)} />
                </div>
                <button onClick={handleDescribe} disabled={loadingFunction || !text.trim()} className="function-button">
                  {loadingFunction === 'describe' ? 'Describing...' : 'Describe'}
                </button>
                {describeResponse && (
                  <div className="response-container">
                    <h4>AI Output:</h4>
                    <p>{describeResponse}</p>
                  </div>
                )}
              </AiFunctionModule>
            </div>
          </div>
        )}

        {error && (
          <div className="error-container">
            <p className="error-message">Error: {error}</p>
            <button onClick={() => {
              log('Dismissing error message.');
              setError('');
            }}>Dismiss</button>
          </div>
        )}
      </div>

      {spellcheckVisible && (
        <div className="overlay">
          <div className="overlay-content spellcheck-overlay">
            <h2>Spellcheck Results</h2>
            <p>For each pair, click to select the version you want to keep. The other will be dimmed.</p>
            <div className="spellcheck-diff-container">
              {spellcheckCorrections.map((correction, index) => (
                <div key={index} className="spellcheck-pair">
                  <div
                    className={`diff-side ${spellcheckSelections[index] === 'original' ? 'selected' : 'dimmed'}`}
                    onClick={() => setSpellcheckSelections(s => ({ ...s, [index]: 'original' }))}
                  >
                    <h4>Original</h4>
                    <DiffHighlight original={correction.original} corrected={correction.corrected} />
                  </div>
                  <div
                    className={`diff-side ${spellcheckSelections[index] === 'corrected' ? 'selected' : 'dimmed'}`}
                    onClick={() => setSpellcheckSelections(s => ({ ...s, [index]: 'corrected' }))}
                  >
                    <h4>Corrected</h4>
                    <CorrectedHighlight original={correction.original} corrected={correction.corrected} />
                  </div>
                </div>
              ))}
            </div>
            <div className="overlay-buttons">
              <button onClick={() => {
                let newText = originalTextForSpellcheck;
                [...spellcheckCorrections].forEach((correction, index) => {
                  const choice = spellcheckSelections[index];
                  if (choice === 'corrected') {
                    newText = newText.replace(correction.original, correction.corrected);
                  }
                });
                setText(newText);
                setSpellcheckVisible(false);
                log('[Spellcheck] Changes applied based on selection.');
              }}>Apply Selections</button>
              <button onClick={() => setSpellcheckVisible(false)}>Close</button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default App