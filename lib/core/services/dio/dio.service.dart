import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:mazad_app/core/services/dio/interceptors/dio_interceptors.dart';

class DioService {
  static Dio? _dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (_dio == null) {
      _dio = Dio();

      _dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.baseUrl =
            FlavorConfig.instance.variables["baseUrl"] ?? ''
        ..options.headers = {'Accept': 'application/json'};

      _dio!.addLogger();
      _dio!.addErrorInterceptor();
      _dio!.addAuthTokenInterceptor();

      return _dio!;
    } else {
      return _dio!;
    }
  }
}
