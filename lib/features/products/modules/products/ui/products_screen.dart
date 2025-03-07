import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
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
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 8.h,
        ),
        child: PaginationGridBuilder(
          items: products,
          itemBuilder:
              (product) => InkWell(
                onTap:
                    () => context.to(
                      ProductNavigator.productDetail(product),
                    ),
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
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(20).r,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 6,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 190.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(product.images?.first ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              spacing: 10.h,
              children: [
                Text(
                  product.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: KColors.dark,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${'Quantity'.tr(context)}: ${product.stock ?? 0}',
                  style: TextStyle(
                    color: KColors.darkGrey,
                    fontSize: 15.sp,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${product.price ?? 0} DA',
                      style: TextStyle(
                        color: KColors.dark,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    //show more button
                    InkWell(
                      onTap:
                          () => context.to(
                            ProductNavigator.productDetail(product),
                          ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: KColors.primary,
                        size: 20.sp,
                      ),
                    ),
                  ],
                ),
                heightSpace(0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
