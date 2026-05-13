# Localização PT-BR

O Totum Chat deve abrir em português do Brasil para novos usuários.

Como a aplicação vem da imagem oficial usada pelo Chat Totum, os textos da interface principal não ficam versionados neste repositório. O Chat Totum já inclui o idioma `pt-BR`; este kit de deploy força o cabeçalho `Accept-Language` para `pt-BR` no Nginx, mantendo a preferência do usuário quando ele altera o idioma dentro do próprio app.

Validação recomendada depois do deploy:

```bash
curl -I -H 'Accept-Language: en-US,en;q=0.9' https://chat.grupototum.com/chat
```

Depois, abra `https://chat.grupototum.com/chat` em uma janela anônima e confira se a primeira experiência aparece em português brasileiro. Caso algum texto continue em inglês, ele provavelmente vem da tradução upstream do Chat Totum e deve ser corrigido no fork/imagem customizada ou reportado ao projeto original.
