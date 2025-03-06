import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/features/auth/data/dto/login.dto.dart';
import 'package:mazad_app/features/auth/data/dto/signup.dto.dart';
import 'package:mazad_app/features/auth/data/dto/verify_account_dto.dart';
import 'package:mazad_app/features/auth/data/source/auth.api.dart';

class AuthRepo extends NetworkRepository {
  final _authApi = locator<AuthApi>();

  RepoResult<AuthTokens> login(LoginDTO dto) async {
    return tryApiCall(() async {
      final response = await _authApi.login(await dto.toMap());
      return response.tokens!;
    });
  }

  RepoResult<AuthTokens> signup(SignupDTO dto) async {
    return tryApiCall(() async {
      final response = await _authApi.register(await dto.toMap());
      return response.tokens!;
    });
  }

  RepoResult<AuthTokens> refreshToken(String refreshToken) async {
    return tryApiCall(() async {
      final response = await _authApi.refreshToken(refreshToken);
      return response.tokens!;
    });
  }

  RepoResult<AuthTokens> verify(OtpDTO dto) async {
    return tryApiCall(() async {
      final response = await _authApi.verify(await dto.toMap());
      return response.tokens!;
    });
  }

  RepoResult<void> resendVerificationCode( ) async {
    return tryApiCall(
      () async => await _authApi.resendVerificationCode(),
    );
  }
}
