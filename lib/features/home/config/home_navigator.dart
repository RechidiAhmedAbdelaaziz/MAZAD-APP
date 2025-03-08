import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/features/auction/modules/auctions/logic/auctions_cubit.dart';
import 'package:mazad_app/features/auction/modules/auctions/ui/auctions_screen.dart';
import 'package:mazad_app/features/banner/modules/banners/logic/banners_cubit.dart';
import 'package:mazad_app/features/banner/modules/banners/ui/banners_widget.dart';
import 'package:mazad_app/features/home/ui/home_screen.dart';
import 'package:mazad_app/features/user/config/user_navigator.dart';

class HomeNavigator extends AppNavigatorBase {
  HomeNavigator() : super(name: AppRoutes.home);

  static RouteBase route = ShellRoute(
    builder:
        (context, state, child) => HomeScreen(currentScreen: child),
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.home,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => BannersCubit()..getBanners(),
                ),
                BlocProvider(
                  create: (context) => AuctionsCubit()..load(),
                ),
              ],
              child: Column(
                children: [
                  BannerWidget(),
                  heightSpace(12),
                  Expanded(child: AuctionsScreen()),
                ],
              ),
            ),
      ),
      
      ...UserNavigator.routes,
    ],
  );
}
