import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/providers/setup_locator.dart';
import 'package:flutter_app/providers/tarefa_notifier.dart';
import 'package:flutter_app/router/app_router.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/tarefa_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configurarDependencias();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthService>()),
        ChangeNotifierProvider(create: (_) => TarefaNotifier(sl<TarefaService>())),
      ],
      child: MaterialApp.router(
        title: 'Minha mulher que manda',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
          useMaterial3: true,
        ),
      ),
    );
  }
}
