import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/user/source/repo/user_repo.dart';
import 'package:mazad_app/features/user/source/source/user_api.dart';

abstract class UserDependency {
  static void init() {
    locator.registerLazySingleton(() => UserApi(locator()));
    locator.registerLazySingleton(() => UserRepo());
  }
}
