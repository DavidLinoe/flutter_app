import 'package:flutter/foundation.dart';
import '../models/tarefa.dart';
import '../models/enums.dart';

class TarefaNotifier extends ChangeNotifier {
  final List<Tarefa> _tarefas = [
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

  List<Tarefa> get tarefas => List.unmodifiable(_tarefas);

  void concluirTarefa(String id) {
    final index = _tarefas.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _tarefas[index] = _tarefas[index].copyWith(
      status: StatusTarefa.concluido,
      concluidoEm: DateTime.now(),
    );
    notifyListeners();
  }
}
