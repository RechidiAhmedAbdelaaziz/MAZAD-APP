import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';
import 'package:mazad_app/features/user/source/model/user_model.dart';

abstract class UserDto extends FormDTO {
  void empty();
}

class UpdateUserDTO extends UserDto {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController region;

  UpdateUserDTO(UserModel user)
    : name = TextEditingController(text: user.name),
      phone = TextEditingController(text: user.phone),
      region = TextEditingController(text: user.region);

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'name': name.text,
      'phone': phone.text,
      'region': region.text,
    };
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    region.dispose();
  }

  @override
  void empty() {
    name.clear();
    phone.clear();
    region.clear();
  }
}

class UpdatePasswordDTO extends UserDto {
  final TextEditingController oldPassword;
  final TextEditingController newPassword;
  final TextEditingController confirmPassword;

  UpdatePasswordDTO()
    : oldPassword = TextEditingController(),
      newPassword = TextEditingController(),
      confirmPassword = TextEditingController();

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {'password': oldPassword.text};
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
  }

  @override
  void empty() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }
}
