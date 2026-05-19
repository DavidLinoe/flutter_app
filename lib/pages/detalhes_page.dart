import 'package:flutter/material.dart';
import 'package:flutter_app/models/tarefa.dart';
import 'package:flutter_app/providers/tarefa_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetalhesPage extends StatelessWidget {
  final String id;

  const DetalhesPage({super.key, required this.id});

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
            const Text(
              'Faça bem feito, não deixe para depois e use os produtos certos. Se tiver dúvida, não me pergunte, resolva!',
              style: TextStyle(fontSize: 16, color: Colors.black87),
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
            const Row(
              children: [
                Icon(Icons.timer, color: Colors.grey),
                SizedBox(width: 10),
                Text('Prazo: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Até a janta'),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: feito
                    ? null
                    : () {
                        context.read<TarefaNotifier>().concluirTarefa(id);
                        context.go('/home');
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
