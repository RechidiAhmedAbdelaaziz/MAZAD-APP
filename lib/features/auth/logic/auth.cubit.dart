import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/models/api_response.model.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';

import '../data/repository/auth.repo.dart';
import '../data/source/auth.cache.dart';

part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authRepo = locator<AuthRepo>();
  final _authCache = locator<AuthCache>();

  AuthCubit() : super(AuthState.initial());

  Future<bool> get isAuthenticated async =>
      await _authCache.isAuthenticated;

  void checkAuth() async {
    final isAuth = await _authCache.isAuthenticated;
    isAuth
        ? emit(state._authenticated())
        : emit(state._unauthenticated());
  }

  void authenticate(AuthTokens tokens) async {
    emit(state._authenticated());
    await _authCache.setTokens(tokens);
  }

  Future<void> refreshToken()  async {
    emit(state._loading());

    final refreshToken = await _authCache.refreshToken;
    if (refreshToken == null) {
      logout();
      return;
    }

    final result = await _authRepo.refreshToken(refreshToken);
    result.when(
      success: (tokens) => authenticate(tokens),
      error: (error) {
        emit(state._error(error.message));
        logout();
      },
    );
  }

  void logout() async {
    emit(state._unauthenticated());
    await _authCache.clearTokens();

    locator<AppRouter>().routerConfig.goNamed(AppRoutes.login);
  }
}
