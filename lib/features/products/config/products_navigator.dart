import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mazad_app/core/router/router.dart';
import 'package:mazad_app/core/router/routes.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/products/modules/products/logic/products_cubit.dart';
import 'package:mazad_app/features/products/modules/products/ui/products_screen.dart';
import 'package:mazad_app/features/products/modules/produt/logic/product_cubit.dart';
import 'package:mazad_app/features/products/modules/produt/ui/product_form_screen.dart';

class ProductNavigator extends AppNavigatorBase {
  ProductNavigator.products(AuctionModel auction)
    : super(
        name: AppRoutes.products,
        pathParams: {'auctionId': auction.id!},
      );

  ProductNavigator.productDetail(ProductModel auction)
    : super(
        name: AppRoutes.product,
        pathParams: {'productId': auction.id!},
      );

  ProductNavigator.createProduct()
    : super(name: AppRoutes.productCreate);

  ProductNavigator.editProduct(ProductModel product)
    : super(
        name: AppRoutes.productUpdate,
        pathParams: {'productId': product.id!},
      );

  static List<GoRoute> routes = [
    GoRoute(
      name: AppRoutes.products,
      path: '/auctions/:auctionId/products',
      builder:
          (context, state) => BlocProvider(
            create:
                (_) =>
                    ProductsCubit(state.pathParameters['auctionId']!)
                      ..loadProducts(),
            child: ProductsScreen(),
          ),
    ),

    GoRoute(
      name: AppRoutes.productCreate,
      path: '/product-form',
      builder:
          (context, state) => BlocProvider(
            create: (_) => ProductCubit()..loadDto(),
            child: ProductFormScreen(),
          ),
    ),

    GoRoute(
      name: AppRoutes.productUpdate,
      path: '/product-form/:productId',
      builder:
          (context, state) => BlocProvider(
            create:
                (_) =>
                    ProductCubit()
                      ..loadDto(state.pathParameters['productId']!),
            child: ProductFormScreen(),
          ),
    ),
  ];
}
