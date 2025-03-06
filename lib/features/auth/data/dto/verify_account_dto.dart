import 'package:flutter/widgets.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/shared/dto/form_dto.dart';

class OtpDTO extends FormDTO {
  final TextEditingController otpController = TextEditingController();

  String? validateOtp(String? value, BuildContext context) =>
      value?.length == 4 ? null : 'InvalidOtp'.tr(context);

  @override
  void dispose() {
    otpController.dispose();
  }

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {'otp': otpController.text};
  }

  
}

class VerifyAccountDTO extends OtpDTO {}
