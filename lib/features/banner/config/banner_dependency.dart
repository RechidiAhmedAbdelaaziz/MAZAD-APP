import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/banner/data/repository/banner_repo.dart';
import 'package:mazad_app/features/banner/data/source/banner_api.dart';

abstract class BannerDependency {
  static void inti() {
    locator.registerLazySingleton(() => BannerApi(locator()));
    locator.registerLazySingleton(() => BannerRepo());
  }
}
