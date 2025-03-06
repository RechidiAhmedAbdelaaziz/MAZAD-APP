import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/home/ui/home_screen.dart';

class HomeNavigator extends AppNavigatorBase {
  HomeNavigator() : super(name: AppRoutes.home);

  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutes.home,
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
  ];
}
