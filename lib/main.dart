import 'package:flutter/material.dart';
import 'package:flutter_app/detalhesPage.dart' show DetalhesPage;
import 'package:flutter_app/homePage.dart' show HomePage;
import 'package:flutter_app/loginPage.dart';
import 'package:go_router/go_router.dart';
final _roteador = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
    ),
  ],
);

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _roteador,
      debugShowCheckedModeBanner: false,
    ),
  );
}
