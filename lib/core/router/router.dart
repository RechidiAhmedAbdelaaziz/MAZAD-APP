// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/features/auction/config/auction_route.dart';
import 'package:mazad_app/features/auth/config/auth.route.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';
import 'package:mazad_app/features/banner/config/banner_navigator.dart';
import 'package:mazad_app/features/bid/config/bid_navigator.dart';
import 'package:mazad_app/features/home/config/home_navigator.dart';
import 'package:mazad_app/features/products/config/products_navigator.dart';

import 'routes.dart';

part 'navigator_base.dart';

class AppRouter {
  final routerConfig = GoRouter(
    routes: [
      ...AuthRoute.routes,
      ...AuctionRoute.routes,
      ...BannerNavigator.routes,
      ...HomeNavigator.routes,
      ...ProductNavigator.routes,
      ...BidNavigator.routes,
    ],
    debugLogDiagnostics: true,

    redirect: _handelRedirect,
  );

  static FutureOr<String?> _handelRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    if (AppRoutes.authPaths.contains(state.matchedLocation)) return null;

    final authCubit = locator<AuthCubit>();
    if (await authCubit.isAuthenticated) return null;
    return '/login';
  }
}
