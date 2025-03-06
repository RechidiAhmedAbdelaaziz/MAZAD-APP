import 'package:dio/dio.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:retrofit/retrofit.dart';

part 'auth.api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(
    Dio dio, {
    String baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _AuthApi;

  @POST("/auth/login") //* LOGIN ~ {{URL}}/auth/login
  Future<AuthResponse> login(@Body() Map<String, dynamic> body);

  @POST("/auth/register") //* REGISTER ~ {{URL}}/auth/register
  Future<AuthResponse> register(@Body() Map<String, dynamic> body);

  @GET("/auth/refresh") //* REFRESH TOKEN ~ {{URL}}/auth/refresh
  Future<AuthResponse> refreshToken(
    @Query("refresh_token") String refreshToken,
  );

  @POST("/auth/verify") //!  VERIFY ~ {{URL}}/auth/verify
  Future<AuthResponse> verify(@Body() Map<String, dynamic> body);

  @GET(
    'resend-verification',
  ) //!  RESEND VERIFICATION CODE ~ {{URL}}/resend-verification
  Future<MessageResponse> resendVerificationCode();
}
