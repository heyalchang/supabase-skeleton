import { OpenAI } from 'https://deno.land/x/openai@v4.52.7/mod.ts'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

const openai = new OpenAI({
  apiKey: Deno.env.get('OPENAI_API_KEY'),
})

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { text } = await req.json()

    if (!text) {
      return new Response(JSON.stringify({ error: 'Text is required' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    const completion = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        {
          role: 'system',
          content: `You are a spellcheck and grammar correction assistant. The user will provide text. The text is broken into paragraphs by double line breaks ('\\n\\n'). Analyze each paragraph separately. Respond with a JSON array of objects. Each object must have two keys: 'original' for the original paragraph and 'corrected' for the corrected version. Only include paragraphs that contain corrections. If a paragraph has no errors, do not include it in the response. Your response must be only the raw JSON array, without any markdown formatting, commentary, or other text.`,
        },
        {
          role: 'user',
          content: text,
        },
      ],
      temperature: 0.2,
    })

    const corrections = completion.choices[0].message.content

    return new Response(corrections, {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  } catch (err) {
    console.error(err)
    return new Response(String(err?.message ?? err), {
      status: 500,
      headers: corsHeaders,
    })
  }
}) 