import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/auth/data/dto/signup.dto.dart';
import 'package:mazad_app/features/auth/data/repository/auth.repo.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final _authRepository = locator<AuthRepo>();

  SignupCubit() : super(SignupState.initial());

  void signup() async {
    if (!state.signupDTO.formKey.currentState!.validate()) return;

    emit(state._loading());

    final result = await _authRepository.signup(state.signupDTO);
    result.when(
      success: (tokens) {
        locator<AuthCubit>().authenticate(tokens);
        emit(state._success());
      },
      error: (error) => emit(state._error(error.message)),
    );
  }

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }
}
