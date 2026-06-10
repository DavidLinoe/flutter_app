import 'package:flutter/material.dart';
import 'package:flutter_app/models/enums.dart';
import 'package:flutter_app/models/tarefa.dart';
import 'package:flutter_app/providers/tarefa_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TarefaFormPage extends StatefulWidget {
  final String? id;

  const TarefaFormPage({super.key, this.id});

  @override
  State<TarefaFormPage> createState() => _TarefaFormPageState();
}

class _TarefaFormPageState extends State<TarefaFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();

  PrioridadeTarefa _prioridade = PrioridadeTarefa.media;
  CategoriaTarefa _categoria = CategoriaTarefa.outro;
  DateTime _prazo = DateTime.now().add(const Duration(days: 1));
  bool _salvando = false;

  bool get _modoEdicao => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (_modoEdicao) {
      final tarefa = context
          .read<TarefaNotifier>()
          .tarefas
          .where((t) => t.id == widget.id)
          .firstOrNull;
      if (tarefa != null) _preencherFormulario(tarefa);
    }
  }

  void _preencherFormulario(Tarefa tarefa) {
    _tituloCtrl.text = tarefa.titulo;
    _descricaoCtrl.text = tarefa.descricao;
    _prioridade = tarefa.prioridade;
    _categoria = tarefa.categoria;
    _prazo = tarefa.prazo;
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _descricaoCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);

    final notifier = context.read<TarefaNotifier>();

    if (_modoEdicao) {
      final tarefa = notifier.tarefas
          .where((t) => t.id == widget.id)
          .firstOrNull;
      if (tarefa != null) {
        await notifier.atualizarTarefa(tarefa.copyWith(
          titulo: _tituloCtrl.text.trim(),
          descricao: _descricaoCtrl.text.trim(),
          prioridade: _prioridade,
          categoria: _categoria,
          prazo: _prazo,
        ));
      }
    } else {
      await notifier.adicionarTarefa(
        titulo: _tituloCtrl.text.trim(),
        descricao: _descricaoCtrl.text.trim(),
        prioridade: _prioridade,
        categoria: _categoria,
        prazo: _prazo,
      );
    }

    if (!mounted) return;
    setState(() => _salvando = false);
    context.pop();
  }

  Future<void> _selecionarPrazo() async {
    final selecionado = await showDatePicker(
      context: context,
      initialDate: _prazo.isBefore(DateTime.now()) ? DateTime.now() : _prazo,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selecionado != null) setState(() => _prazo = selecionado);
  }

  String _formatarData(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/'
      '${dt.month.toString().padLeft(2, '0')}/'
      '${dt.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_modoEdicao ? 'Editar Ordem' : 'Nova Ordem'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(
                  labelText: 'Título da missão',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.task_alt, color: Colors.pinkAccent),
                ),
                validator: (v) {
                  if ((v ?? '').trim().isEmpty) return 'Informe o título';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Instruções (opcional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description, color: Colors.pinkAccent),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PrioridadeTarefa>(
                initialValue: _prioridade,
                decoration: const InputDecoration(
                  labelText: 'Prioridade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.priority_high, color: Colors.pinkAccent),
                ),
                items: PrioridadeTarefa.values
                    .map((p) => DropdownMenuItem(value: p, child: Text(p.value)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _prioridade = v);
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<CategoriaTarefa>(
                initialValue: _categoria,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category, color: Colors.pinkAccent),
                ),
                items: CategoriaTarefa.values
                    .map((c) => DropdownMenuItem(value: c, child: Text(c.value)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setState(() => _categoria = v);
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _selecionarPrazo,
                borderRadius: BorderRadius.circular(4),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Prazo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.pinkAccent),
                  ),
                  child: Text(_formatarData(_prazo)),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _salvando ? null : _salvar,
                  icon: _salvando
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(_modoEdicao ? 'SALVAR ALTERAÇÕES' : 'CRIAR MISSÃO'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
