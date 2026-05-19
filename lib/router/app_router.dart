import 'package:flutter_app/pages/detalhes_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/providers/setup_locator.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final getIt = GetIt.instance;

// sl<AuthService>() acessa o GetIt porque o router não tem BuildContext
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
          path: 'detalhes/:id',
          builder: (context, state) => DetalhesPage(
            id: state.pathParameters['id']!,
          ),
        ),
      ],
    ),
  ],
);
