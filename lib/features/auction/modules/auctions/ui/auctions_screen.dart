import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/date_formatter.extension.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/auction/config/auction_navigator.dart';
import 'package:mazad_app/features/auction/data/models/auction_model.dart';
import 'package:mazad_app/features/products/config/products_navigator.dart';

import '../logic/auctions_cubit.dart';

class AuctionsScreen extends StatelessWidget {
  const AuctionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auctions = context.watch<AuctionsCubit>().state.auctions;

    return Scaffold(
      appBar: AppBar(
        title: Text('Auctions'.tr(context)),

        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.toWith<AuctionModel>(
                AuctionNavigator.createAuction(),
                onResult: context.read<AuctionsCubit>().add,
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
          items: auctions,
          itemBuilder:
              (auction) => InkWell(
                onTap:
                    () => context.to(
                      ProductNavigator.products(auction),
                    ),
                child: _AuctionItem(auction),
              ),
          isLoading: context.select(
            (AuctionsCubit cubit) => cubit.state.isLoading,
          ),
          onLoadMore: context.read<AuctionsCubit>().load,
          separator: heightSpace(10),
        ),
      ),
    );
  }
}

class _AuctionItem extends StatelessWidget {
  final AuctionModel auction;

  const _AuctionItem(this.auction);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.to(ProductNavigator.products(auction)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: KColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: KColors.lightGrey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auction.title ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  heightSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: KColors.darkGrey,
                        size: 16.sp,
                      ),
                      Text(
                        auction.region ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KColors.dark,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${auction.productsNumber.toString()} ${'Products'.tr(context)}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  heightSpace(8),
                  Row(
                    children: [
                      Text(
                        auction.endingDate?.toDayMonthYear() ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KColors.darkGrey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${auction.subscriptionPrice} DZD',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KColors.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              itemBuilder: _buildOptions,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  List<PopupMenuItem<dynamic>> _buildOptions(BuildContext context) =>
      [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.edit, color: KColors.dark),
              Text('Edit'.tr(context)),
            ],
          ),
          onTap: () {
            context.toWith<AuctionModel>(
              AuctionNavigator.updateAuction(auction),
              onResult: context.read<AuctionsCubit>().update,
            );
          },
        ),

        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.delete, color: KColors.red),
              Text('Delete'.tr(context)),
            ],
          ),
          onTap: () {
            context.alertDialog(
              title: 'Deleting',
              content: 'DeleteConfirmation',
              okText: 'Delete',
              onConfirm: () {
                context.read<AuctionsCubit>().remove(auction);
              },
            );
          },
        ),
      ];
}

// 06 99 44 78 29
