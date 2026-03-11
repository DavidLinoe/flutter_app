# Modelos da Aplicação

Documentação dos modelos de dados da aplicação "Minha Mulher Que Manda".

## Arquivos

### `enums.dart`
Define todas as enumerações da aplicação:
- **TipoUsuario**: esposa, marido
- **StatusTarefa**: todo, em_andamento, concluido
- **PrioridadeTarefa**: baixa, media, alta
- **CategoriaTarefa**: limpeza, compras, manutencao, cozinha, quarto, sala, banheiro, outro
- **TipoNotificacao**: nova_tarefa, proximo_prazo, tarefa_atrasada, cobranca

### `usuario.dart`
Modelo de usuário do sistema.

**Campos:**
- `id`: UUID único do usuário
- `nome`: Nome completo
- `email`: Email único
- `telefone`: Telefone (opcional)
- `fotoPerfil`: URL da foto de perfil (S3) - opcional
- `tipoUsuario`: TipoUsuario (esposa/marido)
- `parceiroId`: ID do parceiro (outro usuário do casal) - opcional
- `criadoEm`: Data de criação
- `dataAtualizacao`: Data da última atualização

**Métodos:**
- `isEsposa`: Verifica se é esposa
- `isMarido`: Verifica se é marido
- `fromJson()`: Cria a partir de JSON
- `toJson()`: Converte para JSON
- `copyWith()`: Cria uma cópia com campos alterados

### `tarefa.dart`
Modelo de tarefa doméstica.

**Campos:**
- `id`: UUID único da tarefa
- `titulo`: Título da tarefa
- `descricao`: Descrição detalhada
- `criadaPorId`: ID da esposa que criou a tarefa
- `atribuidoAId`: ID do marido responsável
- `status`: StatusTarefa
- `prioridade`: PrioridadeTarefa
- `categoria`: CategoriaTarefa
- `prazo`: Data/hora do prazo
- `fotoProva`: URL da foto de prova (S3) - opcional
- `comentario`: Comentário sobre conclusão - opcional
- `criadoEm`: Data de criação
- `concluidoEm`: Data de conclusão - opcional

**Propriedades Computadas:**
- `estaVencida`: Verifica se passou do prazo
- `prazoProximo`: Verifica se o prazo está próximo (3 dias)
- `diasAteOPrazo`: Retorna dias até o prazo (negativo se atrasado)
- `isConcluida`: Verifica se está concluída

**Métodos:**
- `fromJson()`: Cria a partir de JSON
- `toJson()`: Converte para JSON
- `copyWith()`: Cria uma cópia com campos alterados

### `notificacao.dart`
Modelo de notificação do sistema.

**Campos:**
- `id`: UUID único da notificação
- `tipo`: TipoNotificacao
- `mensagem`: Mensagem a exibir
- `tarefaId`: ID da tarefa relacionada - opcional
- `usuarioId`: ID do usuário destinatário
- `lida`: Booleano indicando se foi lida
- `criadoEm`: Data de criação

**Métodos:**
- `fromJson()`: Cria a partir de JSON
- `toJson()`: Converte para JSON
- `copyWith()`: Cria uma cópia com campos alterados

### `casal.dart`
Modelo de relacionamento entre esposa e marido.

**Campos:**
- `id`: UUID único do casal
- `esposaId`: ID da esposa
- `maridoId`: ID do marido
- `criadoEm`: Data de criação
- `dataAtualizacao`: Data da última atualização

**Métodos:**
- `contemUsuario()`: Verifica se um usuário pertence ao casal
- `obterIdParceiro()`: Retorna ID do parceiro de um usuário
- `fromJson()`: Cria a partir de JSON
- `toJson()`: Converte para JSON

## Exemplo de Uso

```dart
import 'package:flutter_app/models/index.dart';

// Criar um usuário
final usuario = Usuario(
  id: '123',
  nome: 'João',
  email: 'joao@example.com',
  tipoUsuario: TipoUsuario.marido,
  parceiroId: 'esposa-123',
  criadoEm: DateTime.now(),
);

// Criar uma tarefa
final tarefa = Tarefa(
  id: 'task-1',
  titulo: 'Limpar a cozinha',
  descricao: 'Lavar pratos e limpar bancada',
  criadaPorId: 'esposa-123',
  atribuidoAId: '123',
  status: StatusTarefa.todo,
  prioridade: PrioridadeTarefa.alta,
  categoria: CategoriaTarefa.cozinha,
  prazo: DateTime.now().add(Duration(days: 1)),
  criadoEm: DateTime.now(),
);

// Criar uma notificação
final notificacao = Notificacao(
  id: 'notif-1',
  tipo: TipoNotificacao.novaTarefa,
  mensagem: 'Nova tarefa atribuída: Limpar a cozinha',
  tarefaId: 'task-1',
  usuarioId: '123',
  lida: false,
  criadoEm: DateTime.now(),
);

// Criar um casal
final casal = Casal(
  id: 'casal-1',
  esposaId: 'esposa-123',
  maridoId: '123',
  criadoEm: DateTime.now(),
);

// Usar copyWith para criar variações
final tarefaAtualizada = tarefa.copyWith(
  status: StatusTarefa.emAndamento,
);

// JSON
final json = usuario.toJson();
final usuarioDoJson = Usuario.fromJson(json);
```

## Notas

- Todos os modelos implementam `==` e `hashCode` baseados no ID
- Suportam serialização/desserialização com JSON
- Enums possuem métodos `displayName` e `emoji` para UI
- Datas são sempre UTC (ISO8601)
- URLs de fotos são hospedadas no S3
