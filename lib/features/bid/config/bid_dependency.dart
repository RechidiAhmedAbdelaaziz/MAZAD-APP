import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/bid/data/repository/bid_repo.dart';
import 'package:mazad_app/features/bid/data/source/bid_api.dart';

abstract class BidDependency {
  static void init() {
    locator.registerLazySingleton(() => BidApi(locator()));
    locator.registerLazySingleton(() => BidRepo());
  }
}
