import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/products/data/repository/product_repo.dart';
import 'package:mazad_app/features/products/data/source/product_api.dart';

abstract class ProductDependency {
  static init() {
    locator.registerLazySingleton(() => ProductApi(locator()));
    locator.registerLazySingleton(() => ProductRepo());
  }
}
