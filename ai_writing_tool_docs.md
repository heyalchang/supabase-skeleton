# 🧭 Product Requirements Document (PRD)

## **Feature Name**

AI-Powered Writing Assistant

## **Overview**

A React-based writing tool integrating OpenAI via Supabase Edge Functions for generating new text, rewriting existing text, and describing input content. This tool enhances productivity in writing by offering intelligent AI suggestions.

## **Problem Statement**

Writers face challenges such as writer’s block, redundant phrasing, and difficulty summarizing. This tool provides on-demand AI assistance to improve speed and quality.

## **Goals**

- Simple UI for text input and prompt definition.
- React frontend with prompt-specific buttons.
- Supabase Edge Functions to call OpenAI (GPT-4.1 mini).
- Output AI responses in the interface.

## **Key Features**

- Input text area (user content).
- Three configurable prompt fields (for write, rewrite, describe).
- Three corresponding action buttons.
- Display response results under each function.
- Integrated test setup and logging for local development.

## **User Stories**

- User can generate fresh content from scratch.
- User can rewrite submitted content.
- User can request a description or summary.

---

# ⚙️ Technical Design Document (TDD)

## **Frontend (React)**

### Components:

- `<TextInput />` — Original input content
- `<PromptEditor />` (x3) — Custom prompts for Write, Rewrite, Describe
- `<Button />` (x3) — Submit buttons
- `<OutputBox />` — AI-generated response display

### API Workflow:

- User enters content and optional prompt.
- Button click triggers `POST` request to respective edge function.
- OpenAI response is returned and rendered.

### Endpoints:

- `POST /functions/v1/write`
- `POST /functions/v1/rewrite`
- `POST /functions/v1/describe`

### Payload:

```json
{
  "text": "User's original input",
  "prompt": "Prompt text for specific function"
}
```

### State Handling:

- State for `text`, `prompts`, and `responses`
- Modular per-function state management

---

## **Backend (Supabase Edge Functions)**

Each function:

1. Accepts `text` and `prompt` in body.
2. Calls OpenAI API (`/v1/chat/completions`) with GPT-4.1 mini.
3. Returns output content.

### Example Function (TypeScript):

```ts
export const handle = async (req: Request) => {
  const { text, prompt } = await req.json();
  const fullPrompt = `${prompt}\n\n${text}`;

  const response = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${process.env.OPENAI_KEY}`,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: "gpt-4.1-mini",
      messages: [{ role: "user", content: fullPrompt }]
    })
  });

  const data = await response.json();
  return new Response(JSON.stringify({ output: data.choices[0].message.content }));
};
```

### Considerations:

- Secure API keys in Supabase environment
- Add CORS support for dev/test
- Use rate limiting/auth middleware if exposing functions externally

