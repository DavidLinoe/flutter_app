import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  AuthService._();
  static final AuthService instance = AuthService._();

  static const _mockEmail = 'marido@casa.com';
  static const _mockSenha = '123456';

  bool _logado = false;
  String? _emailAtual;

  bool get logado => _logado;
  String? get emailAtual => _emailAtual;

  Future<bool> login(String email, String senha) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.trim().toLowerCase() == _mockEmail && senha == _mockSenha) {
      _logado = true;
      _emailAtual = email.trim();
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _logado = false;
    _emailAtual = null;
    notifyListeners();
  }
}
