import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/user/module/profile/logic/profile_cubit.dart';
import 'package:mazad_app/features/user/module/profile/ui/profile_screen.dart';

class UserNavigator extends AppNavigatorBase {
  UserNavigator.profile() : super(name: AppRoutes.profile);

  static List<RouteBase> routes = [
    GoRoute(
      path: '/profile',
      name: AppRoutes.profile,
      builder:
          (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProfileCubit()..load(),
              ),
              BlocProvider(
                create: (context) => PasswordCubit()..load(),
              ),
            ],
            child: ProfileScreen(),
          ),
    ),
  ];
}
