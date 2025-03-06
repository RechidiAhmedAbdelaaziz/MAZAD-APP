import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/extension/dialog.extension.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/shared/widgets/pagination_builder.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/features/banner/config/banner_navigator.dart';
import 'package:mazad_app/features/banner/data/models/banner_model.dart';
import 'package:mazad_app/features/banner/modules/banners/logic/banners_cubit.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = context.watch<BannersCubit>().state.banners;
    return Scaffold(
      appBar: AppBar(
        title: Text('Banners'.tr(context)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.toWith<BannerModel>(
                BannerNavigator.bannerCreate(),
                onResult: context.read<BannersCubit>().addBanner,
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
          items: banners,
          itemBuilder: (banner) => _BannerItem(banner),
          isLoading: context.select(
            (BannersCubit cubit) => cubit.state.isLoading,
          ),
          onLoadMore: context.read<BannersCubit>().getBanners,
          separator: const Divider(),
        ),
      ),
    );
  }
}

class _BannerItem extends StatelessWidget {
  final BannerModel banner;

  const _BannerItem(this.banner);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        border: Border.all(color: KColors.darkGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.h,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Text(
                      '  ${banner.title ?? ''}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 20.sp),
                        Text(banner.region ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton(itemBuilder: _optionsBuiler),
            ],
          ),
          Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: NetworkImage(banner.imageUrl ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PopupMenuEntry> _optionsBuiler(BuildContext context) {
    return [
      PopupMenuItem(
        onTap: () {
          context.toWith<BannerModel>(
            BannerNavigator.bannerUpdate(banner),
            onResult: context.read<BannersCubit>().updateBanner,
          );
        },
        child: Text('Edit'.tr(context)),
      ),
      PopupMenuItem(
        onTap:
            () => context.alertDialog(
              title: 'Delete'.tr(context),
              content: 'DeleteConfirmation'.tr(context),
              onConfirm:
                  () => context.read<BannersCubit>().removeBanner(
                    banner,
                  ),
            ),
        child: Text('Delete'.tr(context)),
      ),
    ];
  }
}
