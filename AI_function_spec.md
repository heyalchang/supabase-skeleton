AI Writing Assistant - Function Specification

  Overview

  The AI Writing Assistant provides three core AI-powered text manipulation
   functions: Write, Rewrite, and Describe. Each function interacts with
  OpenAI's API through Supabase Edge Functions.

  1. Write Function

  Purpose: Inserts AI-generated content at the cursor position within
  existing text.

  UI Behavior:
  - User places cursor anywhere in the text area
  - User enters a prompt describing what to write
  - AI inserts exactly 3 sentences at cursor position
  - New content seamlessly blends with surrounding text

  Implementation Details:
  - Frontend:
    - Tracks cursor position using selectionStart on textarea
    - Inserts [CURSOR] token at cursor position before sending to backend
    - Streams response character-by-character in real-time
    - Updates textarea continuously during streaming
    - Adds double newline after inserted content
  - Backend:
    - Uses OpenAI streaming API (stream: true)
    - Model: gpt-4o-mini, Temperature: 0.7, Max tokens: 1024
    - Returns Server-Sent Events (SSE) stream
  - API Call: Direct fetch to edge function URL with streaming response
  handling

  2. Rewrite Function

  Purpose: Generates 3 alternative versions of selected text.

  UI Behavior:
  - User selects text in textarea (button disabled without selection)
  - User enters rewrite instructions in prompt
  - System displays 3 options in a clickable list
  - Clicking an option replaces selected text

  Implementation Details:
  - Frontend:
    - Tracks selection range (selectionStart and selectionEnd)
    - Uses Supabase client's invoke method (not direct fetch)
    - Displays options in an overlay that appears below the button
    - Replaces selected text when option clicked
  - Backend:
    - Non-streaming response (stream: false)
    - Model: gpt-4o-mini, Temperature: 0.8 (higher for variety), Max
  tokens: 2048
    - Uses OpenAI's JSON mode for structured output
    - Returns: { "options": ["version1", "version2", "version3"] }

  3. Describe Function

  Purpose: Generates AI analysis or description of the entire text.

  UI Behavior:
  - Analyzes all text in textarea (button disabled if empty)
  - User provides analysis prompt
  - AI response streams in real-time below the button
  - Response appears in a dedicated output area

  Implementation Details:
  - Frontend:
    - Sends entire text content with prompt
    - Streams response character-by-character
    - Displays in a separate response container
  - Backend:
    - Uses OpenAI streaming API
    - Model: gpt-4o-mini, Temperature: 0.7, Max tokens: 1024
    - Most flexible - simply concatenates prompt and text
  - API Call: Direct fetch with streaming response handling

  Streaming Implementation Pattern

  For Write and Describe functions:

  // 1. Make fetch request to edge function
  const response = await fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ text, prompt })
  });

  // 2. Get reader from response body
  const reader = response.body.getReader();
  const decoder = new TextDecoder();

  // 3. Read chunks and parse SSE format
  while (true) {
    const { done, value } = await reader.read();
    if (done) break;

    const chunk = decoder.decode(value);
    const lines = chunk.split('\n');

    for (const line of lines) {
      if (line.startsWith('data: ')) {
        const data = line.substring(6);
        if (data.trim() === '[DONE]') break;

        const parsed = JSON.parse(data);
        if (parsed.choices?.[0]?.delta?.content) {
          // Append content and update UI
          streamedText += parsed.choices[0].delta.content;
          updateUI(streamedText);
        }
      }
    }
  }

  Key Technical Details

  1. State Management: Each function clears other functions' outputs when
  invoked
  2. Loading States: UI shows "Writing...", "Rewriting...", or
  "Describing..." during operation
  3. Error Handling: Comprehensive error catching with user-friendly
  messages
  4. Authentication: All functions require JWT token in Authorization
  header
  5. CORS: Edge functions include proper CORS headers for browser requests
  6. Cursor Tracking: Continuous tracking of cursor/selection on click,
  keyup, and select events
