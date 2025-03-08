import 'package:dio/dio.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _UserApi;

  @GET('/users/me')
  Future<SingleDataResponse> getMe();

  @PATCH('/users/me')
  Future<SingleDataResponse> updateMe(
    @Body() Map<String, dynamic> body,
  );
}
