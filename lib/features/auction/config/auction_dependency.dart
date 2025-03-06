import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/auction/data/repository/auction_repo.dart';
import 'package:mazad_app/features/auction/data/source/auction_api.dart';

abstract class AuctionDependency {
  static init() {
    locator.registerLazySingleton(() => AuctionApi(locator()));
    locator.registerLazySingleton(() => AuctionRepo());
  }
}
