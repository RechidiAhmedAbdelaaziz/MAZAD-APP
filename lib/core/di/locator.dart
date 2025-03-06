import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/features/auction/config/auction_dependency.dart';
import 'package:mazad_app/features/auth/config/auth.dependency.dart';
import 'package:mazad_app/features/banner/config/banner_dependency.dart';
import 'package:mazad_app/features/bid/config/bid_dependency.dart';
import 'package:mazad_app/features/products/config/product_dependency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mazad_app/core/services/cache/cache.service.dart';
import 'package:mazad_app/core/services/cloudstorage/cloud_storage.service.dart';
import 'package:mazad_app/core/services/cloudstorage/cloudinary.service.dart';
import 'package:mazad_app/core/services/dio/dio.service.dart';
import 'package:mazad_app/core/services/filepicker/filepick.service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final sharedpref = await SharedPreferences.getInstance();
  // SharedPreferences and FlutterSecureStorage
  locator.registerLazySingleton(() => sharedpref);
  locator.registerLazySingleton(() => FlutterSecureStorage());

  //CacheService
  locator.registerLazySingleton(() => CacheService());

  //Dio
  locator.registerLazySingleton(() => DioService.getDio());

  //Router
  locator.registerSingleton(AppRouter());

  //File Picker
  locator.registerLazySingleton<ImagePickerService>(
    () => kIsWeb ? WebFilePicker() : MobileFilePicker(),
  );

  //Cloud storage service
  locator.registerLazySingleton<ImageCloudStorageService>(
    () => CloudinaryService(),
  );


  // Features dependencies
  AuthDependency.init();
  AuctionDependency.init();
  BannerDependency.inti();
  ProductDependency.init();
  BidDependency.init();

  locator.allowReassignment = true;
}
