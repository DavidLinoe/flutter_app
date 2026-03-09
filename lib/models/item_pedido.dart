const Object _sentinelItem = Object();

class ItemPedido {
  final String idProduto;
  final String nomeProduto;
  final int quantidade;
  final double precoUnitario;
  final String? observacao;

  const ItemPedido({
    required this.idProduto,
    required this.nomeProduto,
    required this.quantidade,
    required this.precoUnitario,
    this.observacao,
  });

  double get valorTotal => quantidade * precoUnitario;

  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      idProduto: json['id_produto'] as String,
      nomeProduto: json['nome_produto'] as String,
      quantidade: json['quantidade'] as int,
      precoUnitario: (json['preco_unitario'] as num).toDouble(),
      observacao: json['observacao'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id_produto': idProduto,
        'nome_produto': nomeProduto,
        'quantidade': quantidade,
        'preco_unitario': precoUnitario,
        'observacao': observacao,
      };

  ItemPedido copyWith({
    String? idProduto,
    String? nomeProduto,
    int? quantidade,
    double? precoUnitario,
    Object? observacao = _sentinelItem,
  }) {
    return ItemPedido(
      idProduto: idProduto ?? this.idProduto,
      nomeProduto: nomeProduto ?? this.nomeProduto,
      quantidade: quantidade ?? this.quantidade,
      precoUnitario: precoUnitario ?? this.precoUnitario,
      observacao:
          observacao == _sentinelItem ? this.observacao : observacao as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ItemPedido &&
      other.idProduto == idProduto &&
      other.quantidade == quantidade;

  @override
  int get hashCode => Object.hash(idProduto, quantidade);

  @override
  String toString() =>
      'ItemPedido(produto: $nomeProduto, qtd: $quantidade, total: $valorTotal)';
}
