import 'package:flutter/foundation.dart';
import '../models/enums.dart';
import '../models/tarefa.dart';
import '../services/tarefa_service.dart';

class TarefaNotifier extends ChangeNotifier {
  TarefaNotifier(this._service) {
    carregarTarefas();
  }

  final TarefaService _service;
  List<Tarefa> _tarefas = [];
  bool _carregando = false;

  List<Tarefa> get tarefas => List.unmodifiable(_tarefas);
  bool get carregando => _carregando;

  Future<void> carregarTarefas() async {
    _carregando = true;
    notifyListeners();
    _tarefas = List.from(await _service.listarTarefas());
    _carregando = false;
    notifyListeners();
  }

  Future<void> adicionarTarefa({
    required String titulo,
    required String descricao,
    required PrioridadeTarefa prioridade,
    required CategoriaTarefa categoria,
    required DateTime prazo,
  }) async {
    final nova = await _service.criarTarefa(
      titulo: titulo,
      descricao: descricao,
      prioridade: prioridade,
      categoria: categoria,
      prazo: prazo,
    );
    _tarefas = [..._tarefas, nova];
    notifyListeners();
  }

  Future<void> atualizarTarefa(Tarefa tarefa) async {
    final atualizada = await _service.atualizarTarefa(tarefa);
    _tarefas = [
      for (final t in _tarefas)
        if (t.id == atualizada.id) atualizada else t,
    ];
    notifyListeners();
  }

  Future<void> deletarTarefa(String id) async {
    await _service.deletarTarefa(id);
    _tarefas = _tarefas.where((t) => t.id != id).toList();
    notifyListeners();
  }

  Future<void> concluirTarefa(String id) async {
    final atualizada = await _service.concluirTarefa(id);
    _tarefas = [
      for (final t in _tarefas)
        if (t.id == atualizada.id) atualizada else t,
    ];
    notifyListeners();
  }
}
