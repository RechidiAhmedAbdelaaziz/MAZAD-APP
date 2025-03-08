import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/constants/static_data.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/snackbar.extension.dart';
import 'package:mazad_app/core/extension/validator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/drop_down_menu.dart';
import 'package:mazad_app/core/shared/widgets/submit_button.dart';
import 'package:mazad_app/core/shared/widgets/text_form_field.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/user/module/profile/logic/profile_cubit.dart';
import 'package:mazad_app/features/user/source/dto/user_dto.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading1 = context.select(
      (PasswordCubit cubit) =>
          cubit.state.isLoading || !cubit.state.isLoaded,
    );
    final isLoading2 = context.select(
      (ProfileCubit cubit) =>
          cubit.state.isLoading || !cubit.state.isLoaded,
    );

    final isLoading = isLoading1 || isLoading2;

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState<UpdateUserDTO>>(
          listener: (context, state) {
            state.onError(context.showErrorSnackbar);
            state.onSaved(() {
              context.showSuccessSnackbar(
                'SavedSuccessfully'.tr(context),
              );
            });
          },
        ),

        BlocListener<PasswordCubit, ProfileState<UpdatePasswordDTO>>(
          listener: (context, state) {
            state.onError(context.showErrorSnackbar);
            state.onSaved(() {
              context.showSuccessSnackbar(
                'SavedSuccessfully'.tr(context),
              );
              state.dto.empty();
            });
          },
        ),
      ],
      child:
          isLoading
              ? Stack(
                children: [
                  SizedBox(
                    height: 3.h,
                    width: double.infinity,
                    child: LinearProgressIndicator(
                      color: KColors.primary,
                    ),
                  ),
                ],
              )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile'.tr(context),
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    heightSpace(12),
                    _ProfileForm(),

                    heightSpace(35),
                    Text(
                      'ChangePassword'.tr(context),
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    heightSpace(12),
                    _PasswordForm(),

                    heightSpace(8),
                  ],
                ),
              ),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final dto = context.select(
          (ProfileCubit cubit) => cubit.state.dto,
        );
        return Form(
          key: dto.formKey,
          child: Column(
            children: [
              AppTextFormField(
                title: 'Name'.tr(context),
                controller: dto.name,
                validator:
                    (value) =>
                        !value.isValidName
                            ? 'RequiredField'.tr(context)
                            : null,
              ),
              heightSpace(8),

              AppTextFormField(
                title: 'Phone'.tr(context),
                controller: dto.phone,
                validator:
                    (value) =>
                        !value.isValidPhoneNumber
                            ? 'RequiredField'.tr(context)
                            : null,
              ),
              heightSpace(8),

              KDropDownMenu(
                items: StaticData.regions,
                controller: dto.region,
                title: 'Region'.tr(context),
                validator:
                    (value) =>
                        value.isEmpty
                            ? 'RequiredField'.tr(context)
                            : null,
              ),
              heightSpace(12),

              SubmitButton(
                title: 'Save'.tr(context),
                onTap: context.read<ProfileCubit>().save,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final dto = context.select(
          (PasswordCubit cubit) => cubit.state.dto,
        );
        return Form(
          key: dto.formKey,
          child: Column(
            children: [
              AppTextFormField(
                title: 'OldPassword'.tr(context),
                controller: dto.oldPassword,
                validator:
                    (value) =>
                        !value.isValidPassword
                            ? 'WrongPassword'.tr(context)
                            : null,
              ),
              heightSpace(8),

              AppTextFormField(
                title: 'NewPassword'.tr(context),
                controller: dto.newPassword,
                validator:
                    (value) =>
                        !value.isValidPassword
                            ? 'InvalidPassword'.tr(context)
                            : null,
              ),
              heightSpace(8),

              AppTextFormField(
                title: 'ConfirmPassword'.tr(context),
                controller: dto.confirmPassword,
                validator:
                    (value) =>
                        value != dto.newPassword.text
                            ? 'PasswordNotMatch'.tr(context)
                            : null,
              ),
              heightSpace(12),

              SubmitButton(
                title: 'Save'.tr(context),
                onTap: () {
                  context.read<PasswordCubit>().save();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
