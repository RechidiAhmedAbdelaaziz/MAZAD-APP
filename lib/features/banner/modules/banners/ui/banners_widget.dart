import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/shared/widgets/auto_page_view.dart';
import 'package:mazad_app/core/themes/colors.dart';

import 'package:mazad_app/features/banner/data/models/banner_model.dart';
import 'package:mazad_app/features/banner/modules/banners/logic/banners_cubit.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = context.watch<BannersCubit>().state.banners;
    return banners.isEmpty
        ? Container()
        : AppPageView<BannerModel>(
          height: 260.h,
          items: banners,
          itemBuilder: (banner) => _BannerItem(banner),
        );
  }
}

class _BannerItem extends StatelessWidget {
  final BannerModel banner;

  const _BannerItem(this.banner);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370.w,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 15.w,
            right: 15.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                color: KColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5.h,
                children: [
                  Text(
                    banner.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: KColors.dark,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: KColors.primary,
                        size: 18.sp,
                      ),
                      Text(
                        banner.region ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: KColors.dark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 5.w,
            right: 5.w,
            child: Container(
              height: 200.h,

              decoration: BoxDecoration(
                // color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(24.r),
                image: DecorationImage(
                  image: NetworkImage(banner.imageUrl ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
