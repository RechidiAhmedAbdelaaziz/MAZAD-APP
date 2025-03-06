import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazad_app/core/constants/static_data.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/drop_down_menu.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/shared/widgets/text_button.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/core/themes/icons.dart';
import 'package:mazad_app/features/auction/config/auction_navigator.dart';
import 'package:mazad_app/features/auth/config/auth.navigator.dart';
import 'package:mazad_app/features/auth/modules/signup/logic/signup_cubit.dart';

part 'widget/signup_form.dart';
part 'widget/signup_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        state.onError(context.showErrorDialog);

        state.onSuccess(
          () => context.offAll(AuctionNavigator.auctions()),
        );
      },
      child: Scaffold(
        backgroundColor: KColors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w),
            child: Column(
              children: [
                heightSpace(150),
                SvgPicture.asset(AppAssets.logo),
                heightSpace(40),
                _Form(),
                heightSpace(30),
                _SignupButton(),
                heightSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 2.w,
                  children: [
                    Text(
                      'AlreadyHaveAccount'.tr(context),
                      style: TextStyle(
                        color: KColors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    AppTextButton(
                      title: 'Login'.tr(context),
                      color: KColors.primary,
                      onTap: () => context.to(AuthNavigator.login()),
                    ),
                  ],
                ),
                heightSpace(25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
