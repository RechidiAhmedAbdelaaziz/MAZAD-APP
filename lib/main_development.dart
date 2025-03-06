import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/app.dart';
import 'package:mazad_app/core/di/locator.dart';
import 'package:mazad_app/core/themes/colors.dart';

void main() async {
  // Define the flavor
  FlavorConfig(
    name: "DEV",
    color: KColors.primary,
    location: BannerLocation.topEnd,
    variables: {"baseUrl": "http://192.168.1.9:3000/api/v1"},
  );

  // Initialize the ScreenUtil
  WidgetsFlutterBinding.ensureInitialized();

  // Setup the dependency injection
  await setupLocator();

  // Ensure the screen size is set
  await ScreenUtil.ensureScreenSize();

  runApp(const TenderApp());
}
