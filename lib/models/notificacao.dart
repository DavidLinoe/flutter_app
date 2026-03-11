import 'enums.dart';

const Object _sentinel = Object();

class Notificacao {
  final String id;
  final TipoNotificacao tipo;
  final String mensagem;
  final String? tarefaId;
  final String usuarioId;
  final bool lida;
  final DateTime criadoEm;

  Notificacao({
    required this.id,
    required this.tipo,
    required this.mensagem,
    this.tarefaId,
    required this.usuarioId,
    required this.lida,
    required this.criadoEm,
  });

  factory Notificacao.fromJson(Map<String, dynamic> json) {
    return Notificacao(
      id: json['id'] as String,
      tipo: TipoNotificacao.fromString(json['tipo'] as String?) ??
          TipoNotificacao.novaTarefa,
      mensagem: json['mensagem'] as String,
      tarefaId: json['tarefa_id'] as String?,
      usuarioId: json['usuario_id'] as String,
      lida: json['lida'] as bool? ?? false,
      criadoEm: DateTime.parse(json['criado_em'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo.value,
        'mensagem': mensagem,
        'tarefa_id': tarefaId,
        'usuario_id': usuarioId,
        'lida': lida,
        'criado_em': criadoEm.toIso8601String(),
      };

  Notificacao copyWith({
    String? id,
    TipoNotificacao? tipo,
    String? mensagem,
    Object? tarefaId = _sentinel,
    String? usuarioId,
    bool? lida,
    DateTime? criadoEm,
  }) {
    return Notificacao(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      mensagem: mensagem ?? this.mensagem,
      tarefaId: tarefaId == _sentinel ? this.tarefaId : tarefaId as String?,
      usuarioId: usuarioId ?? this.usuarioId,
      lida: lida ?? this.lida,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  bool operator ==(Object other) => other is Notificacao && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Notificacao(id: $id, lida: $lida)';
}
