const Object _sentinel = Object();

class Usuario {
  final String id;
  final String nomeCompleto;
  final String email;
  final String telefone;
  final String? fotoPerfilUrl;
  final bool ativo;
  final DateTime criadoEm;

  Usuario({
    required this.id,
    required this.nomeCompleto,
    required this.email,
    required this.telefone,
    this.fotoPerfilUrl,
    required this.ativo,
    required this.criadoEm,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as String,
      nomeCompleto: json['nome_completo'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String,
      fotoPerfilUrl: json['foto_perfil_url'] as String?,
      ativo: json['ativo'] as bool,
      criadoEm: DateTime.parse(json['criado_em'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome_completo': nomeCompleto,
        'email': email,
        'telefone': telefone,
        'foto_perfil_url': fotoPerfilUrl,
        'ativo': ativo,
        'criado_em': criadoEm.toIso8601String(),
      };

  Usuario copyWith({
    String? id,
    String? nomeCompleto,
    String? email,
    String? telefone,
    Object? fotoPerfilUrl = _sentinel,
    bool? ativo,
    DateTime? criadoEm,
  }) {
    return Usuario(
      id: id ?? this.id,
      nomeCompleto: nomeCompleto ?? this.nomeCompleto,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      fotoPerfilUrl: fotoPerfilUrl == _sentinel
          ? this.fotoPerfilUrl
          : fotoPerfilUrl as String?,
      ativo: ativo ?? this.ativo,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  bool operator ==(Object other) => other is Usuario && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Usuario(id: $id, nome: $nomeCompleto, email: $email, tel: $telefone)';
}
