import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazad_app/core/localization/localization_cubit.dart';

import 'core/di/locator.dart';
import 'core/localization/app_localization.dart';
import 'core/router/router.dart';

class TenderApp extends StatelessWidget {
  final bool isProduction;
  const TenderApp({super.key, this.isProduction = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ScreenUtilInit(
          designSize:
              constraints.maxWidth < 600
                  ? const Size(430, 932)
                  : const Size(1920, 1080),

          builder: (_, __) {
            return BlocProvider(
              create: (context) => LocalizationCubit(),
              child:
                  isProduction
                      ? _MaterialApp()
                      : FlavorBanner(child: _MaterialApp()),
            );
          },
        );
      },
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();

    final local = context.watch<LocalizationCubit>().state;

    return MaterialApp.router(
      routerConfig: router.routerConfig,
      theme: ThemeData(fontFamily: 'Roboto'),
      supportedLocales: [
        Locale('fr'), // French
        Locale('en'), // English
        // Locale('ar'), // Arabic
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: local,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null &&
            supportedLocales.any(
              (element) =>
                  element.languageCode == locale.languageCode,
            )) {
          return locale;
        }
        // If the current device locale is not supported, use the first one
        return supportedLocales.first;
      },
    );
  }
}
