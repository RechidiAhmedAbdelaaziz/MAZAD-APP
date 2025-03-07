import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/date_formatter.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/products/config/products_navigator.dart';

import '../logic/auctions_cubit.dart';

class AuctionsScreen extends StatelessWidget {
  const AuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auctions = context.watch<AuctionsCubit>().state.auctions;

    return PaginationBuilder(
      items: auctions,
      itemBuilder: (auction) => _AuctionItem(auction),
      isLoading: context.select(
        (AuctionsCubit cubit) => cubit.state.isLoading,
      ),
      onLoadMore: context.read<AuctionsCubit>().load,
      separator: heightSpace(10),
    );
  }
}

class _AuctionItem extends StatelessWidget {
  final AuctionModel auction;

  const _AuctionItem(this.auction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: KColors.white),
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 5.50,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: KColors.darkGrey,
            ),
            alignment: Alignment.center,
            child: Text(
              auction.title ?? '',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: KColors.white,
              ),
            ),
          ),
          heightSpace(8),
          Row(
            children: [
              Text(
                'EndsAt'.tr(context),
                style: TextStyle(
                  color: KColors.dark,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              widthSpace(4),
              Text(
                auction.endingDate?.toDayMonthYear() ?? '',
                style: TextStyle(
                  color: KColors.dark,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          heightSpace(8),
          Row(
            children: [
              Text(
                '${auction.productsNumber} ${'Products'.tr(context)}',
                style: TextStyle(
                  color: KColors.dark,
                  fontSize: 18.sp,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.location_on,
                color: KColors.primary,
                size: 18.sp,
              ),
              widthSpace(4),
              Text(
                '${auction.region}',
                style: TextStyle(
                  color: KColors.dark,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          heightSpace(8),
          InkWell(
            onTap:
                () => context.to(ProductNavigator.products(auction)),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: KColors.primary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'ShowProducts'.tr(context),
                style: TextStyle(
                  color: KColors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 06 99 44 78 29
