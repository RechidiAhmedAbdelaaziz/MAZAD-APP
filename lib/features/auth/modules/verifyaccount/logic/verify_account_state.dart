// ignore_for_file: library_private_types_in_public_api

part of 'verify_account_cubit.dart';

enum _VerifyAccountStatus { initial, loading,  otpSended,  success, error }

class VerifyAccountState extends ErrorState {
  final VerifyAccountDTO verifyAccountDTO;
  final _VerifyAccountStatus status;

  VerifyAccountState({
    required this.verifyAccountDTO,
    this.status = _VerifyAccountStatus.initial,
    String? error,
  }) : super(error);

  factory VerifyAccountState.initial() =>
      VerifyAccountState(verifyAccountDTO: VerifyAccountDTO());

      bool get isLoading => status == _VerifyAccountStatus.loading;

  VerifyAccountState _loading() =>
      _copyWith(status: _VerifyAccountStatus.loading);

  VerifyAccountState _success() =>
      _copyWith(status: _VerifyAccountStatus.success);

  VerifyAccountState _otpSended() =>
      _copyWith(status: _VerifyAccountStatus.otpSended);

  VerifyAccountState _error(String error) =>
      _copyWith(status: _VerifyAccountStatus.error, error: error);

  VerifyAccountState _copyWith({
    VerifyAccountDTO? verifyAccountDTO,
    _VerifyAccountStatus? status,
    String? error,
  }) {
    return VerifyAccountState(
      verifyAccountDTO: verifyAccountDTO ?? this.verifyAccountDTO,
      status: status ?? this.status,
      error: error,
    );
  }

  void onOtpSent(VoidCallback callback) {
    if (status == _VerifyAccountStatus.otpSended) {
      callback();
    }
  }

  void onSucess(VoidCallback callback) {
    if (status == _VerifyAccountStatus.success) {
      callback();
    }
  }
}
