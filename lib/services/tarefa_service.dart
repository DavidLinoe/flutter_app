import '../models/enums.dart';
import '../models/tarefa.dart';

class TarefaService {
  final List<Tarefa> _db = [
    Tarefa(
      id: '1',
      titulo: 'Lavar a louça',
      descricao: 'Lavar toda a louça acumulada na pia',
      criadaPorId: 'esposa',
      atribuidoAId: 'marido',
      status: StatusTarefa.todo,
      prioridade: PrioridadeTarefa.alta,
      categoria: CategoriaTarefa.cozinha,
      prazo: DateTime.now().add(const Duration(hours: 3)),
      criadoEm: DateTime.now(),
    ),
    Tarefa(
      id: '2',
      titulo: 'Comprar pão',
      descricao: 'Comprar pão na padaria do bairro',
      criadaPorId: 'esposa',
      atribuidoAId: 'marido',
      status: StatusTarefa.todo,
      prioridade: PrioridadeTarefa.media,
      categoria: CategoriaTarefa.compras,
      prazo: DateTime.now().add(const Duration(hours: 1)),
      criadoEm: DateTime.now(),
    ),
    Tarefa(
      id: '3',
      titulo: 'Levar o lixo fora',
      descricao: 'Levar o lixo para a rua antes da coleta',
      criadaPorId: 'esposa',
      atribuidoAId: 'marido',
      status: StatusTarefa.concluido,
      prioridade: PrioridadeTarefa.baixa,
      categoria: CategoriaTarefa.outro,
      prazo: DateTime.now().add(const Duration(hours: 5)),
      criadoEm: DateTime.now(),
      concluidoEm: DateTime.now(),
    ),
    Tarefa(
      id: '4',
      titulo: 'Arrumar a cama',
      descricao: 'Arrumar a cama do casal com cuidado',
      criadaPorId: 'esposa',
      atribuidoAId: 'marido',
      status: StatusTarefa.todo,
      prioridade: PrioridadeTarefa.alta,
      categoria: CategoriaTarefa.quarto,
      prazo: DateTime.now().add(const Duration(hours: 2)),
      criadoEm: DateTime.now(),
    ),
  ];

  int _proximoId = 5;

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_db);
  }

  Future<Tarefa?> buscarTarefa(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _db.where((t) => t.id == id).firstOrNull;
  }

  Future<Tarefa> criarTarefa({
    required String titulo,
    required String descricao,
    required PrioridadeTarefa prioridade,
    required CategoriaTarefa categoria,
    required DateTime prazo,
    String criadaPorId = 'esposa',
    String atribuidoAId = 'marido',
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final nova = Tarefa(
      id: '${_proximoId++}',
      titulo: titulo,
      descricao: descricao,
      criadaPorId: criadaPorId,
      atribuidoAId: atribuidoAId,
      status: StatusTarefa.todo,
      prioridade: prioridade,
      categoria: categoria,
      prazo: prazo,
      criadoEm: DateTime.now(),
    );
    _db.add(nova);
    return nova;
  }

  Future<Tarefa> atualizarTarefa(Tarefa tarefa) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _db.indexWhere((t) => t.id == tarefa.id);
    if (index == -1) throw Exception('Tarefa não encontrada: ${tarefa.id}');
    _db[index] = tarefa;
    return tarefa;
  }

  Future<void> deletarTarefa(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _db.removeWhere((t) => t.id == id);
  }

  Future<Tarefa> concluirTarefa(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _db.indexWhere((t) => t.id == id);
    if (index == -1) throw Exception('Tarefa não encontrada: $id');
    final atualizada = _db[index].copyWith(
      status: StatusTarefa.concluido,
      concluidoEm: DateTime.now(),
    );
    _db[index] = atualizada;
    return atualizada;
  }
}
