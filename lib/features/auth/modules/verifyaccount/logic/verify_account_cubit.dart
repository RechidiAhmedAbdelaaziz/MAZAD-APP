import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/auth/data/dto/verify_account_dto.dart';
import 'package:mazad_app/features/auth/data/repository/auth.repo.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';

part 'verify_account_state.dart';

class VerifyAccountCubit extends Cubit<VerifyAccountState> {
  final _authRepo = locator<AuthRepo>();
  VerifyAccountCubit() : super(VerifyAccountState.initial());

  void verifyAccount() async {
    if (!state.verifyAccountDTO.formKey.currentState!.validate()) {
      return;
    }

    emit(state._loading());
    final result = await _authRepo.verify(state.verifyAccountDTO);
    result.when(
      success: (tokens) {
        locator<AuthCubit>().authenticate(tokens);
        emit(state._success());
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  void resendOtp() async {
    emit(state._loading());
    final result = await _authRepo.resendVerificationCode();
    result.when(
      success: (_) => emit(state._otpSended()),
      error: (error) => emit(state._error(error.message)),
    );
  }
}
