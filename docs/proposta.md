
# Proposta do Projeto Integrador — Grupo B

## Nome do Aplicativo

**Minha Mulher Que Manda** — Gerenciador de Tarefas para Casais

## Problema que Resolve

Casais enfrentam dificuldades para organizar e acompanhar tarefas domésticas. 
Maridos muitas vezes esquecem tarefas ou não sabem quando devem ser executadas. 
Mulheres precisam cobrar constantemente sem ter controle visual do progresso. 

O app resolve isso criando um sistema centralizado de tarefas com notificações, 
prioridades, prazos e gamificação, além de um painel de controle para a esposa 
acompanhar o desempenho do marido.

## Público-Alvo

- **Casais** (esposa e marido)
- **Mulheres** que desejam organizar tarefas domésticas com eficácia
- **Homens** que querem melhorar sua produtividade nas tarefas

## Funcionalidades Principais

### Para a Esposa (Boss)
1. **Criar Tarefas** - Adicionar novas tarefas com:
   - Título
   - Descrição
   - Prazo
   - Categoria
   - Repetição (opcional)

2. **Gerenciar Tarefas** - Controlar tarefas existentes:
   - Editar tarefas
   - Excluir tarefas
   - Alterar prioridade
   - Avaliar desempenho

3. **Dashboard** - Acompanhar progresso com:
   - Percentual de conclusão
   - Tarefas atrasadas
   - Histórico de tarefas
   - Relatório semanal de desempenho

### Para o Marido (Executor)
1. **Ver Tarefas Pendentes** - Visualizar todas as tarefas:
   - Lista TODO
   - Filtrar por status
   - Ordenar por prazo
   
2. **Executar Tarefas** - Marcar tarefas como concluídas:
   - Status: Pendente → Em Andamento → Concluído
   - Enviar foto como prova de conclusão
   - Adicionar comentários opcionais

### Sistema (APP)
1. **Notificações** - Alertas em tempo real:
   - Nova tarefa atribuída
   - Prazo próximo
   - Tarefas atrasadas
   - Cobranças da esposa

2. **Autenticação** - Gerenciamento de contas:
   - Login com AWS Cognito
   - Cadastro com tipo de usuário (esposa/marido)
   - Gerenciamento de sessão
   - Recuperação de senha

3. **Gamificação** (Opcional):
   - Sistema de pontos por tarefas concluídas
   - Ranking semanal/mensal
   - Recompensas e desafios
   - Sequência de dias sem falhas

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
│       ├── concluido
│       └── Foto de prova
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

| Feature | Descrição |
|---------|-----------|
| **autenticacao** | Login, cadastro e tipo de perfil (esposa/marido) |
| **tarefas** | Criação, edição, exclusão e listagem de tarefas |
| **todo_list** | Visualização e execução das tarefas pelo marido |
| **notificacoes** | Alertas de nova tarefa, prazo e cobranças |
| **dashboard** | Painel de controle da esposa com estatísticas |
| **perfil** | Gerenciamento de conta e vinculação do casal |
| **gamificacao** | Sistema de pontos, ranking, recompensas e sequência de dias |

## Estrutura de Dados

### Usuario
```
- id (UUID)
- nome
- email
- tipoUsuario (esposa/marido)
- parceiroId (referência para o outro usuário do casal)
- fotoPerfil (URL S3)
- criadoEm (timestamp)
```

### Tarefa
```
- id (UUID)
- titulo
- descricao
- criadaPorId (FK Usuario - esposa)
- atribuidoAId (FK Usuario - marido)
- status (TODO, em_andamento, concluido)
- prioridade (baixa, media, alta)
- categoria (limpeza, compras, manutencao, etc)
- prazo (data limite)
- fotoProva (URL S3 - foto de conclusão)
- criadoEm (timestamp)
- concluidoEm (timestamp)
```

