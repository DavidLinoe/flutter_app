
## Estrutura Hierárquica da Aplicação

```
MINHA MULHER QUE MANDA
│
├── ESPOSA (Boss)
│   ├── Criar Tarefas
│   │   ├── Titulo
│   │   ├── Descricao
│   │   ├── Prazo
│   │   ├── Categoria
│   │   └── Repeticao
│   │
│   └── Gerenciar Tarefas
│       ├── Editar
│       ├── Excluir
│       ├── Prioridade
│       └── Avaliar desempenho
│
├── MARIDO (Executor)
│   ├── Ver Tarefas Pendentes
│   │   ├── Lista TODO
│   │   ├── Filtrar por status
│   │   └── Por prazo de prova
│   │
│   └── Marcar como Feito
│       ├── Status pendente
│       ├── em andamento
│       └── concluido
│       └── Foto
│
├── APP (Sistema)
│   ├── Notificacoes Push/Local
│   │   ├── Nova tarefa
│   │   ├── Prazo perto
│   │   ├── Tarefas atrasadas
│   │   └── Cobranca!
│   │
│   └── Autenticacao AWS Cognito
│       ├── Login
│       ├── Cadastro
│       ├── Sessao
│       └── Tipo usuario (esposa/marido)
│
├── Dashboard da Esposa
│   ├── % Concluidas
│   ├── Atrasadas
│   ├── Historico
│   └── Relatorio semanal
│
└── Gamificacao (Opcional)
    ├── Pontos
    ├── Ranking
    ├── Recompensas
    └── Sequencia de dias
```

## Estrutura de Features

| Feature | Descricao |
|---------|-----------|
| autenticacao | Login, cadastro e tipo de perfil (esposa/marido) |
| tarefas | Criacao, edicao, exclusao e listagem de tarefas |
| todo_list | Visualizacao e execucao das tarefas pelo marido |
| notificacoes | Alertas de nova tarefa, prazo e cobracas |
| dashboard | Painel de controle da esposa com estatisticas |
| perfil | Gerenciamento de conta e vinculacao do casal |
