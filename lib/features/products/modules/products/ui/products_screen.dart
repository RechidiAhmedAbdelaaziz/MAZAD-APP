import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/bid/config/bid_navigator.dart';
import 'package:mazad_app/features/products/config/products_navigator.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/products/modules/products/logic/products_cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductsCubit>().state.products;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'.tr(context)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.toWith<ProductModel>(
                ProductNavigator.createProduct(),
                onResult: context.read<ProductsCubit>().addProduct,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 8.h,
        ),
        child: PaginationBuilder(
          items: products,
          itemBuilder:
              (product) => InkWell(
                onTap: () => context.to(BidNavigator.bids(product)),
                child: _buildProductItem(product, context),
              ),
          isLoading: context.select(
            (ProductsCubit cubit) => cubit.state.isLoading,
          ),
          onLoadMore: context.read<ProductsCubit>().loadProducts,
          separator: heightSpace(10),
        ),
      ),
    );
  }

  Widget _buildProductItem(
    ProductModel product,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16).r,
        border: Border.all(color: KColors.dark),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60.r,
            width: 60.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              image: DecorationImage(
                image: NetworkImage(
                  product.images?.firstOrNull ?? '',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                heightSpace(8),
                Text(
                  product.category?.tr(context) ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                heightSpace(4),
                Text(
                  '${product.price} DZD',
                  style: TextStyle(
                    color: KColors.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) => _buildOptions(context, product),
          ),
        ],
      ),
    );
  }

  List<PopupMenuEntry> _buildOptions(
    BuildContext context,
    ProductModel product,
  ) {
    return [
      PopupMenuItem(
        child: Text('Edit'.tr(context)),
        onTap:
            () => context.toWith<ProductModel>(
              ProductNavigator.editProduct(product),
              onResult: context.read<ProductsCubit>().updateProduct,
            ),
      ),
      PopupMenuItem(
        child: Text('Delete'.tr(context)),
        onTap:
            () => context.alertDialog(
              title: 'Delete'.tr(context),
              content: 'DeleteConfirmation'.tr(context),
              onConfirm:
                  () => context.read<ProductsCubit>().removeProduct(
                    product,
                  ),
            ),
      ),
    ];
  }
}
