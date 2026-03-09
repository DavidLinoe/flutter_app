import 'enums.dart';
import 'item_pedido.dart';

const Object _sentinelPedido = Object();

class Pedido {
  final String id;
  final String idUsuario;
  final List<ItemPedido> itens;
  final StatusPedido status;
  final DateTime criadoEm;
  final String? enderecoEntrega;

  Pedido({
    required this.id,
    required this.idUsuario,
    required this.itens,
    required this.status,
    required this.criadoEm,
    this.enderecoEntrega,
  });

  double get valorTotal =>
      itens.fold(0.0, (soma, item) => soma + item.valorTotal);

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'] as String,
      idUsuario: json['id_usuario'] as String,
      itens: (json['itens'] as List<dynamic>)
          .map((e) => ItemPedido.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: StatusPedido.values.byName(json['status'] as String),
      criadoEm: DateTime.parse(json['criado_em'] as String),
      enderecoEntrega: json['endereco_entrega'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_usuario': idUsuario,
        'itens': itens.map((i) => i.toJson()).toList(),
        'status': status.name,
        'criado_em': criadoEm.toIso8601String(),
        'endereco_entrega': enderecoEntrega,
      };

  Pedido copyWith({
    String? id,
    String? idUsuario,
    List<ItemPedido>? itens,
    StatusPedido? status,
    DateTime? criadoEm,
    Object? enderecoEntrega = _sentinelPedido,
  }) {
    return Pedido(
      id: id ?? this.id,
      idUsuario: idUsuario ?? this.idUsuario,
      itens: itens ?? this.itens,
      status: status ?? this.status,
      criadoEm: criadoEm ?? this.criadoEm,
      enderecoEntrega: enderecoEntrega == _sentinelPedido
          ? this.enderecoEntrega
          : enderecoEntrega as String?,
    );
  }

  @override
  bool operator ==(Object other) => other is Pedido && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'Pedido(id: $id, usuario: $idUsuario, status: ${status.name}, total: $valorTotal)';
}
