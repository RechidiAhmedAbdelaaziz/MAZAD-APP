import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/bid/data/model/bid_model.dart';
import 'package:mazad_app/features/bid/modules/bids/logic/bids_cubit.dart';

class BidsWidget extends StatelessWidget {
  const BidsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bids = context.watch<BidsCubit>().state.bids;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child:
          bids.isEmpty
              ? SizedBox.shrink()
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    '${'OffersProposed'.tr(context)} :',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: KColors.darkGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  PaginationBuilder(
                    items: bids,
                    itemBuilder:
                        (bid) => Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  (bids.indexOf(bid) + 1).toString(),
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(child: _BidItem(bid)),
                              ],
                            ),
                            Divider(),
                          ],
                        ),
                    isLoading: context.select(
                      (BidsCubit cubit) => cubit.state.isLoading,
                    ),

                    separator: heightSpace(8),
                  ),
                ],
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
        // color: KColors.white,
        borderRadius: BorderRadius.circular(12.r),
        // border: Border.all(color: KColors.lightGrey),
      ),
      child: Row(
        // spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUserInfo(),
          const Spacer(),
          _buildBidInfo(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,

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
            Icon(Icons.location_on, size: 16.sp),
            Text(
              bid.user?.region ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                color: KColors.darkGrey,
              ),
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
            color: KColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(' DA'.tr(context), style: TextStyle(fontSize: 18.sp)),
      ],
    );
  }
}
