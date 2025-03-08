import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/network/repo_base.dart';
import 'package:mazad_app/features/user/source/dto/user_dto.dart';
import 'package:mazad_app/features/user/source/source/user_api.dart';

import '../model/user_model.dart';

class UserRepo extends NetworkRepository {
  final _userApi = locator<UserApi>();

  RepoResult<UserModel> getMe() {
    return tryApiCall(() async {
      final response = await _userApi.getMe();
      return UserModel.fromJson(response.data!);
    });
  }

  RepoResult<UserModel> updateUser(UserDto dto) {
    return tryApiCall(() async {
      final response = await _userApi.updateMe(await dto.toMap());
      return UserModel.fromJson(response.data!);
    });
  }
}
