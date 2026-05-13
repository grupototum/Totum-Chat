# Plugin Alexandria

O manifesto do plugin Alexandria é servido pela Supabase Edge Function:

`https://cgpkfhrqprqptvehatad.supabase.co/functions/v1/alexandria-proxy`

Ferramentas públicas atuais:

- `searchAlexandria`
- `getPop`
- `getClientBrief`

A rota interna `/capture` intencionalmente não aparece no manifesto público do Chat Totum porque exige um bearer token interno e fica reservada para fluxos n8n/server-side.

## Cadastro Depois do Deploy

1. Abra `https://chat.grupototum.com/chat`.
2. Entre nas configurações de plugins/ferramentas.
3. Adicione um plugin customizado pela URL do manifesto:
   `https://cgpkfhrqprqptvehatad.supabase.co/functions/v1/alexandria-proxy`
4. Teste com: "Qual é o POP de onboarding da Totum?"
5. Confirme se o plugin retorna resultados da Alexandria em vez de uma resposta genérica do modelo.
