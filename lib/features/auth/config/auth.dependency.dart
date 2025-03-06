import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/auth/data/repository/auth.repo.dart';
import 'package:mazad_app/features/auth/data/source/auth.api.dart';
import 'package:mazad_app/features/auth/data/source/auth.cache.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';

abstract class AuthDependency {
  static void init() {
    locator.registerLazySingleton<AuthApi>(() => AuthApi(locator()));
    locator.registerLazySingleton<AuthRepo>(() => AuthRepo());

    locator.registerLazySingleton<AuthCache>(() => SecureAuthCache());

    locator.registerLazySingleton<AuthCubit>(
      () => AuthCubit()..checkAuth(),
    );
  }
}
