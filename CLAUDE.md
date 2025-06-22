# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Frontend Development
- `npm run dev` - Start Vite development server (runs on http://localhost:5173)
- `npm run build` - Build production bundle
- `npm run preview` - Preview production build locally

### Supabase Edge Functions
- `supabase functions deploy openai-chat` - Deploy the OpenAI chat edge function
- `supabase secrets set OPENAI_API_KEY=your_key` - Set OpenAI API key as environment secret
- `supabase link --project-ref YOUR_PROJECT_REF` - Link local project to Supabase

## Architecture Overview

This is a React + Supabase + OpenAI integration demo with the following architecture:

### Frontend (React + Vite)
- **App.jsx**: Main application component handling authentication flow and edge function testing
- **supabaseClient.js**: Supabase client configuration with project credentials
- Uses Supabase Auth for email/password authentication
- Calls Supabase edge functions with JWT token authorization

### Backend (Supabase Edge Function)
- **supabase/functions/openai-chat/index.ts**: Deno edge function that:
  - Validates JWT authorization headers
  - Accepts message input from authenticated users  
  - Makes requests to OpenAI Chat Completions API (gpt-3.5-turbo)
  - Returns AI responses with usage metrics
  - Handles CORS for browser requests

### Key Integration Points
1. **Authentication Flow**: Email/password → Supabase Auth → JWT token
2. **Secure Function Calls**: JWT token passed in Authorization header to edge function
3. **OpenAI Integration**: Edge function uses OPENAI_API_KEY environment variable
4. **Error Handling**: Comprehensive error handling across auth, function calls, and API requests

### Configuration Requirements
- Environment variables for Supabase credentials (see `.env.example`)
- OpenAI API key set as Supabase secret: `OPENAI_API_KEY`
- Supabase Auth configured with email confirmations and redirect URLs
- CORS headers properly configured in edge function

### Environment Variables
Copy `.env.example` to `.env.local` and fill in your Supabase credentials:
```
VITE_SUPABASE_URL=https://your-project-ref.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

For Vercel deployment, add these as environment variables in your Vercel project settings.

### Development Workflow
1. Set up Supabase project and get credentials
2. Copy `.env.example` to `.env.local` and configure with your Supabase credentials
3. Deploy edge function with `supabase functions deploy openai-chat`
4. Set OpenAI API key as secret
5. Run `npm run dev` for local development
6. Test authentication and AI function integration

## Important Notes

- Environment variables are required for both local development and deployment
- Edge function requires valid JWT token - test authentication flow before testing AI integration
- OpenAI responses are limited to 150 tokens as configured in the edge function
- All edge function calls include CORS headers for browser compatibility