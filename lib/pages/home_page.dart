import 'package:flutter/material.dart';
import 'package:flutter_app/providers/tarefa_notifier.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String _statusText(double progresso) {
    if (progresso >= 1.0) return 'Status do Marido: HERÓI DA SEMANA!';
    if (progresso >= 0.7) return 'Status do Marido: QUASE LÁ!';
    if (progresso >= 0.4) return 'Status do Marido: AINDA DÁ TEMPO';
    return 'Status do Marido: SOB PRESSÃO';
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<TarefaNotifier>();
    final tarefas = notifier.tarefas;
    final carregando = notifier.carregando;

    final total = tarefas.length;
    final concluidas = tarefas.where((t) => t.isConcluida).length;
    final progresso = total > 0 ? concluidas / total : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas missões'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              context.read<AuthService>().logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.pink[50],
            child: Column(
              children: [
                Text(
                  _statusText(progresso),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(value: progresso, color: Colors.pink),
                const SizedBox(height: 4),
                Text(
                  '$concluidas de $total missões concluídas',
                  style: const TextStyle(fontSize: 12, color: Colors.pink),
                ),
              ],
            ),
          ),
          Expanded(
            child: carregando
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.pinkAccent),
                  )
                : tarefas.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhuma missão por enquanto!\nA patroa vai inventar algo em breve...',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tarefas.length,
                        itemBuilder: (context, index) {
                          final tarefa = tarefas[index];
                          final feito = tarefa.isConcluida;
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: ListTile(
                              leading: Icon(
                                feito ? Icons.check_circle : Icons.pending_actions,
                                color: feito ? Colors.green : Colors.orange,
                              ),
                              title: Text(
                                tarefa.titulo,
                                style: TextStyle(
                                  decoration:
                                      feito ? TextDecoration.lineThrough : null,
                                ),
                              ),
                              subtitle: Text(
                                'Prioridade: ${tarefa.prioridade.value}  •  ${tarefa.categoria.value}',
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  size: 16),
                              onTap: () =>
                                  context.go('/home/detalhes/${tarefa.id}'),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/home/nova-tarefa'),
        label: const Text('Nova ordem'),
        icon: const Icon(Icons.add_alert),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
