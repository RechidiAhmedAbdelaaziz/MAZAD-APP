import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/bid/modules/bids/logic/bids_cubit.dart';
import 'package:mazad_app/features/bid/modules/bids/ui/bids_screen.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';

class BidNavigator extends AppNavigatorBase {
  BidNavigator.bids(ProductModel product)
    : super(
        name: AppRoutes.bids,
        pathParams: {'productId': product.id.toString()},
      );

  static List<GoRoute> routes = [
    GoRoute(
      path: '/bids/:productId',
      name: AppRoutes.bids,
      builder:
          (context, state) => BlocProvider(
            create:
                (context) =>
                    BidsCubit(state.pathParameters['productId']!)
                      ..getBids(),
            child: BidsScreen(),
          ),
    ),
  ];
}
