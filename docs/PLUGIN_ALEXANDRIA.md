# Alexandria Plugin

The Alexandria plugin manifest is served by the Supabase Edge Function:

`https://cgpkfhrqprqptvehatad.supabase.co/functions/v1/alexandria-proxy`

Current public tools:

- `searchAlexandria`
- `getPop`
- `getClientBrief`

The internal `/capture` route is intentionally not listed in the public LobeHub manifest because it requires an internal bearer token and is reserved for n8n/server-side workflows.

## Register After Deploy

1. Open `https://chat.grupototum.com/chat`.
2. Go to plugin/tool settings.
3. Add custom plugin by manifest URL:
   `https://cgpkfhrqprqptvehatad.supabase.co/functions/v1/alexandria-proxy`
4. Test with: "Qual é o POP de onboarding da Totum?"
5. Confirm the plugin returns Alexandria results rather than generic model text.
