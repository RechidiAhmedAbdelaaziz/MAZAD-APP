import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/auth/data/dto/login.dto.dart';
import 'package:mazad_app/features/auth/data/repository/auth.repo.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';

part 'login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _authRepo = locator<AuthRepo>();

  LoginCubit() : super(LoginState.initial());

  void login() async {
    if (!state.loginDTO.validate()) return;

    emit(state._loading());

    final result = await _authRepo.login(state.loginDTO);

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
    state.loginDTO.dispose();
    return super.close();
  }
}
