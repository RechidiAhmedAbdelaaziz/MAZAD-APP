part of 'auth.cubit.dart';

class AuthState extends ErrorState {
  

  AuthState({ String? error})
    : super(error);

  factory AuthState.initial() => AuthState();

  AuthState _authenticated() => _copyWith(isAuthanticated: true);
  AuthState _unauthenticated() => _copyWith(isAuthanticated: false);
  AuthState _loading() => _copyWith();
  AuthState _error(String error) => _copyWith(error: error);

  AuthState _copyWith({bool? isAuthanticated, String? error}) =>
      AuthState(
       
        error: error,
      );
}