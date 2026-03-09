import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/models/produto.dart';
import 'package:flutter_app/models/enums.dart';

void main() {
  final json = {
    'id': 'prd-001',
    'nome': 'Notebook',
    'descricao': 'Notebook gamer 16GB',
    'preco': 3500.0,
    'categoria': 'eletronicos',
    'disponivel': true,
    'imagem_url': null,
  };

  test('fromJson cria Produto corretamente', () {
    final produto = Produto.fromJson(json);

    expect(produto.id, 'prd-001');
    expect(produto.nome, 'Notebook');
    expect(produto.descricao, 'Notebook gamer 16GB');
    expect(produto.preco, 3500.0);
    expect(produto.categoria, CategoriaProduto.eletronicos);
    expect(produto.disponivel, isTrue);
    expect(produto.imagemUrl, isNull);
  });

  test('toJson produz mapa correto', () {
    final produto = Produto.fromJson(json);
    final resultado = produto.toJson();

    expect(resultado['id'], 'prd-001');
    expect(resultado['nome'], 'Notebook');
    expect(resultado['preco'], 3500.0);
    expect(resultado['categoria'], 'eletronicos');
    expect(resultado['disponivel'], isTrue);
    expect(resultado['imagem_url'], isNull);
  });

  test('copyWith modifica apenas os campos especificados', () {
    final produto = Produto.fromJson(json);
    final atualizado = produto.copyWith(preco: 2999.90, disponivel: false);

    expect(atualizado.preco, 2999.90);
    expect(atualizado.disponivel, isFalse);
    expect(atualizado.id, produto.id);
    expect(atualizado.nome, produto.nome);
    expect(atualizado.categoria, produto.categoria);
  });

  test('copyWith com imagemUrl null limpa o campo', () {
    final comImagem =
        Produto.fromJson({...json, 'imagem_url': 'https://img.com/foto.jpg'});
    final semImagem = comImagem.copyWith(imagemUrl: null);

    expect(semImagem.imagemUrl, isNull);
  });

  test('dois produtos com mesmo id sao iguais', () {
    final p1 = Produto.fromJson(json);
    final p2 = Produto.fromJson({...json, 'preco': 1000.0});

    expect(p1, equals(p2));
  });
}
