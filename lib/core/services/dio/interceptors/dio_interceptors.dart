import 'package:dio/dio.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/auth/data/source/auth.cache.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

part 'dio_logger.dart';
part 'auth_token_setter.dart';
part 'error_interceptor.dart';

extension DioInterceptors on Dio {
  void addLogger() => interceptors.add(_AppDioLogger.instance);
  void removeLogger() => interceptors.remove(_AppDioLogger.instance);

  void addAuthTokenInterceptor() =>
      interceptors.add(_AuthTokenInterceptor.instance);
  void removeAuthTokenInterceptor() =>
      interceptors.remove(_AuthTokenInterceptor.instance);

  void addErrorInterceptor() =>
      interceptors.add(DioErrorInterceptor.instance);
  void removeErrorInterceptor() =>
      interceptors.remove(DioErrorInterceptor.instance);
}
