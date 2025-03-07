import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/extension/snackbar.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/auto_page_view.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/bid/modules/bids/logic/bids_cubit.dart';
import 'package:mazad_app/features/bid/modules/bids/ui/bids_screen.dart';
import 'package:mazad_app/features/products/data/models/product_model.dart';
import 'package:mazad_app/features/products/modules/produt/logic/product_cubit.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        state.onError(context.showErrorSnackbar);

        state.onSave(context.back);
      },
      child: SafeArea(
        child: Scaffold(
          body:
              !context.select(
                        (ProductCubit cubit) => cubit.state.isLoaded,
                      ) ||
                      context.select(
                        (ProductCubit cubit) => cubit.state.isLoading,
                      )
                  ? Center(child: CircularProgressIndicator())
                  : Builder(
                    builder: (context) {
                      final product =
                          context.read<ProductCubit>().state.product;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            _buildProductPics(product),
                            _buildProductDetails(product, context),
                            BlocProvider(
                              create:
                                  (context) =>
                                      BidsCubit(product.id!)
                                        ..getBids(),
                              child: BidsWidget(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }

  Widget _buildProductDetails(
    ProductModel product,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name ?? '',
            maxLines: 4,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: KColors.dark,
            ),
          ),
          heightSpace(10),
          Text(
            product.description ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              color: KColors.darkGrey,
            ),
          ),
          Divider(color: KColors.lightGrey),
          heightSpace(10),
          Text(
            '${'InStock'.tr(context)} : ${product.stock}',
            style: TextStyle(
              fontSize: 20.sp,
              color: KColors.dark,
              fontWeight: FontWeight.w400,
            ),
          ),
          heightSpace(10),
          Divider(color: KColors.lightGrey),
          heightSpace(10),

          heightSpace(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${'InitialPrice'.tr(context)} : ',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: KColors.darkGrey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${product.price} DA',
                    style: TextStyle(
                      fontSize: 26.sp,
                      color: KColors.dark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: KColors.primary,
                    borderRadius: BorderRadius.circular(16).r,
                  ),
                  child: Icon(
                    Icons.add,
                    color: KColors.white,
                    size: 35.sp,
                  ),
                ),
              ),
            ],
          ),
          heightSpace(10),
        ],
      ),
    );
  }

  Widget _buildProductPics(ProductModel product) {
    return AppPageView(
      height: 500.h,
      autoPlay: false,
      itemBuilder: (url) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 2.w,
            vertical: 4.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45).r,
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.fill,
            ),
          ),
        );
      },

      items: [
        ...product.images ?? <String>[],
        ...product.images ?? <String>[],
      ],
    );
  }
}
