import { useState, useEffect } from 'react'
import { supabase } from './supabaseClient'

function App() {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [authLoading, setAuthLoading] = useState(false)
  const [testLoading, setTestLoading] = useState(false)
  const [response, setResponse] = useState('')
  const [error, setError] = useState('')

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null)
      setLoading(false)
    })

    // Listen for auth changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      (event, session) => {
        setUser(session?.user ?? null)
        setLoading(false)
      }
    )

    return () => subscription.unsubscribe()
  }, [])

  const handleSignUp = async (e) => {
    e.preventDefault()
    setAuthLoading(true)
    setError('')

    const { error } = await supabase.auth.signUp({
      email,
      password,
    })

    if (error) {
      setError(error.message)
    } else {
      setError('')
      alert('Check your email for the confirmation link!')
    }
    setAuthLoading(false)
  }

  const handleSignIn = async (e) => {
    e.preventDefault()
    setAuthLoading(true)
    setError('')

    const { error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })

    if (error) {
      setError(error.message)
    }
    setAuthLoading(false)
  }

  const handleSignOut = async () => {
    const { error } = await supabase.auth.signOut()
    if (error) {
      setError(error.message)
    }
  }

  const testEdgeFunction = async () => {
    setTestLoading(true)
    setResponse('')
    setError('')

    try {
      // Get the current session to include the JWT token
      const { data: { session } } = await supabase.auth.getSession()
      
      if (!session) {
        setError('No active session found')
        return
      }

      const { data, error } = await supabase.functions.invoke('openai-chat', {
        body: {
          message: 'Hello! This is a test message from my React app.'
        },
        headers: {
          Authorization: `Bearer ${session.access_token}`,
        },
      })

      if (error) {
        setError(error.message || 'Function call failed')
      } else {
        setResponse(JSON.stringify(data, null, 2))
      }
    } catch (err) {
      setError(err.message)
    }
    setTestLoading(false)
  }

  if (loading) {
    return <div className="container">Loading...</div>
  }

  return (
    <div className="container">
      <h1>Supabase + OpenAI Demo</h1>
      
      {!user ? (
        <div>
          <h2>Authentication</h2>
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
            <button 
              type="button" 
              onClick={handleSignIn}
              disabled={authLoading}
            >
              {authLoading ? 'Signing in...' : 'Sign In'}
            </button>
            <button 
              type="button" 
              onClick={handleSignUp}
              disabled={authLoading}
            >
              {authLoading ? 'Signing up...' : 'Sign Up'}
            </button>
          </form>
        </div>
      ) : (
        <div>
          <div className="user-info">
            <h2>Welcome!</h2>
            <p>Email: {user.email}</p>
            <p>User ID: {user.id}</p>
            <button onClick={handleSignOut}>Sign Out</button>
          </div>

          <div className="test-section">
            <h3>Test Edge Function</h3>
            <p>Click the button below to test the OpenAI edge function:</p>
            <button 
              className="test-button"
              onClick={testEdgeFunction}
              disabled={testLoading}
            >
              {testLoading ? 'Calling OpenAI...' : 'Test OpenAI Function'}
            </button>

            {response && (
              <div>
                <h4>Response:</h4>
                <div className="response">{response}</div>
              </div>
            )}
          </div>
        </div>
      )}

      {error && (
        <div className="error">
          <strong>Error:</strong> {error}
        </div>
      )}
    </div>
  )
}

export default App