import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/validator.extension.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';

class SignupDTO extends FormDTO {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final regionController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validateName(String? value, BuildContext context) =>
      value.isValidName ? null : 'InvalidName'.tr(context);

  String? validatePhone(String? value, BuildContext context) =>
      value.isValidPhoneNumber
          ? null
          : 'InvalidPhoneNumber'.tr(context);

  String? validatePassword(String? value, BuildContext context) =>
      value.isValidPassword ? null : 'InvalidPassword'.tr(context);

  String? validateConfirmPassword(
    String? value,
    BuildContext context,
  ) =>
      value == passwordController.text
          ? null
          : 'PasswordNotMatch'.tr(context);

  String? validateRegion(String? value, BuildContext context) =>
      !value.isEmpty ? null : 'RequiredField'.tr(context);

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    regionController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {
      'name': nameController.text,
      'phone': phoneController.text,
      'region': regionController.text,
      'password': passwordController.text,
    };
  }


}
