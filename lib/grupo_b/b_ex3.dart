import 'dart:math';

class Produto {
  final String nome;
  final String categoria;
  final double preco;
  final bool disponivel;

  Produto({
    required this.nome,
    required this.categoria,
    required this.preco,
    required this.disponivel,
  });

  @override
  String toString() => '$nome - R\$ $preco';
}

extension SincronizacaoProdutoExtension on List<Produto> {
  List<Produto> get validos {
    return where((p) => p.preco > 0 && p.nome.isNotEmpty && p.disponivel)
        .toList();
  }

  Map<String, List<Produto>> get agrupadosParaSincronizacao {
    final mapa = <String, List<Produto>>{};
    for (final p in this) {
      if (mapa[p.categoria] == null) {
        mapa[p.categoria] = [];
      }
      mapa[p.categoria]!.add(p);
    }
    return mapa;
  }
}

class SincronizacaoService {
  Future<int> sincronizar(List<Produto> produtos) async {
    int sucessos = 0;
    int falhas = 0;

    print('Iniciando sincronizacao de ${produtos.length} produtos...');

    for (final produto in produtos) {
      await Future.delayed(
          Duration(milliseconds: 100 + Random().nextInt(400)));

      if (Random().nextDouble() < 0.2) {
        falhas++;
        print('Falha: ${produto.nome}');
      } else {
        sucessos++;
        print('OK: ${produto.nome}');
      }
    }

    print('Resultado: $sucessos sucessos | $falhas falhas');
    return sucessos;
  }
}

void main() async {
  final produtos = [
    Produto(nome: 'Notebook', categoria: 'Eletronicos', preco: 3500.0, disponivel: true),
    Produto(nome: 'Mouse', categoria: 'Perifericos', preco: 89.90, disponivel: true),
    Produto(nome: 'Teclado', categoria: 'Perifericos', preco: 450.0, disponivel: true),
    Produto(nome: '', categoria: 'Perifericos', preco: 150.0, disponivel: true),
    Produto(nome: 'Monitor', categoria: 'Eletronicos', preco: 1200.0, disponivel: false),
    Produto(nome: 'Webcam', categoria: 'Perifericos', preco: 250.0, disponivel: true),
    Produto(nome: 'SSD', categoria: 'Armazenamento', preco: 350.0, disponivel: true),
    Produto(nome: 'Processador', categoria: 'Componentes', preco: -100.0, disponivel: true),
    Produto(nome: 'Headset', categoria: 'Perifericos', preco: 180.0, disponivel: true),
    Produto(nome: 'Impressora', categoria: 'Eletronicos', preco: 800.0, disponivel: true),
  ];

  final validos = produtos.validos;
  print('Produtos validos: ${validos.length}');

  final agrupados = validos.agrupadosParaSincronizacao;
  print('Categorias: ${agrupados.keys.toList()}');

  final servico = SincronizacaoService();
  final total = await servico.sincronizar(validos);

  print('Total sincronizado: $total produtos');
}
