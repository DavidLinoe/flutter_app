import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<Map<String, String>> _tarefas = [
    {"id": "1", "titulo": "Lavar a louça", "status": "Pendente", "prioridade": "Alta"},
    {"id": "2", "titulo": "Comprar pão", "status": "Pendente", "prioridade": "Média"},
    {"id": "3", "titulo": "Levar o lixo fora", "status": "Feito", "prioridade": "Baixa"},
    {"id": "4", "titulo": "Arrumar a cama", "status": "Pendente", "prioridade": "Urgente"},
  ];

  @override
  Widget build(BuildContext context) {
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
              AuthService.instance.logout();
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
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = _tarefas[index];
                final feito = tarefa['status'] == 'Feito';
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      feito ? Icons.check_circle : Icons.pending_actions,
                      color: feito ? Colors.green : Colors.orange,
                    ),
                    title: Text(
                      tarefa['titulo']!,
                      style: TextStyle(
                        decoration: feito ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: Text('Prioridade: ${tarefa['prioridade']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.go(
                        '/home/detalhes/${tarefa['id']}',
                        extra: tarefa,
                      );
                    },
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
