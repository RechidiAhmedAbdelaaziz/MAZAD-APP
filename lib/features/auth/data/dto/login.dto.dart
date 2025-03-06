import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/validator.extension.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';

class LoginDTO extends FormDTO {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String? validatePhone(String? value, BuildContext context) =>
      value.isValidPhoneNumber
          ? null
          : 'InvalidPhoneNumber'.tr(context);

  String? validatePassword(String? value, BuildContext context) =>
      value.isValidPassword ? null : 'IncorrectPassword'.tr(context);

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'login': phoneController.text,
      'password': passwordController.text,
    };
  }
}
