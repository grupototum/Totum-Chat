/**
 * Alexandria Skill Discovery Integration
 * Princípio: "Não decidir se precisa de skill. A Alexandria define o que cobre."
 */
export async function discoverRelevantSkills(userQuery, context = 'chat') {
  if (!process.env.ALEXANDRIA_ENABLED) return null;
  try {
    const response = await fetch(`${process.env.ALEXANDRIA_API_URL}/discover`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ query: userQuery, context, types: ['skill','pop','doc'], limit: 5 })
    });
    const discovery = await response.json();
    return {
      discovered: discovery.discovered,
      recommended_action: discovery.recommended_action,
      primary_skill: discovery.primary_skill,
      should_consult_before_acting: discovery.recommended_action === 'read_skill_first'
    };
  } catch (e) { return null; }
}

export async function enhanceWithRAG(message) {
  if (!process.env.ALEXANDRIA_ENABLED) return null;
  const discovery = await discoverRelevantSkills(message, 'chat');
  if (discovery?.should_consult_before_acting) {
    return { type: 'skill_discovery', skills: discovery.discovered,
      instruction: `Consulte estas skills/POPs antes de responder: ${discovery.discovered.map(s=>s.name).join(', ')}` };
  }
  const r = await fetch(`${process.env.ALEXANDRIA_API_URL}/rag/search`, {
    method: 'POST', headers: {'Content-Type':'application/json'},
    body: JSON.stringify({ query: message })
  });
  const { results } = await r.json();
  return { type: 'rag_search', results, instruction: 'Use estes documentos como contexto' };
}
