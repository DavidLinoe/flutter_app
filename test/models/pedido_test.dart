import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/models/pedido.dart';
import 'package:flutter_app/models/item_pedido.dart';
import 'package:flutter_app/models/enums.dart';

void main() {
  final json = {
    'id': 'ped-001',
    'id_usuario': 'usr-001',
    'itens': [
      {
        'id_produto': 'prd-001',
        'nome_produto': 'Notebook',
        'quantidade': 1,
        'preco_unitario': 3500.0,
        'observacao': null,
      },
      {
        'id_produto': 'prd-002',
        'nome_produto': 'Mouse',
        'quantidade': 2,
        'preco_unitario': 50.0,
        'observacao': null,
      },
    ],
    'status': 'confirmado',
    'criado_em': '2024-09-15T10:30:00.000Z',
    'endereco_entrega': 'Rua das Flores, 123',
  };

  test('fromJson cria Pedido corretamente', () {
    final pedido = Pedido.fromJson(json);

    expect(pedido.id, 'ped-001');
    expect(pedido.idUsuario, 'usr-001');
    expect(pedido.itens.length, 2);
    expect(pedido.status, StatusPedido.confirmado);
    expect(pedido.enderecoEntrega, 'Rua das Flores, 123');
    expect(pedido.criadoEm, DateTime.parse('2024-09-15T10:30:00.000Z'));
  });

  test('toJson produz mapa correto', () {
    final pedido = Pedido.fromJson(json);
    final resultado = pedido.toJson();

    expect(resultado['id'], 'ped-001');
    expect(resultado['id_usuario'], 'usr-001');
    expect(resultado['status'], 'confirmado');
    expect(resultado['itens'], isA<List>());
    expect((resultado['itens'] as List).length, 2);
    expect(resultado['criado_em'], isA<String>());
  });

  test('valorTotal calcula corretamente', () {
    final pedido = Pedido.fromJson(json);

    expect(pedido.valorTotal, 3600.0);
  });

  test('copyWith modifica apenas os campos especificados', () {
    final pedido = Pedido.fromJson(json);
    final atualizado = pedido.copyWith(status: StatusPedido.entregue);

    expect(atualizado.status, StatusPedido.entregue);
    expect(atualizado.id, pedido.id);
    expect(atualizado.idUsuario, pedido.idUsuario);
    expect(atualizado.itens.length, pedido.itens.length);
  });

  test('copyWith com enderecoEntrega null limpa o campo', () {
    final pedido = Pedido.fromJson(json);
    final semEndereco = pedido.copyWith(enderecoEntrega: null);

    expect(semEndereco.enderecoEntrega, isNull);
  });

  test('dois pedidos com mesmo id sao iguais', () {
    final p1 = Pedido.fromJson(json);
    final p2 = Pedido.fromJson({...json, 'status': 'entregue'});

    expect(p1, equals(p2));
  });

  test('ItemPedido valorTotal calcula corretamente', () {
    final item = ItemPedido(
      idProduto: 'prd-001',
      nomeProduto: 'Notebook',
      quantidade: 2,
      precoUnitario: 3500.0,
    );

    expect(item.valorTotal, 7000.0);
  });
}
