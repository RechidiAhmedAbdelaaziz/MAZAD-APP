import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/banner/data/models/banner_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/features/banner/modules/banner/logic/banner_cubit.dart';
import 'package:mazad_app/features/banner/modules/banners/logic/banners_cubit.dart';

import '../modules/banner/ui/banner_form_screen.dart';
import '../modules/banners/ui/banners_screen.dart';

class BannerNavigator extends AppNavigatorBase {
  BannerNavigator.banners() : super(name: AppRoutes.banners);

  BannerNavigator.bannerCreate()
    : super(name: AppRoutes.bannerCreate);

  BannerNavigator.bannerUpdate(BannerModel banner)
    : super(
        name: AppRoutes.bannerUpdate,
        pathParams: {'id': banner.id!},
      );

  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutes.banners,
      path: '/banners',
      builder:
          (context, state) => BlocProvider(
            create: (context) => BannersCubit()..getBanners(),
            child: BannersScreen(),
          ),
    ),

    GoRoute(
      name: AppRoutes.bannerCreate,
      path: '/banner-form',
      builder:
          (context, state) => BlocProvider(
            create: (context) => BannerCubit()..loadDto(),
            child: const BannerFormScreen(),
          ),
    ),

    GoRoute(
      name: AppRoutes.bannerUpdate,
      path: '/banner-form/:id',
      builder:
          (context, state) => BlocProvider(
            create:
                (context) =>
                    BannerCubit()
                      ..loadDto(state.pathParameters['id']),
            child: const BannerFormScreen(),
          ),
    ),
  ];
}
