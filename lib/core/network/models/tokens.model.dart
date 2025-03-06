part of 'api_response.model.dart';

class AuthTokens {
  AuthTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokens.fromJson(Map<String, dynamic>? json) {
    return AuthTokens(
      accessToken: json?['accessToken'],
      refreshToken: json?['refreshToken'],
    );
  }

  final String accessToken;
  final String refreshToken;
  
}
