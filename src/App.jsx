import { useState, useEffect, useRef } from 'react'
import { supabase } from './supabaseClient'

// Draggable debug overlay component
const DebugOverlay = ({ logs, isVisible, onClose }) => {
  const [position, setPosition] = useState({ x: 20, y: 20 });
  const [isDragging, setIsDragging] = useState(false);
  const [dragStart, setDragStart] = useState({ x: 0, y: 0 });
  const overlayRef = useRef(null);

  const handleMouseDown = (e) => {
    // Only drag when clicking the header
    if (e.target.classList.contains('debug-header')) {
      setIsDragging(true);
      setDragStart({
        x: e.clientX - position.x,
        y: e.clientY - position.y,
      });
      overlayRef.current.style.cursor = 'grabbing';
    }
  };

  const handleMouseMove = (e) => {
    if (isDragging) {
      setPosition({
        x: e.clientX - dragStart.x,
        y: e.clientY - dragStart.y,
      });
    }
  };

  const handleMouseUp = () => {
    if (isDragging) {
      setIsDragging(false);
      overlayRef.current.style.cursor = 'default';
    }
  };
  
  useEffect(() => {
    // These listeners are added to the window to allow dragging outside the overlay bounds.
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

// Reusable component for each AI function
const AiFunctionModule = ({ title, functionName, text, prompt, setPrompt, response, setResponse, setError, log, setText, caretPosition }) => {
  const [loading, setLoading] = useState(false)

  const handleInvoke = async () => {
    let logText = text;
    if (functionName === 'write') {
      logText = text.substring(0, caretPosition) + '[CURSOR]' + text.substring(caretPosition);
    }
    log(`Invoking function: '${functionName}'. Prompt: "${prompt}". Text: "${logText.substring(0, 50)}..."`);
    
    setLoading(true)
    setResponse('')
    setError('')

    if (!prompt) {
      const msg = 'A prompt is required to get a response.'
      log(`Error: ${msg}`)
      setError(msg)
      setLoading(false)
      return
    }

    if ((functionName === 'rewrite' || functionName === 'describe') && !text) {
      const msg = 'Text is required to rewrite or describe.'
      log(`Error: ${msg}`)
      setError(msg)
      setLoading(false)
      return
    }

    try {
      log('Getting user session...');
      const { data: { session } } = await supabase.auth.getSession()
      if (!session) {
        const msg = 'You must be logged in to use this feature.'
        log(`Error: ${msg}`)
        setError(msg)
        setLoading(false)
        return
      }
      log(`Session found for user: ${session.user.email}`);

      const url = `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/${functionName}`;
      log(`Fetching from URL: ${url}`);
      
      let body;
      if (functionName === 'write') {
        body = JSON.stringify({
          text: text.substring(0, caretPosition) + '[CURSOR]' + text.substring(caretPosition),
          prompt
        });
      } else {
        body = JSON.stringify({ text, prompt });
      }

      const response = await fetch(
        url,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${session.access_token}`,
          },
          body: body,
        }
      )

      log(`Received response with status: ${response.status}`);
      if (!response.ok) {
        const errorText = await response.text();
        log(`Error response body: ${errorText}`);
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const contentType = response.headers.get('content-type');

      if (functionName === 'write') {
        // Handle streaming insertion for 'write'
        log('Handling streaming insert for "Write Paragraph".');
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
                  // Live update the text area to show streaming
                  setText(textBeforeCursor + streamedInsert + textAfterCursor);
                }
              } catch (e) {
                log(`Error parsing insert stream data chunk: ${data} - ${e.message}`);
              }
            }
          }
        }

        log('Stream insert finished. Adding newlines.');
        // Final update to add newlines
        setText(textBeforeCursor + streamedInsert + '\n\n' + textAfterCursor);

      } else if (contentType && contentType.includes('application/json')) {
        // Handle JSON response for 'rewrite'
        log('Handling JSON response.');
        const data = await response.json();
        log(`Received rewrite options: ${JSON.stringify(data)}`);
        setResponse(data);
      } else {
        // Handle stream for 'describe'
        log('Handling stream response.');
        const reader = response.body.getReader()
        const decoder = new TextDecoder()
        let streamedResponse = ''
        setResponse(streamedResponse)
        log('Starting to process stream...');

        while (true) {
          const { done, value } = await reader.read()
          if (done) {
            log('Stream processing finished.');
            break
          }

          const chunk = decoder.decode(value)
          const lines = chunk.split('\n')
          
          for (const line of lines) {
            if (line.startsWith('data: ')) {
              const data = line.substring(6)
              if (data.trim() === '[DONE]') {
                break
              }
              try {
                const parsed = JSON.parse(data)
                if (parsed.choices && parsed.choices[0].delta.content) {
                  streamedResponse += parsed.choices[0].delta.content
                  setResponse(streamedResponse)
                }
              } catch (e) {
                log(`Error parsing stream data chunk: ${data} - ${e.message}`);
              }
            }
          }
        }
      }
    } catch (e) {
      log(`Caught error: ${e.message}`);
      log(e.stack);
      setError(`Function call failed: ${e.message}`)
      setResponse('')
    } finally {
      log('Invoke function finished.');
      setLoading(false)
    }
  }

  return (
    <div className="function-module">
      <h3>{title}</h3>
      <div className="prompt-container">
        <label>Prompt:</label>
        <input 
          type="text"
          value={prompt}
          onChange={(e) => setPrompt(e.target.value)}
          placeholder={`Enter a prompt to ${functionName}...`}
        />
      </div>
      <button onClick={handleInvoke} disabled={loading}>
        {loading ? 'Generating...' : `Run ${title}`}
      </button>
      
      {response && functionName === 'rewrite' && response.options ? (
        <div className="response-container options-container">
          <h4>Select a Rewrite Option:</h4>
          <ul>
            {response.options.map((option, index) => (
              <li key={index} onClick={() => {
                log(`Selected rewrite option ${index + 1}`);
                setText(option);
                setResponse(null);
              }}>
                {option}
              </li>
            ))}
          </ul>
        </div>
      ) : response && (
        <div className="response-container">
          <h4>AI Output:</h4>
          <p>{response}</p>
        </div>
      )}
    </div>
  )
}

// Main App Component
function App() {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [authLoading, setAuthLoading] = useState(false)

  const [text, setText] = useState("The old airship, 'The Wanderer,' creaked as it drifted thru the twilight sky. Below, the neon-drenched city of Neo-Veridia pulsed with life, a stark contrast to the quiet solitude of the cockpit. Elara checked the pressure gauges for the tenth time, her brow furrowed with a familiar worry. The storm clouds on the horizon were unlike any she'd ever seen, swirling with an unnatural green light. \n\nSuddenly, a static-filled message crackled over the intercom, a voice speaking in a language she didnt recognize. It was sharp, guttural, and seemed to repeat a single phrase. Her heart pounded in her chest. This was not a standard communication frequency, and The Wanderer was suppose to be the only vessel in this sector. She adjusted her headset, trying to isolate the signal, her fingers flying across the controlls. The green clouds loomed closer, and with them, a sense of impending discovery.")
  const [writePrompt, setWritePrompt] = useState('Continue the story with a new paragraph that introduces a mysterious signal.')
  const [rewritePrompt, setRewritePrompt] = useState('Rewrite the following text to be more concise.')
  const [describePrompt, setDescribePrompt] = useState('Describe the setting and mood of the following text in a single sentence.')
  const [writeResponse, setWriteResponse] = useState('')
  const [rewriteResponse, setRewriteResponse] = useState('')
  const [describeResponse, setDescribeResponse] = useState('')
  
  const [error, setError] = useState('')
  
  const [debugLogs, setDebugLogs] = useState([]);
  const [showDebug, setShowDebug] = useState(true);
  const [caretPosition, setCaretPosition] = useState(0);

  const log = (message) => {
    const timestamp = new Date().toLocaleTimeString();
    setDebugLogs(prevLogs => [`[${timestamp}] ${message}`, ...prevLogs]);
  };

  useEffect(() => {
    log('App component mounted. Initializing session.');
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null)
      setLoading(false)
      log(session ? `Session found for ${session.user.email}`: 'No active session.');
    })

    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        setUser(session?.user ?? null)
        setLoading(false)
        log(`Auth state changed: ${event}. User is ${session ? 'authenticated' : 'not authenticated'}.`);
      }
    )

    return () => {
      log('App component unmounted.');
      subscription.unsubscribe()
    }
  }, [])

  const handleSignUp = async (e) => {
    e.preventDefault()
    log(`Attempting to sign up with email: ${email}`);
    setAuthLoading(true)
    setError('')
    const { error } = await supabase.auth.signUp({ email, password })
    if (error) {
      log(`Sign up failed: ${error.message}`);
      setError(error.message)
    } else {
      log('Sign up successful. Confirmation email sent.');
      alert('Check your email for the confirmation link!')
    }
    setAuthLoading(false)
  }

  const handleSignIn = async (e) => {
    e.preventDefault()
    log(`Attempting to sign in with email: ${email}`);
    setAuthLoading(true)
    setError('')
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    if (error) {
      log(`Sign in failed: ${error.message}`);
      setError(error.message)
    } else {
      log('Sign in successful.');
    }
    setAuthLoading(false)
  }

  const handleSignOut = async () => {
    log('Attempting to sign out.');
    const { error } = await supabase.auth.signOut()
    if (error) {
      log(`Sign out failed: ${error.message}`);
      setError(error.message)
    } else {
      log('Sign out successful.');
    }
  }

  const handleTextSelect = (e) => {
    setCaretPosition(e.target.selectionStart);
  };

  if (loading) {
    return <div className="container">Loading...</div>
  }

  return (
    <div>
      <DebugOverlay logs={debugLogs} isVisible={showDebug} onClose={() => setShowDebug(false)} />
      
      {user && (
        <nav className="top-nav">
          <h1>AI Writing Assistant</h1>
          <div className="nav-user-info">
            <span className="user-email">{user.email}</span>
            <button className="sign-out-btn" onClick={handleSignOut}>Sign Out</button>
            <button onClick={() => setShowDebug(!showDebug)}>{showDebug ? 'Hide' : 'Show'} Debug</button>
          </div>
        </nav>
      )}

      <div className="container">
        {!user ? (
          <div className="auth-container">
            <h1>AI Writing Assistant</h1>
            <p>Please sign in to continue</p>
            <form className="auth-form">
              <input
                type="email"
                placeholder="Email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
              <input
                type="password"
                placeholder="Password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
              <button type="button" onClick={handleSignIn} disabled={authLoading}>
                {authLoading ? 'Signing in...' : 'Sign In'}
              </button>
              <button type="button" onClick={handleSignUp} disabled={authLoading}>
                {authLoading ? 'Signing up...' : 'Sign Up'}
              </button>
            </form>
          </div>
        ) : (
          <div className="main-content">
            <div className="text-input-container">
              <label htmlFor="main-text">Your Text:</label>
              <textarea
                id="main-text"
                value={text}
                onChange={(e) => setText(e.target.value)}
                onSelect={handleTextSelect}
                placeholder="Enter your content here..."
                rows="10"
              />
            </div>

            <div className="functions-grid">
              <AiFunctionModule
                title="Write Paragraph"
                functionName="write"
                text={text}
                prompt={writePrompt}
                setPrompt={setWritePrompt}
                response={writeResponse}
                setResponse={setWriteResponse}
                setError={setError}
                setText={setText}
                caretPosition={caretPosition}
                log={log}
              />
              <AiFunctionModule
                title="Rewrite"
                functionName="rewrite"
                text={text}
                prompt={rewritePrompt}
                setPrompt={setRewritePrompt}
                response={rewriteResponse}
                setResponse={setRewriteResponse}
                setError={setError}
                setText={setText}
                log={log}
              />
              <AiFunctionModule
                title="Describe"
                functionName="describe"
                text={text}
                prompt={describePrompt}
                setPrompt={setDescribePrompt}
                response={describeResponse}
                setResponse={setDescribeResponse}
                setError={setError}
                setText={setText}
                log={log}
              />
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
    </div>
  )
}

export default App