// ignore_for_file: library_private_types_in_public_api

part of 'signup_cubit.dart';

enum _SignupStatus { initial, loading, success, error }

class SignupState extends ErrorState {
  final SignupDTO signupDTO;
  final _SignupStatus status;

  SignupState({
    required this.signupDTO,
    this.status = _SignupStatus.initial,
    String? error,
  }) : super(error);

  factory SignupState.initial() =>
      SignupState(signupDTO: SignupDTO());

  bool get isLoading => status == _SignupStatus.loading;

  SignupState _loading() => _copyWith(status: _SignupStatus.loading);

  SignupState _success() => _copyWith(status: _SignupStatus.success);

  SignupState _error(String error) =>
      _copyWith(status: _SignupStatus.error, error: error);

  SignupState _copyWith({
    SignupDTO? signupDTO,
    _SignupStatus? status,
    String? error,
  }) {
    return SignupState(
      signupDTO: signupDTO ?? this.signupDTO,
      status: status ?? this.status,
      error: error,
    );
  }

  void onSuccess(VoidCallback onSuccessfulSignup) {
    if (status == _SignupStatus.success) {
      onSuccessfulSignup();
    }
  }

  void dispose() => signupDTO.dispose();
}