### Notificacao
```
- id (UUID)
- tipo (nova_tarefa, prazo_proximo, tarefa_atrasada, cobranca)
- mensagem
- tarefaId (FK Tarefa)
- usuarioId (FK Usuario - destinatário)
- lida (boolean)
- criadoEm (timestamp)
```

### Casal
```
- id (UUID)
- esposaId (FK Usuario)
- maridoId (FK Usuario)
- criadoEm (timestamp)
```

## Diagrama Entidade-Relacionamento

```
┌─────────────────┐
│     Usuario     │
├─────────────────┤
│ id (PK)         │
│ nome            │
│ email           │
│ tipoUsuario     │
│ parceiroId (FK) │──┐
│ fotoPerfil      │  │
│ criadoEm        │  │
└─────────────────┘  │
        1:N          │
        │            │
        │      ┌─────────────────┐
        │      │     Tarefa      │
        │      ├─────────────────┤
        ├─────→│ id (PK)         │
        │      │ titulo          │
        │      │ descricao       │
        │      │ criadaPorId (FK)│
        │      │ atribuidoAId(FK)│
        │      │ status          │
        │      │ prioridade      │
        │      │ categoria       │
        │      │ prazo           │
        │      │ fotoProva       │
        │      │ criadoEm        │
        │      │ concluidoEm     │
        │      └─────────────────┘
        │              1:N
        │              │
        │      ┌───────────────────────┐
        │      │   Notificacao         │
        └─────→├───────────────────────┤
               │ id (PK)               │
               │ tipo                  │
               │ mensagem              │
               │ tarefaId (FK)         │
               │ usuarioId (FK)        │
               │ lida                  │
               │ criadoEm              │
               └───────────────────────┘

        ┌─────────────────┐
        │      Casal      │
        ├─────────────────┤
        │ id (PK)         │
        │ esposaId (FK)───┼──→ Usuario
        │ maridoId (FK)───┼──→ Usuario
        │ criadoEm        │
        └─────────────────┘
```

## Recursos Técnicos

- **Frontend**: Flutter (Dart)
- **Autenticação**: AWS Cognito
- **Backend**: AWS Lambda + API Gateway
- **Banco de Dados**: DynamoDB
- **Storage**: S3 (para fotos de prova)
- **Notificações**: Firebase Cloud Messaging ou AWS SNS
- **Arquitetura**: Clean Architecture (Domain, Data, Presentation)

## Equipe do Projeto (Grupo B)

- **Desenvolvimento**: David Lino
- **Período**: Semestre 2025

## Cronograma Estimado

| Fase | Duração | Tarefas |
|------|---------|---------|
| **Estrutura Base** | 1-2 semanas | Setup do projeto, configuração de dependências, estrutura de pastas |
| **Autenticação** | 2-3 semanas | Login, cadastro, AWS Cognito, vinculação de casal |
| **Gerenciamento de Tarefas** | 2-3 semanas | CRUD de tarefas, filtros, prioridades |
| **Execução de Tarefas** | 2-3 semanas | Marcar concluído, foto de prova, comentários |
| **Dashboard e Notificações** | 2-3 semanas | Painel da esposa, estatísticas, alertas |
| **Gamificação** | 1-2 semanas | Pontos, ranking, recompensas |
| **Testes e Refinamento** | 2-3 semanas | Testes, correções, otimizações |

## Próximos Passos

1. ✅ Definir a proposta e arquitetura
2. 🔄 Configurar ambiente de desenvolvimento
3. 🔄 Criar estrutura de pastas e arquivos base
4. 🔄 Integrar AWS Cognito
5. ⏳ Implementar features de autenticação
6. ⏳ Implementar gerenciamento de tarefas
7. ⏳ Implementar dashboard
8. ⏳ Implementar gamificação

## Referências e Recursos

- [Flutter Documentation](https://docs.flutter.dev/)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)
- [AWS Cognito](https://aws.amazon.com/cognito/)
- [AWS DynamoDB](https://aws.amazon.com/dynamodb/)
- [Dart Language](https://dart.dev/)
