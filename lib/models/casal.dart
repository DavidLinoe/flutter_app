class Casal {
  final String id;
  final String esposaId;
  final String maridoId;
  final DateTime criadoEm;
  final DateTime? dataAtualizacao;

  Casal({
    required this.id,
    required this.esposaId,
    required this.maridoId,
    required this.criadoEm,
    this.dataAtualizacao,
  });

  factory Casal.fromJson(Map<String, dynamic> json) {
    return Casal(
      id: json['id'] as String,
      esposaId: json['esposa_id'] as String,
      maridoId: json['marido_id'] as String,
      criadoEm: DateTime.parse(json['criado_em'] as String),
      dataAtualizacao: json['data_atualizacao'] != null
          ? DateTime.parse(json['data_atualizacao'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'esposa_id': esposaId,
        'marido_id': maridoId,
        'criado_em': criadoEm.toIso8601String(),
        'data_atualizacao': dataAtualizacao?.toIso8601String(),
      };

  bool contemUsuario(String usuarioId) =>
      usuarioId == esposaId || usuarioId == maridoId;

  String? obterIdParceiro(String usuarioId) {
    if (usuarioId == esposaId) return maridoId;
    if (usuarioId == maridoId) return esposaId;
    return null;
  }

  @override
  bool operator ==(Object other) => other is Casal && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Casal(id: $id, esposaId: $esposaId, maridoId: $maridoId)';
}
