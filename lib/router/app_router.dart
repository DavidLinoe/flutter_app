import 'package:flutter_app/pages/detalhes_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/tarefa_form_page.dart';
import 'package:flutter_app/providers/setup_locator.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: sl<AuthService>(),
  redirect: (context, state) {
    final logado = sl<AuthService>().logado;
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
          path: 'nova-tarefa',
          builder: (context, state) => const TarefaFormPage(),
        ),
        GoRoute(
          path: 'detalhes/:id',
          builder: (context, state) => DetalhesPage(
            id: state.pathParameters['id']!,
          ),
          routes: [
            GoRoute(
              path: 'editar',
              builder: (context, state) => TarefaFormPage(
                id: state.pathParameters['id']!,
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
