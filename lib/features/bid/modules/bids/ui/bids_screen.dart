import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/bid/data/model/bid_model.dart';
import 'package:mazad_app/features/bid/modules/bids/logic/bids_cubit.dart';
import 'package:mazad_app/features/products/config/products_navigator.dart';

class BidsScreen extends StatelessWidget {
  const BidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bids = context.watch<MyBidsCubit>().state.bids;
    return PaginationBuilder(
      items: bids,
      itemBuilder:
          (bid) => InkWell(
            onTap:
                () => context.to(
                  ProductNavigator.productDetail(bid.product!),
                ),
            child: _BidItem(bid: bid),
          ),
      isLoading: context.select(
        (MyBidsCubit cubit) => cubit.state.isLoading,
      ),
      separator: heightSpace(12),
    );
  }
}

class _BidItem extends StatelessWidget {
  final BidModel bid;

  const _BidItem({required this.bid});

  @override
  Widget build(BuildContext context) {
    final product = bid.product!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(30).r,
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 90.r,
                width: 90.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20).r,
                  image: DecorationImage(
                    image: NetworkImage(product.images!.first),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              widthSpace(12),
              Expanded(
                child: SizedBox(
                  height: 90.r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        '${'Quantity'.tr(context)}: ${product.stock}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: KColors.darkGrey,
                        ),
                      ),

                      Text(
                        '${product.price} DA',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: KColors.dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          heightSpace(12),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: KColors.primary,
              borderRadius: BorderRadius.circular(12).r,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${bid.amount} DA',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: KColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Text(
                  '${'Quantity'.tr(context)}: ${bid.quantity}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: KColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
