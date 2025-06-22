# Supabase + OpenAI Demo Setup Guide

This is a minimal React app demonstrating Supabase authentication and an edge function that calls OpenAI.

## Prerequisites

- Node.js (16+)
- A Supabase account and project
- An OpenAI API key
- Supabase CLI (for deploying edge functions)

## Setup Steps

### 1. Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new project
2. Wait for the project to initialize
3. Go to Settings > API to get your project URL and anon key

### 2. Configure Frontend

1. Open `src/supabaseClient.js`
2. Replace `YOUR_SUPABASE_PROJECT_URL` with your actual project URL
3. Replace `YOUR_SUPABASE_ANON_KEY` with your actual anon key

### 3. Install Dependencies

```bash
npm install
```

### 4. Deploy Edge Function

1. Install Supabase CLI:
   ```bash
   npm install -g supabase
   ```

2. Login to Supabase:
   ```bash
   supabase login
   ```

3. Link your project:
   ```bash
   supabase link --project-ref YOUR_PROJECT_REF
   ```

4. Set your OpenAI API key as a secret:
   ```bash
   supabase secrets set OPENAI_API_KEY=your_openai_api_key_here
   ```

5. Deploy the edge function:
   ```bash
   supabase functions deploy openai-chat
   ```

### 5. Configure Authentication

1. In your Supabase dashboard, go to Authentication > Settings
2. Make sure "Enable email confirmations" is turned on (or off for testing)
3. Add your local development URL (`http://localhost:5173`) to the allowed redirect URLs

### 6. Run the App

```bash
npm run dev
```

Visit `http://localhost:5173` to test the app.

## How It Works

1. **Authentication**: Users can sign up/sign in using email and password
2. **Edge Function**: Once authenticated, users can click a button to test the edge function
3. **OpenAI Integration**: The edge function receives a message, calls OpenAI's API, and returns the response

## Testing

1. Sign up with a valid email address
2. Check your email for confirmation (if email confirmations are enabled)
3. Sign in to the app
4. Click "Test OpenAI Function" to see the integration in action

## File Structure

```
├── src/
│   ├── App.jsx              # Main React component
│   ├── main.jsx             # React app entry point
│   ├── index.css            # Basic styling
│   └── supabaseClient.js    # Supabase configuration
├── supabase/
│   └── functions/
│       └── openai-chat/
│           └── index.ts     # Edge function code
├── index.html               # HTML template
├── package.json             # Dependencies
└── vite.config.js           # Vite configuration
```

## Troubleshooting

- **CORS errors**: Make sure your edge function includes proper CORS headers
- **Authentication errors**: Check that your Supabase URL and keys are correct
- **Edge function errors**: Check the Supabase logs in your dashboard
- **OpenAI errors**: Verify your API key is set correctly as a secret

## Next Steps

This is a minimal demo. For production use, consider:
- Adding proper error handling and loading states
- Implementing row-level security (RLS) policies
- Adding input validation and sanitization
- Using environment variables for configuration
- Adding proper TypeScript types