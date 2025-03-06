// ignore_for_file: library_private_types_in_public_api

part of 'login.cubit.dart';

enum _LoginStatus { initial, loading, success, error }

class LoginState extends ErrorState {
  final LoginDTO loginDTO;

  final _LoginStatus status;

  LoginState({
    required this.loginDTO,
    this.status = _LoginStatus.initial,
    String? error,
  }) : super(error);

  factory LoginState.initial() => LoginState(loginDTO: LoginDTO());

  bool get isLoading => status == _LoginStatus.loading;

  LoginState _loading() => _copyWith(status: _LoginStatus.loading);

  LoginState _success() => _copyWith(status: _LoginStatus.success);

  LoginState _error(String error) =>
      _copyWith(status: _LoginStatus.error, error: error);

  LoginState _copyWith({
    LoginDTO? loginDTO,
    _LoginStatus? status,
    String? error,
  }) {
    return LoginState(
      loginDTO: loginDTO ?? this.loginDTO,
      status: status ?? this.status,
      error: error,
    );
  }

  void onSuccess(VoidCallback callback) {
    if (status == _LoginStatus.success) {
      callback();
    }
  }
}
