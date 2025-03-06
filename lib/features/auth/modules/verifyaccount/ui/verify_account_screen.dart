import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/snackbar.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/shared/widgets/text_button.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';
import 'package:mazad_app/core/themes/icons.dart';

import '../logic/verify_account_cubit.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dto =
        context.read<VerifyAccountCubit>().state.verifyAccountDTO;
    return BlocListener<VerifyAccountCubit, VerifyAccountState>(
      listener: (context, state) {
        state.onOtpSent(
          () => context.showSuccessSnackbar('OtpSent'.tr(context)),
        );

        state.onSucess(() {
          //TODO go to home screen
        });

        state.onError(context.showErrorSnackbar);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w),
            child: Column(
              children: [
                heightSpace(250),
                SvgPicture.asset(AppAssets.logo),
                heightSpace(120),
                AppTextFormField(
                  controller: dto.otpController,
                  hintText: 'WriteOTP'.tr(context),
                  validator:
                      (value) => dto.validateOtp(value, context),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                  ],
                  maxLength: 5,
                ),
                heightSpace(20),
                Builder(
                  builder: (context) {
                    final isLoading = context.select(
                      (VerifyAccountCubit cubit) =>
                          cubit.state.isLoading,
                    );
                    return SubmitButton(
                      title: 'Next'.tr(context),
                      onTap: () {
                        context
                            .read<VerifyAccountCubit>()
                            .verifyAccount();
                      },
                      isLoading: isLoading,
                    );
                  },
                ),
                heightSpace(20),
                AppTextButton(
                  title: 'ResendOTP'.tr(context),
                  onTap: () {
                    context.read<VerifyAccountCubit>().resendOtp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
