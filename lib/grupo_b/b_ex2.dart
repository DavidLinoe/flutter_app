enum StatusPedido { pendente, confirmado, preparando, entregue, cancelado }

class ItemPedido {
  final String nomeProduto;
  final int quantidade;
  final double precoUnitario;
  final String? observacao;

  const ItemPedido({
    required this.nomeProduto,
    required this.quantidade,
    required this.precoUnitario,
    this.observacao,
  });

  double get valorTotal => quantidade * precoUnitario;
}

class Pedido {
  final String id;
  final String idUsuario;
  final List<ItemPedido> itens;
  final StatusPedido status;
  final DateTime criadoEm;

  const Pedido({
    required this.id,
    required this.idUsuario,
    required this.itens,
    required this.status,
    required this.criadoEm,
  });

  double get valorTotal =>
      itens.fold(0.0, (soma, item) => soma + item.valorTotal);
}

sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T value;
  Success(this.value);
}

class Failure<T> extends Result<T> {
  final String message;
  Failure(this.message);
}

class RelatorioPedidos {
  final List<Pedido> pedidos;

  RelatorioPedidos(this.pedidos);

  double totalGeral() {
    return pedidos
        .where((p) => p.status != StatusPedido.cancelado)
        .fold(0.0, (soma, p) => soma + p.valorTotal);
  }

  Map<StatusPedido, List<Pedido>> pedidosPorStatus() {
    final mapa = <StatusPedido, List<Pedido>>{};
    for (final status in StatusPedido.values) {
      mapa[status] = pedidos.where((p) => p.status == status).toList();
    }
    return mapa;
  }

  double ticketMedio() {
    final validos =
        pedidos.where((p) => p.status != StatusPedido.cancelado).toList();
    if (validos.isEmpty) return 0.0;
    return validos.fold(0.0, (soma, p) => soma + p.valorTotal) / validos.length;
  }

  String produtoMaisVendido() {
    final quantidades = <String, int>{};
    for (final item in pedidos.expand((p) => p.itens)) {
      quantidades[item.nomeProduto] =
          (quantidades[item.nomeProduto] ?? 0) + item.quantidade;
    }
    return quantidades.entries
        .reduce((a, b) => a.value >= b.value ? a : b)
        .key;
  }

  List<Pedido> pedidosDoUsuario(String idUsuario) {
    return pedidos
        .where((p) => p.idUsuario == idUsuario)
        .toList()
      ..sort((a, b) => b.criadoEm.compareTo(a.criadoEm));
  }

  bool contemPedidoUrgente() {
    final limite = DateTime.now().subtract(const Duration(minutes: 30));
    return pedidos.any(
      (p) => p.status == StatusPedido.pendente && p.criadoEm.isBefore(limite),
    );
  }
}

Future<Result<RelatorioPedidos>> gerarRelatorio(List<Pedido> pedidos) async {
  if (pedidos.isEmpty) return Failure('Lista de pedidos vazia.');
  return Success(RelatorioPedidos(pedidos));
}

void main() async {
  final agora = DateTime.now();

  final pedidos = [
    Pedido(
      id: 'p1', idUsuario: 'usr-1',
      itens: [ItemPedido(nomeProduto: 'Notebook', quantidade: 1, precoUnitario: 3000.0)],
      status: StatusPedido.entregue,
      criadoEm: agora.subtract(const Duration(days: 5)),
    ),
    Pedido(
      id: 'p2', idUsuario: 'usr-1',
      itens: [ItemPedido(nomeProduto: 'Mouse', quantidade: 2, precoUnitario: 50.0)],
      status: StatusPedido.confirmado,
      criadoEm: agora.subtract(const Duration(days: 2)),
    ),
    Pedido(
      id: 'p3', idUsuario: 'usr-2',
      itens: [ItemPedido(nomeProduto: 'Teclado', quantidade: 1, precoUnitario: 200.0)],
      status: StatusPedido.pendente,
      criadoEm: agora.subtract(const Duration(hours: 2)),
    ),
    Pedido(
      id: 'p4', idUsuario: 'usr-2',
      itens: [ItemPedido(nomeProduto: 'Mouse', quantidade: 3, precoUnitario: 50.0)],
      status: StatusPedido.cancelado,
      criadoEm: agora.subtract(const Duration(days: 1)),
    ),
    Pedido(
      id: 'p5', idUsuario: 'usr-3',
      itens: [ItemPedido(nomeProduto: 'Monitor', quantidade: 1, precoUnitario: 1200.0)],
      status: StatusPedido.preparando,
      criadoEm: agora.subtract(const Duration(hours: 6)),
    ),
    Pedido(
      id: 'p6', idUsuario: 'usr-3',
      itens: [ItemPedido(nomeProduto: 'Notebook', quantidade: 2, precoUnitario: 3000.0)],
      status: StatusPedido.entregue,
      criadoEm: agora.subtract(const Duration(days: 3)),
    ),
    Pedido(
      id: 'p7', idUsuario: 'usr-1',
      itens: [ItemPedido(nomeProduto: 'SSD', quantidade: 1, precoUnitario: 350.0)],
      status: StatusPedido.confirmado,
      criadoEm: agora.subtract(const Duration(days: 4)),
    ),
    Pedido(
      id: 'p8', idUsuario: 'usr-4',
      itens: [ItemPedido(nomeProduto: 'Webcam', quantidade: 1, precoUnitario: 250.0)],
      status: StatusPedido.pendente,
      criadoEm: agora.subtract(const Duration(hours: 1)),
    ),
  ];

  final resultado = await gerarRelatorio(pedidos);

  switch (resultado) {
    case Failure<RelatorioPedidos>(:final message):
      print('Erro: $message');
    case Success<RelatorioPedidos>(:final value):
      print('Total: R\$ ${value.totalGeral().toStringAsFixed(2)}');
      print('Ticket medio: R\$ ${value.ticketMedio().toStringAsFixed(2)}');
      print('Mais vendido: ${value.produtoMaisVendido()}');
      print('Urgente: ${value.contemPedidoUrgente()}');
      print('Pedidos usr-1: ${value.pedidosDoUsuario('usr-1').map((p) => p.id).toList()}');
  }
}
