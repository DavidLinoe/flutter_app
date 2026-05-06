import 'package:flutter_app/pages/detalhes_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: AuthService.instance,
  redirect: (context, state) {
    final logado = AuthService.instance.logado;
    final indoParaLogin = state.matchedLocation == '/login';

    if (!logado && !indoParaLogin) return '/login';
    if (logado && indoParaLogin) return '/home';
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'detalhes/:id',
          builder: (context, state) {
            final extra = state.extra as Map<String, String>?;
            return DetalhesPage(
              titulo: extra?['titulo'] ?? 'Missão',
              prioridade: extra?['prioridade'] ?? 'Normal',
            );
          },
        ),
      ],
    ),
  ],
);
