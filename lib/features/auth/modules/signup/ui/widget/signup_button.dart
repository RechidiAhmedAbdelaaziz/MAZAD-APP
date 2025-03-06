part of '../signup.screen.dart';

class _SignupButton extends StatelessWidget {
  const _SignupButton();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (SignupCubit cubit) => cubit.state.isLoading,
    );
    return SubmitButton(
      title: 'Register'.tr(context),
      isLoading: isLoading,
      onTap: context.read<SignupCubit>().signup,
      
    );
  }
}
