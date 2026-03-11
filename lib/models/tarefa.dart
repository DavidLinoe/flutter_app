import 'enums.dart';

const Object _sentinel = Object();

class Tarefa {
  final String id;
  final String titulo;
  final String descricao;
  final String criadaPorId;
  final String atribuidoAId;
  final StatusTarefa status;
  final PrioridadeTarefa prioridade;
  final CategoriaTarefa categoria;
  final DateTime prazo;
  final String? fotoProva;
  final String? comentario;
  final DateTime criadoEm;
  final DateTime? concluidoEm;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.criadaPorId,
    required this.atribuidoAId,
    required this.status,
    required this.prioridade,
    required this.categoria,
    required this.prazo,
    this.fotoProva,
    this.comentario,
    required this.criadoEm,
    this.concluidoEm,
  });

  bool get estaVencida =>
      status != StatusTarefa.concluido && DateTime.now().isAfter(prazo);

  bool get prazoProximo =>
      !estaVencida &&
      status != StatusTarefa.concluido &&
      DateTime.now().difference(prazo).inDays <= -3;

  int get diasAteOPrazo =>
      prazo.difference(DateTime.now()).inDays;

  bool get isConcluida => status == StatusTarefa.concluido;

  factory Tarefa.fromJson(Map<String, dynamic> json) {
    return Tarefa(
      id: json['id'] as String,
      titulo: json['titulo'] as String,
      descricao: json['descricao'] as String,
      criadaPorId: json['criada_por_id'] as String,
      atribuidoAId: json['atribuido_a_id'] as String,
      status: StatusTarefa.fromString(json['status'] as String?) ??
          StatusTarefa.todo,
      prioridade: PrioridadeTarefa.fromString(json['prioridade'] as String?) ??
          PrioridadeTarefa.media,
      categoria: CategoriaTarefa.fromString(json['categoria'] as String?) ??
          CategoriaTarefa.outro,
      prazo: DateTime.parse(json['prazo'] as String),
      fotoProva: json['foto_prova'] as String?,
      comentario: json['comentario'] as String?,
      criadoEm: DateTime.parse(json['criado_em'] as String),
      concluidoEm: json['concluido_em'] != null
          ? DateTime.parse(json['concluido_em'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descricao': descricao,
        'criada_por_id': criadaPorId,
        'atribuido_a_id': atribuidoAId,
        'status': status.value,
        'prioridade': prioridade.value,
        'categoria': categoria.value,
        'prazo': prazo.toIso8601String(),
        'foto_prova': fotoProva,
        'comentario': comentario,
        'criado_em': criadoEm.toIso8601String(),
        'concluido_em': concluidoEm?.toIso8601String(),
      };

  Tarefa copyWith({
    String? id,
    String? titulo,
    String? descricao,
    String? criadaPorId,
    String? atribuidoAId,
    StatusTarefa? status,
    PrioridadeTarefa? prioridade,
    CategoriaTarefa? categoria,
    DateTime? prazo,
    Object? fotoProva = _sentinel,
    Object? comentario = _sentinel,
    DateTime? criadoEm,
    Object? concluidoEm = _sentinel,
  }) {
    return Tarefa(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      criadaPorId: criadaPorId ?? this.criadaPorId,
      atribuidoAId: atribuidoAId ?? this.atribuidoAId,
      status: status ?? this.status,
      prioridade: prioridade ?? this.prioridade,
      categoria: categoria ?? this.categoria,
      prazo: prazo ?? this.prazo,
      fotoProva:
          fotoProva == _sentinel ? this.fotoProva : fotoProva as String?,
      comentario:
          comentario == _sentinel ? this.comentario : comentario as String?,
      criadoEm: criadoEm ?? this.criadoEm,
      concluidoEm: concluidoEm == _sentinel
          ? this.concluidoEm
          : concluidoEm as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) => other is Tarefa && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Tarefa(id: $id, titulo: $titulo)';
}
