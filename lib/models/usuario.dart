import 'enums.dart';

const Object _sentinel = Object();

class Usuario {
  final String id;
  final String nome;
  final String email;
  final String? telefone;
  final String? fotoPerfil;
  final TipoUsuario tipoUsuario;
  final String? parceiroId;
  final DateTime criadoEm;
  final DateTime? dataAtualizacao;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.telefone,
    this.fotoPerfil,
    required this.tipoUsuario,
    this.parceiroId,
    required this.criadoEm,
    this.dataAtualizacao,
  });

  bool get isEsposa => tipoUsuario == TipoUsuario.esposa;

  bool get isMarido => tipoUsuario == TipoUsuario.marido;

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as String,
      nome: json['nome'] as String,
      email: json['email'] as String,
      telefone: json['telefone'] as String?,
      fotoPerfil: json['foto_perfil'] as String?,
      tipoUsuario: TipoUsuario.fromString(json['tipo_usuario'] as String?) ??
          TipoUsuario.marido,
      parceiroId: json['parceiro_id'] as String?,
      criadoEm: DateTime.parse(json['criado_em'] as String),
      dataAtualizacao: json['data_atualizacao'] != null
          ? DateTime.parse(json['data_atualizacao'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'email': email,
        'telefone': telefone,
        'foto_perfil': fotoPerfil,
        'tipo_usuario': tipoUsuario.value,
        'parceiro_id': parceiroId,
        'criado_em': criadoEm.toIso8601String(),
        'data_atualizacao': dataAtualizacao?.toIso8601String(),
      };

  Usuario copyWith({
    String? id,
    String? nome,
    String? email,
    Object? telefone = _sentinel,
    Object? fotoPerfil = _sentinel,
    TipoUsuario? tipoUsuario,
    Object? parceiroId = _sentinel,
    DateTime? criadoEm,
    Object? dataAtualizacao = _sentinel,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone == _sentinel ? this.telefone : telefone as String?,
      fotoPerfil:
          fotoPerfil == _sentinel ? this.fotoPerfil : fotoPerfil as String?,
      tipoUsuario: tipoUsuario ?? this.tipoUsuario,
      parceiroId:
          parceiroId == _sentinel ? this.parceiroId : parceiroId as String?,
      criadoEm: criadoEm ?? this.criadoEm,
      dataAtualizacao: dataAtualizacao == _sentinel
          ? this.dataAtualizacao
          : dataAtualizacao as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) => other is Usuario && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Usuario(id: $id, nome: $nome)';
}
