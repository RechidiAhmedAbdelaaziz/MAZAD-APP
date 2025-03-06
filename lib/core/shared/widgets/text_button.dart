import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/themes/colors.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  final Color? color;

  const AppTextButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              color: color ?? KColors.white,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: color ?? KColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
