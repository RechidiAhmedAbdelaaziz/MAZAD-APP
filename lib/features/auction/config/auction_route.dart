import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/auction/modules/auctionform/logic/auction_form_cubit.dart';
import 'package:mazad_app/features/auction/modules/auctionform/ui/auction_form.dart';
import 'package:mazad_app/features/auction/modules/auctions/logic/auctions_cubit.dart';
import 'package:mazad_app/features/auction/modules/auctions/ui/auctions_screen.dart';

abstract class AuctionRoute {
  static List<GoRoute> routes = [
    // Auctions
    GoRoute(
      path: '/auctions',
      name: AppRoutes.auctions,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AuctionsCubit()..load(),
            child: AuctionsScreen(),
          ),
    ),

    // Auction Form (Create Auction)
    GoRoute(
      path: '/auction-form',
      name: AppRoutes.auctionCreate,
      builder:
          (context, state) => BlocProvider(
            create: (context) => AuctionFormCubit()..loadDto(),
            child: AuctionFormScreen(),
          ),
    ),

    // Auction Form (Edit Auction)
    GoRoute(
      path: '/auction-form/:id',
      name: AppRoutes.auctionUpdate,
      builder:
          (context, state) => BlocProvider(
            create:
                (context) =>
                    AuctionFormCubit()
                      ..loadDto(state.pathParameters['id']),
            child: AuctionFormScreen(),
          ),
    ),
  ];
}
