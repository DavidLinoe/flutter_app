import 'package:flutter/material.dart';
import 'package:flutter_app/models/tarefa.dart';
import 'package:flutter_app/providers/tarefa_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetalhesPage extends StatelessWidget {
  final String id;

  const DetalhesPage({super.key, required this.id});

  String _formatarData(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/'
      '${dt.month.toString().padLeft(2, '0')}/'
      '${dt.year}';

  Future<void> _confirmarDelecao(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Apagar missão?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Apagar'),
          ),
        ],
      ),
    );
    if (confirmar == true && context.mounted) {
      await context.read<TarefaNotifier>().deletarTarefa(id);
      if (context.mounted) context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tarefa = context.select<TarefaNotifier, Tarefa?>(
      (n) => n.tarefas.where((t) => t.id == id).firstOrNull,
    );

    if (tarefa == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Missão'),
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: Text('Missão não encontrada')),
      );
    }

    final feito = tarefa.isConcluida;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Missão'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        actions: [
          if (!feito)
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar',
              onPressed: () => context.go('/home/detalhes/$id/editar'),
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Apagar',
            onPressed: () => _confirmarDelecao(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.assignment, size: 40, color: Colors.pinkAccent),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    tarefa.titulo,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 40),
            const Text(
              'Instruções da Patroa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              tarefa.descricao.isNotEmpty
                  ? tarefa.descricao
                  : 'Faça bem feito e sem reclamar!',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Icon(Icons.priority_high, color: Colors.grey),
                const SizedBox(width: 10),
                const Text('Prioridade: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(tarefa.prioridade.value),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.category, color: Colors.grey),
                const SizedBox(width: 10),
                const Text('Categoria: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(tarefa.categoria.value),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: tarefa.estaVencida ? Colors.red : Colors.grey,
                ),
                const SizedBox(width: 10),
                const Text('Prazo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  _formatarData(tarefa.prazo),
                  style: TextStyle(
                    color: tarefa.estaVencida ? Colors.red : null,
                    fontWeight: tarefa.estaVencida ? FontWeight.bold : null,
                  ),
                ),
                if (tarefa.estaVencida) ...[
                  const SizedBox(width: 8),
                  const Text(
                    '(VENCIDA)',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: feito
                    ? null
                    : () async {
                        await context.read<TarefaNotifier>().concluirTarefa(id);
                        if (context.mounted) context.go('/home');
                      },
                icon: const Icon(Icons.done_all),
                label: Text(feito ? 'JÁ CUMPRIDA' : 'MISSÃO CUMPRIDA'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: feito ? Colors.grey : Colors.green,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
