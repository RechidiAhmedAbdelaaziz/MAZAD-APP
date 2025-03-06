import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:mazad_app/core/services/cache/cache.service.dart';

abstract class AuthCache {
  final _cacheHelper = locator<CacheService>();

  Future<void> setTokens(AuthTokens tokens);
  Future<String?> get accessToken;
  Future<String?> get refreshToken;
  Future<void> clearTokens();

  Future<bool> get isAuthenticated async {
    final accessToken = await this.accessToken;
    return accessToken != null;
  }
}

class SecureAuthCache extends AuthCache {
  @override
  Future<void> setTokens(AuthTokens tokens) async {
    await Future.wait([
      _cacheHelper.setSecuredString(
        'ACCESS_TOKEN',
        tokens.accessToken,
      ),
      _cacheHelper.setSecuredString(
        'REFRESH_TOKEN',
        tokens.refreshToken,
      ),
    ]);
  }

  @override
  Future<String?> get accessToken async =>
      await _cacheHelper.getSecuredString('ACCESS_TOKEN');

  @override
  Future<String?> get refreshToken async =>
      await _cacheHelper.getSecuredString('REFRESH_TOKEN');

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _cacheHelper.removeSecuredData('ACCESS_TOKEN'),
      _cacheHelper.removeSecuredData('REFRESH_TOKEN'),
    ]);
  }
}

class WebAuthCache extends AuthCache {
  @override
  Future<void> setTokens(AuthTokens tokens) async {
    await Future.wait([
      _cacheHelper.setData('ACCESS_TOKEN', tokens.accessToken),
      _cacheHelper.setData('REFRESH_TOKEN', tokens.refreshToken),
    ]);
  }

  @override
  Future<String?> get accessToken async =>
      await _cacheHelper.getString('ACCESS_TOKEN');

  @override
  Future<String?> get refreshToken async =>
      await _cacheHelper.getString('REFRESH_TOKEN');

  @override
  Future<void> clearTokens() async {
    await _cacheHelper.removeData('ACCESS_TOKEN');
    await _cacheHelper.removeData('REFRESH_TOKEN');
  }
}
