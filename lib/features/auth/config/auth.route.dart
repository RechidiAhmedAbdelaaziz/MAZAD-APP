import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/auth/modules/login/logic/login.cubit.dart';
import 'package:mazad_app/features/auth/modules/login/ui/login.screen.dart';
import 'package:mazad_app/features/auth/modules/signup/logic/signup_cubit.dart';
import 'package:mazad_app/features/auth/modules/signup/ui/signup.screen.dart';
import 'package:mazad_app/features/auth/modules/verifyaccount/logic/verify_account_cubit.dart';
import 'package:mazad_app/features/auth/modules/verifyaccount/ui/verify_account_screen.dart';

abstract class AuthRoute {
  static List<GoRoute> routes = [
    // Login Screen
    GoRoute(
      path: '/login',
      name: AppRoutes.login,
      builder:
          (context, state) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
    ),

    // Signup Screen
    GoRoute(
      path: '/signup',
      name: AppRoutes.signup,
      builder:
          (context, state) => BlocProvider(
            create: (context) => SignupCubit(),
            child: SignupScreen(),
          ),
    ),

    // Verify Account Screen
    GoRoute(
      path: '/verify-account',
      name: AppRoutes.verifyAccount,
      builder:
          (context, state) => BlocProvider(
            create: (context) => VerifyAccountCubit(),
            child: VerifyAccountScreen(),
          ),
    ),
  ];
}
