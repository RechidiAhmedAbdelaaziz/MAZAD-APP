import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/extension/navigator.extension.dart';
import 'package:mazad_app/core/localization/localization_cubit.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/core/themes/icons.dart';
import 'package:mazad_app/features/auction/config/auction_navigator.dart';
import 'package:mazad_app/features/banner/config/banner_navigator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AppAssets.logo, width: 100.w),
        centerTitle: true,
        backgroundColor: KColors.black,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.language, color: KColors.primary),
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: 'en', child: Text('English')),
                PopupMenuItem(value: 'fr', child: Text('Français')),
              ];
            },
            onSelected: (String langCode) {
              context.read<LocalizationCubit>().changeLanguage(
                langCode,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: Column(
          spacing: 12.h,
          children:
              [
                _HomeItem(
                  title: 'AuctinosGestion'.tr(context),
                  onTap:
                      () => context.to(AuctionNavigator.auctions()),
                ),
                _HomeItem(
                  title: 'BannersGestion'.tr(context),
                  onTap: () => context.to(BannerNavigator.banners()),
                ),
              ].map(_buildItem).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(_HomeItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: KColors.lightGrey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          spacing: 5.w,
          children: [
            Icon(Icons.settings),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class _HomeItem {
  final String title;
  final VoidCallback onTap;

  _HomeItem({required this.title, required this.onTap});
}
