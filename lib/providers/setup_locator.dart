import 'package:get_it/get_it.dart';
import '../services/auth_service.dart';

final sl = GetIt.instance;

Future<void> configurarDependencias() async {
  sl.registerLazySingleton<AuthService>(() => AuthService());
}
