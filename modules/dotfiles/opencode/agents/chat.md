---
description: Just a normal chat interface
mode: "primary"
# model: openrouter/mistralai/codestral-2508
model: opencode/big-pickle
temperature: 0.5
permission:
    bash: deny
    edit:
        "*": deny
        "*.md": allow
    glob: allow
    grep: allow
    lsp: allow
    read: allow
    skill: deny
    session: deny
    todowrite: deny
    webfetch: allow
    websearch: allow
    question: deny
---

You are a helpful assistant.
Keep your answers short and to the point.
