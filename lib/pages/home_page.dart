import 'package:flutter/material.dart';
import 'package:flutter_app/providers/tarefa_notifier.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefas = context.watch<TarefaNotifier>().tarefas;

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
            child: const Column(
              children: [
                Text(
                  'Status do Marido: SOB PRESSÃO',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
                ),
                SizedBox(height: 5),
                LinearProgressIndicator(value: 0.3, color: Colors.pink),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                final feito = tarefa.isConcluida;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      feito ? Icons.check_circle : Icons.pending_actions,
                      color: feito ? Colors.green : Colors.orange,
                    ),
                    title: Text(
                      tarefa.titulo,
                      style: TextStyle(
                        decoration: feito ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('Prioridade: ${tarefa.prioridade.value}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => context.go('/home/detalhes/${tarefa.id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Nova ordem'),
        icon: const Icon(Icons.add_alert),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
