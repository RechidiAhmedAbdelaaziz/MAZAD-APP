import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/shared/widgets/text_button.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/core/themes/icons.dart';
import 'package:mazad_app/features/auction/config/auction_navigator.dart';
import 'package:mazad_app/features/auth/config/auth.navigator.dart';
import 'package:mazad_app/features/auth/modules/login/logic/login.cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.onError(context.showErrorDialog);
        state.onSuccess(
          () => context.offAll(AuctionNavigator.auctions()),
        );
      },
      child: Scaffold(
        backgroundColor: KColors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                heightSpace(185),
                SvgPicture.asset(AppAssets.logo),
                heightSpace(57),
                Text(
                  'Hello'.tr(context),
                  style: TextStyle(
                    color: KColors.white,
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                heightSpace(57),
                _Form(),
                heightSpace(23),
                // Align(
                //   alignment: AlignmentDirectional.centerEnd,
                //   child: AppTextButton(
                //     title: 'ForgetPassword'.tr(context),
                //     onTap: () {
                //       context.to(AuthNavigator.forgetPassword());
                //     },
                //   ),
                // ),
                // heightSpace(16),
                Builder(
                  builder: (context) {
                    final isLoading = context.select(
                      (LoginCubit cubit) => cubit.state.isLoading,
                    );
                    return SubmitButton(
                      title: 'Login'.tr(context),
                      isLoading: isLoading,
                      onTap: context.read<LoginCubit>().login,
                    );
                  },
                ),
                heightSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2.w,
                  children: [
                    Text(
                      'DontHaveAccount'.tr(context),
                      style: TextStyle(
                        color: KColors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppTextButton(
                      title: 'Register'.tr(context),
                      color: KColors.primary,
                      onTap:
                          () =>
                              context.offAll(AuthNavigator.signup()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final dto = context.read<LoginCubit>().state.loginDTO;
    return Form(
      key: dto.formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Phone'.tr(context),
            controller: dto.phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) => dto.validatePhone(value, context),
            prefixIcon: SvgPicture.asset(
              AppAssets.phone,
              height: 20.h,
              width: 20.w,
            ),
          ),
          heightSpace(23),
          AppTextFormField(
            hintText: 'Password'.tr(context),
            controller: dto.passwordController,
            obscureText: true,
            validator:
                (value) => dto.validatePassword(value, context),
            prefixIcon: SizedBox(
              height: 20.h,
              width: 20.w,
              child: SvgPicture.asset(
                AppAssets.password,
                height: 20.h,
                width: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
