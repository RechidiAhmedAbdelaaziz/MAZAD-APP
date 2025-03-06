import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/bid/data/model/bid_model.dart';
import 'package:mazad_app/features/bid/modules/bids/logic/bids_cubit.dart';

class BidsScreen extends StatelessWidget {
  const BidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bids = context.select(
      (BidsCubit cubit) => cubit.state.bids,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Bids')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: PaginationBuilder(
          items: bids,
          itemBuilder: (bid) => _BidItem(bid),
          isLoading: context.select(
            (BidsCubit cubit) => cubit.state.isLoading,
          ),
          onLoadMore: context.read<BidsCubit>().getBids,
          separator: const Divider(),
        ),
      ),
    );
  }
}

class _BidItem extends StatelessWidget {
  final BidModel bid;

  const _BidItem(this.bid);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: KColors.lightGrey),
      ),
      child: Column(
        // spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUserInfo(),
          const Divider(),
          _buildBidInfo(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(
          bid.user?.name ?? '',
          maxLines: 1,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        Row(
          spacing: 4.w,
          children: [
            Icon(Icons.phone, size: 16.sp),
            Text(
              bid.user?.phone ?? '',
              style: TextStyle(fontSize: 18.sp, color: KColors.dark),
            ),
            const Spacer(),
            Icon(Icons.location_on, size: 16.sp),
            Text(
              bid.user?.region ?? '',
              style: TextStyle(fontSize: 18.sp, color: KColors.dark),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBidInfo(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${bid.amount}',
          style: TextStyle(
            fontSize: 22.sp,
            color: KColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(' DA'.tr(context), style: TextStyle(fontSize: 18.sp)),
        const Spacer(),
        Text(
          'Quantity:  '.tr(context),
          style: TextStyle(fontSize: 16.sp),
        ),
        Text(
          '${bid.quantity}',
          style: TextStyle(
            fontSize: 22.sp,
            color: KColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
