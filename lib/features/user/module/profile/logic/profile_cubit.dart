import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/types/cubitstate/error.state.dart';
import 'package:mazad_app/features/user/source/dto/user_dto.dart';
import 'package:mazad_app/features/user/source/repo/user_repo.dart';

part 'profile_state.dart';

abstract class UserCubit<T extends UserDto>
    extends Cubit<ProfileState<T>> {
  final _userRepo = locator<UserRepo>();

  UserCubit() : super(ProfileState());

  void load();

  void save() async {
    if (!state.dto.validate()) return;
    emit(state._loading());

    final result = await _userRepo.updateUser(state.dto);

    result.when(
      success: (_) {
        emit(state._saved());
       
      },
      error: (error) => emit(state._error(error.message)),
    );
  }
}

class ProfileCubit extends UserCubit<UpdateUserDTO> {
  @override
  void load() async {
    emit(state._loading());

    final result = await _userRepo.getMe();

    result.when(
      success: (user) => emit(state._loaded(UpdateUserDTO(user))),
      error: (error) => emit(state._error(error.message)),
    );
  }
}

class PasswordCubit extends UserCubit<UpdatePasswordDTO> {
  @override
  void load() => emit(state._loaded(UpdatePasswordDTO()));
}
