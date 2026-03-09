import 'enums.dart';

const Object _sentinelProduto = Object();

class Produto {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final CategoriaProduto categoria;
  final bool disponivel;
  final String? imagemUrl;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoria,
    required this.disponivel,
    this.imagemUrl,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      id: json['id'] as String,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      preco: (json['preco'] as num).toDouble(),
      categoria: CategoriaProduto.values.byName(json['categoria'] as String),
      disponivel: json['disponivel'] as bool,
      imagemUrl: json['imagem_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'descricao': descricao,
        'preco': preco,
        'categoria': categoria.name,
        'disponivel': disponivel,
        'imagem_url': imagemUrl,
      };

  Produto copyWith({
    String? id,
    String? nome,
    String? descricao,
    double? preco,
    CategoriaProduto? categoria,
    bool? disponivel,
    Object? imagemUrl = _sentinelProduto,
  }) {
    return Produto(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      preco: preco ?? this.preco,
      categoria: categoria ?? this.categoria,
      disponivel: disponivel ?? this.disponivel,
      imagemUrl: imagemUrl == _sentinelProduto
          ? this.imagemUrl
          : imagemUrl as String?,
    );
  }

  @override
  bool operator ==(Object other) => other is Produto && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Produto(id: $id, nome: $nome, preco: $preco, categoria: ${categoria.name})';
}
