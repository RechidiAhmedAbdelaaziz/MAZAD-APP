import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';

class AuthNavigator extends AppNavigatorBase {
  AuthNavigator.login() : super(name: AppRoutes.login);

  AuthNavigator.signup() : super(name: AppRoutes.signup);

  AuthNavigator.forgetPassword()
    : super(name: AppRoutes.forgetPassword);

  AuthNavigator.resetPassword()
    : super(name: AppRoutes.resetPassword);

  AuthNavigator.verifyAccount()
    : super(name: AppRoutes.verifyAccount);
}
