part of '../signup.screen.dart';

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    final dto = context.read<SignupCubit>().state.signupDTO;
    return Form(
      key: dto.formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'FullName'.tr(context),
            controller: dto.nameController,
            keyboardType: TextInputType.text,
            validator: (value) => dto.validateName(value, context),
            prefixIcon: SvgPicture.asset(
              AppAssets.person,
              height: 20.h,
              width: 20.w,
            ),
          ),
          heightSpace(23),

          KDropDownMenu(
            items: StaticData.regions,
            controller: dto.regionController,
            validator: (value) => dto.validateRegion(value, context),
            hintText: 'Wilaya'.tr(context),
            prefixIcon: SvgPicture.asset(
              AppAssets.location,
              height: 20.h,
              width: 20.w,
            ),
          ),
          heightSpace(23),

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
            prefixIcon: SvgPicture.asset(
              AppAssets.password,
              height: 20.h,
              width: 20.w,
            ),
          ),
          heightSpace(23),

          AppTextFormField(
            hintText: 'ConfirmPassword'.tr(context),
            controller: dto.confirmPasswordController,
            obscureText: true,
            validator:
                (value) =>
                    dto.validateConfirmPassword(value, context),
            prefixIcon: SvgPicture.asset(
              AppAssets.password,
              height: 20.h,
              width: 20.w,
            ),
          ),
        ],
      ),
    );
  }
}
