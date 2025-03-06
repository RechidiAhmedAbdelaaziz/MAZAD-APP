import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/auction/modules/auctions/logic/auctions_cubit.dart';

class AuctionSelector extends StatelessWidget {
  const AuctionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuctionsCubit()..load(),
      child: Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 32.h,
        ),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Text(
              'Auctions'.tr(context),
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: KColors.dark,
              ),
            ),
            _Items(),
          ],
        ),
      ),
    );
  }
}

class _Items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auctions = context.select(
      (AuctionsCubit cubit) => cubit.state.auctions,
    );

    return PaginationBuilder(
      items: auctions,
      itemBuilder:
          (auctions) => InkWell(
            onTap: () => context.back(auctions),
            child: _buildAuctionItem(auctions),
          ),
      isLoading: context.select(
        (AuctionsCubit cubit) => cubit.state.isLoading,
      ),
      onLoadMore: context.read<AuctionsCubit>().load,
      separator: heightSpace(10),
    );
  }

  Widget _buildAuctionItem(AuctionModel item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: KColors.lightGrey,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: KColors.dark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title ?? '',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: KColors.dark,
            ),
          ),
          heightSpace(8),
          Row(
            children: [
              Icon(Icons.location_on),
              Text(
                item.region ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: KColors.darkGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
