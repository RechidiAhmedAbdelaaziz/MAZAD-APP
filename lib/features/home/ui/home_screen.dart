import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/extension/localization.extension.dart';
import 'package:mazad_app/core/localization/localization_button.dart';
import 'package:mazad_app/core/shared/classes/dimensions.dart';
import 'package:mazad_app/core/themes/colors.dart';
import 'package:mazad_app/core/themes/icons.dart';
import 'package:mazad_app/features/auth/logic/auth.cubit.dart';

part 'drawer.dart';

class HomeScreen extends StatelessWidget {
  final Widget currentScreen;
  const HomeScreen({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AppAssets.logo, width: 120.w),
        centerTitle: true,
        backgroundColor: KColors.black,
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: currentScreen,
      ),

      drawer: _Drawer(),
    );
  }
}
