import 'package:flutter/material.dart';
import 'package:flutter_app/detalhesPage.dart' show DetalhesPage;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> tarefas = [
      {"titulo": "Lavar a louça", "status": "Pendente", "prioridade": "Alta"},
      {"titulo": "Comprar pão", "status": "Pendente", "prioridade": "Média"},
      {"titulo": "Levar o lixo fora", "status": "Feito", "prioridade": "Baixa"},
      {"titulo": "Arrumar a cama", "status": "Pendente", "prioridade": "Urgente"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas missões'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          )
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
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      tarefa['status'] == 'Feito'
                          ? Icons.check_circle
                          : Icons.pending_actions,
                      color: tarefa['status'] == 'Feito' ? Colors.green : Colors.orange,
                    ),
                    title: Text(
                      tarefa['titulo']!,
                      style: TextStyle(
                        decoration: tarefa['status'] == 'Feito'
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text('Prioridade: ${tarefa['prioridade']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesPage(
                            titulo: tarefa['titulo']!,
                            prioridade: tarefa['prioridade']!,
                          ),
                        ),
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
