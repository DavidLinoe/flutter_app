import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/models/usuario.dart';

void main() {
  final json = {
    'id': 'usr-001',
    'nome_completo': 'Ana Lima',
    'email': 'ana@exemplo.com',
    'telefone': '+5511999990000',
    'foto_perfil_url': null,
    'ativo': true,
    'criado_em': '2024-09-15T10:30:00.000Z',
  };

  test('fromJson cria Usuario corretamente', () {
    final usuario = Usuario.fromJson(json);

    expect(usuario.id, 'usr-001');
    expect(usuario.nomeCompleto, 'Ana Lima');
    expect(usuario.email, 'ana@exemplo.com');
    expect(usuario.telefone, '+5511999990000');
    expect(usuario.fotoPerfilUrl, isNull);
    expect(usuario.ativo, isTrue);
    expect(usuario.criadoEm, DateTime.parse('2024-09-15T10:30:00.000Z'));
  });

  test('toJson produz mapa correto', () {
    final usuario = Usuario.fromJson(json);
    final resultado = usuario.toJson();

    expect(resultado['id'], 'usr-001');
    expect(resultado['nome_completo'], 'Ana Lima');
    expect(resultado['email'], 'ana@exemplo.com');
    expect(resultado['foto_perfil_url'], isNull);
    expect(resultado['ativo'], isTrue);
    expect(resultado['criado_em'], isA<String>());
  });

  test('copyWith modifica apenas os campos especificados', () {
    final usuario = Usuario.fromJson(json);
    final atualizado = usuario.copyWith(telefone: '+5511000000000');

    expect(atualizado.telefone, '+5511000000000');
    expect(atualizado.id, usuario.id);
    expect(atualizado.nomeCompleto, usuario.nomeCompleto);
    expect(atualizado.email, usuario.email);
  });

  test('copyWith com fotoPerfilUrl null limpa o campo', () {
    final comFoto = Usuario.fromJson({...json, 'foto_perfil_url': 'https://img.com/foto.jpg'});
    final semFoto = comFoto.copyWith(fotoPerfilUrl: null);

    expect(semFoto.fotoPerfilUrl, isNull);
  });

  test('dois usuarios com mesmo id sao iguais', () {
    final u1 = Usuario.fromJson(json);
    final u2 = Usuario.fromJson({...json, 'telefone': '+550000000'});

    expect(u1, equals(u2));
  });
}
