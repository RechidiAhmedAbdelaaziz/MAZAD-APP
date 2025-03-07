import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/themes/colors.dart';

import 'localization_cubit.dart';

class LocalizationButton extends StatelessWidget {
  const LocalizationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Container(
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: KColors.white, width: 2),
        ),
        child: Text(
          context
                  .watch<LocalizationCubit>()
                  .state
                  ?.languageCode
                  .toUpperCase() ??
              'EN',
          style: TextStyle(
            color: KColors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(value: 'en', child: Text('English')),
          PopupMenuItem(value: 'fr', child: Text('Français')),
        ];
      },
      onSelected: (String langCode) {
        context.read<LocalizationCubit>().changeLanguage(langCode);
      },
    );
  }
}
